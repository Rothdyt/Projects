·import pickle as pkl
import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.pyplot as plt
from scipy.special import gammaln, psi
from matplotlib.patches import Ellipse
import os
from numpy.linalg import det, inv, eigh, slogdet
import math

# r_prime initialization


def r_prime_init(N, method="dirichlet", **kwargs):
    """
    Initialize the responsibility.
    @ N: number of data points
    @ method: dirichlet prior or Kmeans esimation
    """
    if method == "kmeans":
        K = kwargs["K"]
        random_state = kwargs["random_state"]
        data = kwargs["data"]
        r_prime = 0.1 / (K - 1) * np.ones((N, K))
        model = KMeans(K, random_state).fit(data)
        label = model.predict(data)
        for i, j in enumerate(label):
            r_prime[i, j] = 0.9
        pass
    elif method == "dirichlet":
        alpha_0 = kwargs["alpha_0"]
        r_prime = np.random.dirichlet(alpha_0, N)
    return r_prime

# r_prime update


def exp_softmax(x):
    exp_x = np.exp(x-np.max(x))
    total = np.sum(exp_x)
    return (exp_x + np.finfo(np.float32).eps)/(total + np.finfo(np.float32).eps)


def update_r_prime(data, alpha_prime, w_inv_prime, nu_prime, beta_prime, m_prime, N, D, K):
    update = np.zeros((N, K))
    alpha = np.sum(alpha_prime)
    for n in range(N):
        for k in range(K):
            update[n, k] = psi(alpha_prime[k] + np.finfo(np.float32).eps) - psi(alpha)
            update[n, k] += D*np.log(2)/2
            update[n, k] -= np.log(det(w_inv_prime[k]))/2
            update[n, k] += np.sum([psi((nu_prime[k] / 2) + ((1 - i) / 2)) for i in range(D)])/2
            update[n, k] -= D/beta_prime[k]/2 + nu_prime[k]*np.dot(np.dot(data[n, :]-m_prime[k], inv(w_inv_prime[k])), (data[n, :]-m_prime[k]).reshape(1, -1).T)/2
        update[n, :] = exp_softmax(update[n, :])
    return update


def log_C(x):
    """
    ln C(x) = ln(Gamma(sum(x))) - sum(ln(Gamma(x)))
    """
    return gammaln(np.sum(x + np.finfo(np.float32).eps)) - np.sum(gammaln(x + np.finfo(np.float32).eps))


def log_B(W, nu, D):
    """
    """
    logdet = np.log(np.linalg.det(W))
    log_gamma_summation = np.sum([gammaln((nu+1 - (i+1))/2.) for i in range(D)], axis=0)
    log_B = nu/2*logdet + nu*D*np.log(2) / 2 + D*(D-1)*np.log(np.pi) / 4 + log_gamma_summation
    return -log_B


def elbo(xn, alpha_0, alpha_prime, r_prime, m_0, lambda_m, beta_0,
         lambda_beta, nu_0, lambda_nu, w_0, lambda_w, N, D, K):
    """
    ELBO computation
    """
    # initialize
    expectation_ln_p_x_z_mu_Lambda = expectation_ln_p_z_pi = expectation_ln_q_z = 0

    expectation_log_pi = psi(alpha_prime + np.finfo(np.float32).eps) - psi(np.sum(alpha_prime))
    expectation_ln_p_pi = log_C(alpha_0) + np.dot((alpha_0-np.ones(K)), expectation_log_pi)
    expectation_ln_q_pi = log_C(alpha_prime) + np.dot((alpha_prime-np.ones(K)), expectation_log_pi)
    logdet = np.log(np.array([det(lambda_w[k, :, :]) for k in range(K)]))
    psi_D_summation = np.sum([psi((lambda_nu + 1 - (i+1))/2) for i in range(D)], axis=0)
    logDeltak = psi_D_summation + D * np.log(2) + logdet

    for n in range(N):
        expectation_ln_p_z_pi += np.dot(r_prime[n, :], expectation_log_pi)
        expectation_ln_q_z += np.dot(r_prime[n, :], np.log(r_prime[n, :] + np.finfo(np.float32).eps))

        product = np.array([np.dot(np.dot(xn[n, :]-lambda_m[k, :], lambda_w[k, :, :]),
                                   (xn[n, :]-lambda_m[k, :]).T) for k in range(K)])
        expectation_ln_p_x_z_mu_Lambda += 1/2 * np.dot(r_prime[n, :],
                                                       (logDeltak - D*np.log(2*np.pi) -
                                                        lambda_nu*product - D/lambda_beta).T)
    part0 = np.sum(D * np.log(lambda_beta) / 2 + 1/2*logDeltak - D/2 - D * np.log(2*np.pi)/2)
    entropy = 0
    for k in range(K):
        entropy += - log_B(lambda_w[k, :, :], lambda_nu[k], D) - (lambda_nu[k] - D - 1) * logDeltak[k] / 2 + (lambda_nu[k] * D) / 2

    expectation_ln_q_mu_Lambda = part0 - entropy
    product = np.array([np.dot(np.dot(lambda_m[k, :]-m_0, lambda_w[k, :, :]),
                               (lambda_m[k, :]-m_0).T) for k in range(K)])
    part1 = np.sum((1/2*(D*np.log(beta_0) + logDeltak - D*np.log(2*np.pi)
                         - beta_0*lambda_nu*product - D*beta_0/lambda_beta)))

    logB_0 = log_B(w_0, nu_0, D)
    traces = np.array([np.trace(np.dot(inv(w_0), lambda_w[k, :, :])) for k in range(K)])
    part2 = np.sum((logB_0 + (nu_0-3)/2*logDeltak - lambda_nu/2*traces))
    expectation_ln_p_mu_Lambda = part1 + part2
    return expectation_ln_p_pi + expectation_ln_p_z_pi + expectation_ln_p_x_z_mu_Lambda + \
        expectation_ln_p_mu_Lambda - expectation_ln_q_pi - \
        expectation_ln_q_z - expectation_ln_q_mu_Lambda


def multivariate_t_distribution(x, mu, Sigma, df, D):
    '''
    Multivariate t-student density. Returns the density
    of the function at points specified by x.

    input:
        x = parameter (n x d numpy array)
        mu = mean (d dimensional numpy array)
        Sigma = scale matrix (d x d numpy array)
        df = degrees of freedom
    '''
    p = D
    dec = np.linalg.cholesky(Sigma)
    R_x_m = np.linalg.solve(dec, np.matrix.transpose(x)-mu)
    rss = np.power(R_x_m, 2).sum(axis=0)
    logretval = math.lgamma(1.0*(p + df)/2) - (math.lgamma(1.0*df/2) + np.sum(np.log(dec.diagonal()))
                                               + p/2 * np.log(math.pi * df)) - 0.5 * (df + p) * math.log1p((rss/df))
    return np.exp(logretval)


def predictive_density(x, m, W, alpha, beta, nu, D, K):
    p = 0
    for k in range(K):
        Lk = (nu[k] + 1 - D) * beta[k] / (1 + beta[k]) * W[k, :, :]
        p += alpha[k] * multivariate_t_distribution(x, m[k], Lk, nu[k]+1-D, D)
    return p / np.sum(alpha)


def create_cov_ellipse(cov, pos, nstd=1, **kwargs):

    def eigsorted(cov):
        vals, vecs = np.linalg.eigh(cov)
        order = vals.argsort()[::-1]
        return vals[order], vecs[:, order]

    vals, vecs = eigsorted(cov)
    theta = np.degrees(np.arctan2(*vecs[:, 0][::-1]))
    if vals[0] < 0 or vals[1] < 0:
        return None
    else:
        width, height = 2 * nstd * np.sqrt(vals)
        ellip = Ellipse(xy=pos, width=width, height=height, angle=theta, **kwargs)

        return ellip


def plot_iteration(ax_spatial, circs, sctZ, lambda_m, cov, xn, n_iters, K):
    """
    Plot the Gaussians in every iteration
    """
    if n_iters == 0:
        plt.scatter(xn[:, 0], xn[:, 1], cmap=cm.gist_rainbow, s=5)
        sctZ = plt.scatter(lambda_m[:, 0], lambda_m[:, 1],
                           color='black', s=5)
    else:
        for circ in circs:
            circ.remove()
        circs = []
        for k in range(K):
            if type(cov) is list:
                circ = create_cov_ellipse(cov[k], lambda_m[k, :],
                                          color='C{}'.format(k), alpha=0.2)
            else:
                circ = create_cov_ellipse(cov, lambda_m[k, :],
                                          color='C{}'.format(k), alpha=0.2)
            if circ is not None:
                circs.append(circ)
                ax_spatial.add_artist(circ)
        sctZ.set_offsets(lambda_m)
    plt.yticks(fontsize=16)
    plt.xticks(fontsize=16)
    plt.draw()
    plt.pause(0.001)
    return ax_spatial, circs, sctZ
