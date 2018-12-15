'''
File: main_simulation.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: Wednesday, 2018-12-12 11:58
Last Modified: Wednesday, 2018-12-12 14:19
--------------------------------------------
Desscription:
'''

import pandas as pd
from sklearn.datasets import make_spd_matrix
from scipy.special import gammaln, psi
import numpy as np
from numpy.linalg import det, inv, eigh
from utils import update_r_prime, r_prime_init, plot_iteration, elbo, predictive_density
import pandas as pd
from sklearn.datasets import make_spd_matrix
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import os
from matplotlib.patches import Ellipse
from os.path import isfile, join
import imageio
import pickle

base = "./outputs/"
figs = base + "simulation/"
model_url = base + "model/"
if not os.path.exists(base):
    os.makedirs(base)
if not os.path.exists(figs):
    os.makedirs(figs)
if not os.path.exists(model_url):
    os.makedirs(model_url)

np.random.seed(525)
mean_dict = {"1": [4, 4], "2": [-4, 4], "3": [4, -4], "4": [-4, -4], "5": [-6, 6]}
var_dict = {"1": [[1, 0], [0, 1]], "2": [[3, 0], [0, 1]], "3": [[1, 0], [0, 1]], "4": [[1, 0], [0, 1]], "5": [[1, 0], [0, 3]]}
data = np.empty((1, 2))
sample_size = 200
for key in mean_dict.keys():
    data = np.append(data, np.random.multivariate_normal(mean_dict[key], var_dict[key], sample_size), axis=0)
data_train = data[1:]

data = np.empty((1, 2))
np.random.seed(425)
for key in mean_dict.keys():
    data = np.append(data, np.random.multivariate_normal(mean_dict[key], var_dict[key], sample_size), axis=0)
data_test = data[1:]
# colors = cm.rainbow(np.linspace(0, 1, 5))
# x1, y1 = data[0:100].T
# x2, y2 = data[101:201].T
# x3, y3 = data[201:301].T
# x4, y4 = data[301:401].T
# x5, y5 = data[401:501].T
# plt.scatter(x1, y1, c=colors[0], alpha=0.5)
# plt.scatter(x2, y2, c=colors[1], alpha=0.5)
# plt.scatter(x3, y3, c=colors[2], alpha=0.5)
# plt.scatter(x4, y4, c=colors[3], alpha=0.5)
# plt.scatter(x5, y5, c=colors[4], alpha=0.5)
# plt.axis('off')
# plt.savefig("./outputs/report_figs/simulation_original.jpeg", dpi=400)
# plt.show()

xn = data_train
# D for dimension, N for data size
N, D = data_train.shape
data_train = np.array(data_train)
# number of cluster
K = 7

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
for step in range(80):
    print(step)
    Nk = np.sum(r_prime, axis=0)
    alpha_prime = alpha_0 + Nk
    beta_prime = beta_0 + Nk
    nu_prime = nu_0 + Nk
    # calculate xk
    xk = np.zeros((K, D))
    for k in range(K):
        for j in range(D):
            d = np.array(data_train[:, j].flatten())
            xk[k][j] = d.dot(r_prime[:, k])/Nk[k]
    # update m prime
    for k in range(K):
        m_prime[k, :] = (beta_0*m_0 + Nk[k]*xk[k, :])/beta_prime[k]
    # update w_inv prime
    for k in range(K):
        Sk = np.zeros((2, 2))
        para = beta_0*Nk[k]/(beta_0+Nk[k])
        for n in range(N):
            Sk += r_prime[n, k]*(data_train[n, :]-xk[k, :]).reshape(1, -1).T*(data_train[n, :]-xk[k, :]).reshape(1, -1)/Nk[k]
        w_inv_prime[k] = w_0_inv + Nk[k]*Sk + para*(xk[k, :]-m_0).reshape(1, -1).T*(xk[k, :]-m_0).reshape(1, -1)
    r_prime = update_r_prime(data_train, alpha_prime, w_inv_prime, nu_prime, beta_prime, m_prime, N, D, K)

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
    summation = 0
    for x in data_test:
        summation += np.log(predictive_density(x, lambda_m, inv(variance), alpha_prime, beta_prime, lambda_nu, D, K))
    log_predivtive.append(summation / xn.shape[0])

    ax_spatial, circs, sctZ = plot_iteration(ax_spatial, circs,
                                             sctZ, lambda_m,
                                             covs, xn,
                                             step, K)
    if step % 10 == 0:
        plt.savefig(figs + "iter_{}.png".format(step), dpi=200)
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

with open(model_url + 'simulation.pickle', 'wb') as handle:
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
