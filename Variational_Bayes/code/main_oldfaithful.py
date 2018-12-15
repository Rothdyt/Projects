from matplotlib.patches import Ellipse
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.datasets import make_spd_matrix
from scipy.special import gammaln, psi
import numpy as np
from numpy.linalg import det, inv, eigh
from utils import update_r_prime, r_prime_init, plot_iteration, elbo, predictive_density
import os
from os.path import isfile, join
import imageio
import pickle

base = "./outputs/"
figs = base + "old_faithful/"
model_url = base + "model/"
if not os.path.exists(base):
    os.makedirs(base)
if not os.path.exists(figs):
    os.makedirs(figs)
if not os.path.exists(model_url):
    os.makedirs(model_url)

#read in dataset
data = pd.read_csv('./data/oldfaithful.csv')
xn = []
for i in range(data.shape[0]):
    xn.append(list(data.iloc[i]))
xn = np.array(xn)
# D for dimension, N for data size
N, D = data.shape
data = np.array(data)
# number of cluster
K = 6

# priors for pi
alpha_0 = np.ones((K,))  # concentration para for \pi
# prior for cov matrix(wishart distribution)
nu_0 = np.array([D])  # prior degree of freedom
w_0_inv = inv(make_spd_matrix(D))  # prior scale matrix
# prior for mu(normal distribution)
m_0 = np.zeros((D,))  # mean for mu, dimension D
beta_0 = np.array([0.9])  # adjustment for variance for cov matrix, dimension 1

# variational parameter
# assignment parameter
r_prime = r_prime_init(N, method="dirichlet", alpha_0=alpha_0)
#r_prime = np.random.dirichlet(N, method="dirichlet", alpha_0=alpha_0)
alpha_prime = np.zeros(shape=K)
# parameter for mu and cov matrix
nu_prime = np.zeros(shape=K)
w_inv_prime = np.zeros(shape=(K, D, D))
beta_prime = np.zeros(shape=K)
m_prime = lambda_m = np.zeros(shape=(K, D))

plt.ion()
plt.style.use('seaborn-darkgrid')
fig = plt.figure(figsize=(10, 10))
ax_spatial = fig.add_subplot(1, 1, 1)
circs = []
sctZ = None
lbs = []
log_predivtive = []
# parameter update
for step in range(70):
    Nk = np.sum(r_prime, axis=0)
    alpha_prime = alpha_0 + Nk
    beta_prime = beta_0 + Nk
    nu_prime = nu_0 + Nk
    # calculate xk
    xk = np.zeros((K, D))
    for k in range(K):
        for j in range(D):
            d = np.array(data[:, j].flatten())
            xk[k][j] = d.dot(r_prime[:, k])/Nk[k]
    # update m prime
    for k in range(K):
        m_prime[k, :] = (beta_0*m_0 + Nk[k]*xk[k, :])/beta_prime[k]
    # update w_inv prime
    for k in range(K):
        Sk = np.zeros((2, 2))
        para = beta_0*Nk[k]/(beta_0+Nk[k])
        for n in range(N):
            Sk += r_prime[n, k]*(data[n, :]-xk[k, :]).reshape(1, -1).T*(data[n, :]-xk[k, :]).reshape(1, -1)/Nk[k]
        w_inv_prime[k] = w_0_inv + Nk[k]*Sk + para*(xk[k, :]-m_0).reshape(1, -1).T*(xk[k, :]-m_0).reshape(1, -1)
    r_prime = update_r_prime(data, alpha_prime, w_inv_prime, nu_prime, beta_prime, m_prime, N, D, K)

    variance = w_inv_prime
    lambda_nu = nu_prime
    lambda_m = m_prime
    lambda_beta = beta_prime
    lb = elbo(xn, alpha_0, alpha_prime, r_prime, m_0,
              lambda_m, beta_0, lambda_beta, nu_0,
              lambda_nu, inv(w_0_inv), inv(variance), N, D, K)
    lbs.append(lb)

    covs = [variance[k, :, :] / (lambda_nu[k] - D - 1)
            for k in range(K)]

    ax_spatial, circs, sctZ = plot_iteration(ax_spatial, circs,
                                             sctZ, lambda_m,
                                             covs, xn,
                                             step, K)
    summation = 0
    for x in xn:
        summation += np.log(predictive_density(x, lambda_m, inv(variance), alpha_prime, beta_prime, lambda_nu, D, K))
    log_predivtive.append(summation / xn.shape[0])
    if step % 10 == 0:
        plt.savefig(figs + "iter_{}.png".format(step), dpi=400)
plt.savefig(figs + "final.png", dpi=400)


img_folder = figs
imgs = [f for f in os.listdir(img_folder) if isfile(join(img_folder, f))]
imgs.pop(0)
images = []
for img in imgs:
    images.append(imageio.imread(figs + "{}".format(img)))
kargs = {'duration': 0.5}
imageio.mimsave(figs+'process.gif', images, **kargs)

model = {"mean": lambda_m, "var": covs, "elbo": lbs, "predictive": log_predivtive}

with open(model_url + 'old_faithful.pickle', 'wb') as handle:
    pickle.dump(model, handle)

fig = plt.figure(figsize=(8, 4))
ax = fig.add_subplot(111)
plt.plot(range(len(lbs)), lbs)
plt.xlabel("Iteration", fontsize=13)
plt.ylabel("ELBO", fontsize=13)
plt.yticks(fontsize=13)
plt.xticks(fontsize=13)
plt.savefig(figs + "elbo.png", dpi=400)


fig = plt.figure(figsize=(8, 4))
ax = fig.add_subplot(111)
plt.plot(range(len(log_predivtive)), log_predivtive)
plt.xlabel("Iteration", fontsize=13)
plt.ylabel("Average Log Predictive", fontsize=13)
plt.yticks(fontsize=13)
plt.xticks(fontsize=13)
plt.savefig(figs + "pred_density.png", dpi=400)
