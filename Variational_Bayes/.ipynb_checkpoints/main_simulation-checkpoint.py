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
from utils import update_r_prime, r_prime_init, plot_iteration
import matplotlib.pyplot as plt
import matplotlib.cm as cm

np.random.seed(525)
mean_dict = {"1": [4, 4], "2": [-4, 4], "3": [4, -4], "4": [-4, -4], "5": [-6, 6]}
var_dict = {"1": [[1, 0], [0, 1]], "2": [[2, 0], [0, 1]], "3": [[1, 0], [0, 1]], "4": [[1, 0], [0, 1]], "5": [[1, 0], [0, 2]]}
data = np.empty((1, 2))
for key in mean_dict.keys():
    data = np.append(data, np.random.multivariate_normal(mean_dict[key], var_dict[key], 100), axis=0)
data = data[1:]

colors = cm.rainbow(np.linspace(0, 1, 5))
x1, y1 = data[0:100].T
x2, y2 = data[101:201].T
x3, y3 = data[201:301].T
x4, y4 = data[301:401].T
x5, y5 = data[401:501].T
plt.scatter(x1, y1, c=colors[0], alpha=0.5)
plt.scatter(x2, y2, c=colors[1], alpha=0.5)
plt.scatter(x3, y3, c=colors[2], alpha=0.5)
plt.scatter(x4, y4, c=colors[3], alpha=0.5)
plt.scatter(x5, y5, c=colors[4], alpha=0.5)
plt.axis('off')
plt.savefig("./outputs/report_figs/simulation_original.jpeg", dpi=400)
plt.show()
