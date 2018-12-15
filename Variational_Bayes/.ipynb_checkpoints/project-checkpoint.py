import pickle as pkl
import pandas as pd
import numpy as np
from scipy import random
from sklearn.cluster import KMeans
from sklearn.datasets import make_spd_matrix
from scipy.special import gammaln, psi
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import Ellipse
from numpy.linalg import det, inv, eigh
from viz import *

#r_prime initialization
def r_prime_init(data, N, K, random_state=525):
    r_prime = 0.1 / (K - 1) * np.ones((N, K))
    model = KMeans(K, random_state = 525).fit(data)
    label = model.predict(data)
    for i, j in enumerate(label):
        r_prime[i, j] = 0.9
    return r_prime

#r_prime update
def exp_softmax(x):
    exp_x = np.exp(x-np.max(x))
    total = np.sum(exp_x)
    return (exp_x+ np.finfo(np.float32).eps)/(total+ np.finfo(np.float32).eps)
def update_r_prime(alpha_prime, w_inv_prime, N, K):
    update = np.zeros((N,K))
    alpha = np.sum(alpha_prime)
    for n in range(N):
        for k in range(K):
            update[n,k] = psi(alpha_prime[k] + np.finfo(np.float32).eps) - psi(alpha)
            update[n,k] += D*np.log(2)/2
            update[n,k] -= np.log(det(w_inv_prime[k]))/2
            update[n,k] += np.sum([psi((nu_prime[k] / 2) + ((1 - i) / 2)) for i in range(D)])/2
            update[n,k] -= D/beta_prime[k]/2 + nu_prime[k]*np.dot(np.dot(data[n,:]-m_prime[k],inv(w_inv_prime[k])),(data[n,:]-m_prime[k]).reshape(1,-1).T)/2
        update[n,:] = exp_softmax(update[n,:])
    return update

#read in dataset
data = pd.read_csv('oldfaithful.csv')
xn = []
for i in range(data.shape[0]):
    xn.append(list(data.iloc[i]))
xn = np.array(xn)
#D for dimension, N for data size
N, D = data.shape
data = np.array(data)
#number of cluster
K = 6

#priors for pi
np.random.seed(525)
alpha_0 = np.array([float(1)]*K)   #concentration para for \pi
#prior for cov matrix(wishart distribution)
nu_0 = np.array([float(D)])        #prior degree of freedom
w_0_inv = inv(make_spd_matrix(D))         #prior scale matrix
#prior for mu(normal distribution)
m_0 = np.array(([float(0)] * D))     #mean for mu, dimension D
beta_0 = np.array([0.9])           #adjustment for variance for cov matrix, dimension 1

#variational parameter
#assignment parameter
r_prime = r_prime_init(data, N, K)
alpha_prime = np.zeros(shape=K)
#parameter for mu and cov matrix
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
#parameter update
for step in range(40):
    print(step)
    Nk = np.sum(r_prime,axis = 0)
    alpha_prime = alpha_0 + Nk
    beta_prime = beta_0 + Nk
    nu_prime = nu_0 + Nk
    #calculate xk
    xk = np.zeros((K,D))
    for k in range(K):
        for j in range(D):
            d = np.array(data[:,j].flatten())
            xk[k][j] = d.dot(r_prime[:,k])/Nk[k]
    #update m prime
    for k in range(K):
        m_prime[k,:] = (beta_0*m_0 + Nk[k]*xk[k,:])/beta_prime[k]
    #update w_inv prime
    for k in range(K):
        Sk = np.zeros((2,2))
        para = beta_0*Nk[k]/(beta_0+Nk[k])
        for n in range(N):
            Sk += r_prime[n,k]*(data[n,:]-xk[k,:]).reshape(1,-1).T*(data[n,:]-xk[k,:]).reshape(1,-1)/Nk[k]
        w_inv_prime[k] =  w_0_inv + Nk[k]*Sk + para*(xk[k,:]-m_0).reshape(1,-1).T*(xk[k,:]-m_0).reshape(1,-1)
    r_prime = update_r_prime(alpha_prime, w_inv_prime, N, K)
    
    lambda_w = w_inv_prime
    lambda_nu = nu_prime
    lambda_m = m_prime
    covs = [lambda_w[k, :, :] / (lambda_nu[k] - D - 1)
                            for k in range(K)]

    ax_spatial, circs, sctZ = plot_iteration(ax_spatial, circs,
                                             sctZ, lambda_m,
                                             covs, xn,
                                             step, K)
    plt.savefig('./xiangge/laxiangla_{}.png'.format(step))
plt.savefig('./xiangge/laxiangla.png')