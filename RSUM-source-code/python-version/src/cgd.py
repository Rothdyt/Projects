'''
File: cgd.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-10 17:08
Last Modified: 2019-07-23 11:34
--------------------------------------------
Description:
'''
import numpy as np
import time
import copy
import logging
import pickle


class CGD:
    def __init__(self, x, y, Lambda, logname="cgd.log"):
        self.x = x
        self.y = y
        self.Lambda = Lambda
        self.n, self.d = x.shape
        self.z = None  # save computation
        self.p = None
        logger = logging.getLogger(__name__)
        logger.setLevel(logging.INFO)
        handler = logging.FileHandler(logname)
        handler.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - [%(levelname)s] - %(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        self.log = logger
        self.log.info("cgd-- N:{} | d:{} | lambda:{}".format(self.n, self.d, self.Lambda))

    def soft(self, k, h):
        t = 0 if self.Lambda >= np.abs(k) else ((k-self.Lambda)/h if k > 0 else (k+self.Lambda)/h)
        return t

    def create_unit_vector(self, coordinate):
        e = np.zeros((self.d + 1, 1))
        e[coordinate] = 1
        return e

    def get_intermediate(self, beta):
        self.z = np.matmul(self.x, beta[1:]) + beta[0]
        self.p = 1 / (1 + np.exp(-self.z))

    def get_coordinate_gradient(self, j):
        if j == 0:
            g_j = (-0.5 / self.n) * np.sum(self.y - self.p)
        else:
            xy_j = self.y * self.x[:, [j-1]]
            g_j = (-0.5 / self.n) * np.sum(xy_j - self.x[:, [j-1]] * self.p)
        return g_j

    def get_coordinate_hessian(self, j):
        if j == 0:
            h_j = np.sum((1/self.p-1) * (self.p**2)) / (2*self.n)
        else:
            h_j = np.sum((self.x[:, [j-1]] ** 2) * (1/self.p-1) * (self.p**2)) / (2*self.n)
        return h_j

    def get_direction(self, j, beta_j, g_j, h_j):
        if j == 0:
            d_j = - g_j/h_j
        else:
            k_j = h_j * beta_j - g_j
            z_j = self.soft(k=k_j, h=h_j)
            d_j = z_j - beta_j
        return d_j

    def get_gap(self, epsilon, sigma, gamma, j, beta_j, d_j, g_j, h_j):
        if j == 0:
            delta_j = gamma * h_j * (d_j**2) + g_j * d_j
        else:
            delta_j = gamma * h_j * (d_j**2) + g_j * d_j + \
                self.Lambda * (np.abs(beta_j + d_j) - np.abs(beta_j))
        return delta_j

    def get_fval(self, beta):
        z = np.matmul(self.x, beta[1:]) + beta[0]
        temp = -self.y * z + np.log(1 + np.exp(z))
        fval = np.mean(temp, axis=0) / 2 + self.Lambda * np.sum(np.abs(beta[1:]))
        return fval

    def solve(self, accuracy=1e-6, step=1, criteria='fseq', checkpoint=False, checkpoint_path='./cgd.pkl', fmin=None):
        epsilon = 0.1
        sigma = 0.2
        gamma = 0.5
        if checkpoint:
            self.log.info("Resume from checkpoint.")
            pickled = pickle.load(open(checkpoint_path, "rb"))
            epoch = pickled['epoch']
            iteration = pickled['iteration']
            beta_update = pickled['beta_update']
            self.get_intermediate(beta_update)
            fval_seq = pickled['fval_seq']
            f_current = fval_seq[-1]
            time_used = pickled['time_used']
            flag = pickled['flag']
        else:
            epoch = iteration = 0
            beta_update = np.zeros((self.d+1, 1))
            self.get_intermediate(beta_update)
            fval_seq = [self.get_fval(beta_update)]
            f_current = fval_seq[-1]
            time_used = 0.0
            flag = True
        if (criteria == 'fseq'):
            self.log.info("Function value sequence convergence criteria.")
            self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
            while flag:
                start_time = time.time()
                for j in range(self.d + 1):
                    g_j = self.get_coordinate_gradient(j)
                    h_j = self.get_coordinate_hessian(j)
                    d_j = self.get_direction(j, beta_update[j], g_j, h_j)
                    delta_j = self.get_gap(epsilon, sigma, gamma, j, beta_update[j], d_j, g_j, h_j)
                    # armijo-rule
                    k = 0
                    flag_armijo = True
                    while flag_armijo:
                        beta_armijo = beta_update + step * (epsilon ** k) * d_j * self.create_unit_vector(j)
                        f_armijo = self.get_fval(beta_armijo)
                        f_compare = f_current + step * (epsilon ** k) * sigma * delta_j
                        if (f_armijo <= f_compare):
                            flag_armijo = False
                        else:
                            k += 1
                    if j == 0:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    else:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    f_current = f_armijo
                    iteration += 1
                    self.get_intermediate(beta_update)
                fval_seq.append(f_current)
                epoch += 1
                self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                if (fval_seq[-2] - fval_seq[-1] < accuracy):
                    flag = False
                time_used += time.time() - start_time
                checkpoint = {"time_used": time_used,
                              "fval_seq": fval_seq,
                              "beta_update": beta_update,
                              "iteration": iteration,
                              "epoch": epoch,
                              'flag': flag
                              }
                pickle.dump(checkpoint, open(checkpoint_path, "wb"))
            running_time = time_used
        elif (criteria == 'fmin'):
            self.log.info("Minimal Value criteria.")
            self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
            while flag:
                start_time = time.time()
                for j in range(self.d + 1):
                    g_j = self.get_coordinate_gradient(j)
                    h_j = self.get_coordinate_hessian(j)
                    d_j = self.get_direction(j, beta_update[j], g_j, h_j)
                    delta_j = self.get_gap(epsilon, sigma, gamma, j, beta_update[j], d_j, g_j, h_j)
                    # armijo-rule
                    k = 0
                    flag_armijo = True
                    while flag_armijo:
                        beta_armijo = beta_update + step * (epsilon ** k) * d_j * self.create_unit_vector(j)
                        f_armijo = self.get_fval(beta_armijo)
                        f_compare = f_current + step * (epsilon ** k) * sigma * delta_j
                        if (f_armijo <= f_compare):
                            flag_armijo = False
                        else:
                            k += 1
                    if j == 0:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    else:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    f_current = f_armijo
                    iteration += 1
                    self.get_intermediate(beta_update)
                fval_seq.append(f_current)
                epoch += 1
                self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                if (fval_seq[-1] - fmin < accuracy):
                    flag = False
                time_used += time.time() - start_time
                checkpoint = {"time_used": time_used,
                              "fval_seq": fval_seq,
                              "beta_update": beta_update,
                              "iteration": iteration,
                              "epoch": epoch,
                              'flag': flag
                              }
                pickle.dump(checkpoint, open(checkpoint_path, "wb"))
            running_time = time_used
        elif (criteria == 'xseq'):
            self.log.info("Iterator sequence convergence criteria.")
            self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
            beta = np.zeros((self.d+1, 1))

            f_current = fval_seq[-1]
            start_time = time.time()
            while flag:
                for j in range(self.d + 1):
                    g_j = self.get_coordinate_gradient(j)
                    h_j = self.get_coordinate_hessian(j)
                    d_j = self.get_direction(j, beta_update[j], g_j, h_j)
                    delta_j = self.get_gap(epsilon, sigma, gamma, j, beta_update[j], d_j, g_j, h_j)
                    # armijo-rule
                    k = 0
                    flag_armijo = True
                    while flag_armijo:
                        beta_armijo = beta_update + step * (epsilon ** k) * d_j * self.create_unit_vector(j)
                        f_armijo = self.get_fval(beta_armijo)
                        f_compare = f_current + step * (epsilon ** k) * sigma * delta_j
                        if (f_armijo <= f_compare):
                            flag_armijo = False
                        else:
                            k += 1
                    if j == 0:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    else:
                        beta_update[j] += d_j * step * (epsilon ** k)
                    f_current = f_armijo
                    iteration += 1
                    self.get_intermediate(beta_update)
                fval_seq.append(f_current)
                epoch += 1
                self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                if (np.max(np.abs(beta_update - beta)) < accuracy):
                    flag = False
                beta = copy.deepcopy(beta_update)
            running_time = time.time() - start_time
        else:
            raise ValueError("Invalid Input for criteria. Valid Inputs: ['fseq','xseq'].")
        return beta_update, fval_seq, running_time, iteration, epoch


if __name__ == '__main__':
    import pandas as pd
    df = pd.read_csv('../db/training.csv')
    y = np.array(df.iloc[:, 1]).reshape(-1, 1)
    x = np.array(df.iloc[:, 2:])
    X = (x - np.mean(x, axis=0)) / np.std(x, axis=0)
    solver = CGD(x=X, y=y, Lambda=0.01)
    beta, fval_seq, running_time, iteration, epoch = solver.solve()
    print(running_time, fval_seq[-1], epoch)
    beta, fval_seq, running_time, iteration, epoch = solver.solve(checkpoint=True)
    print(running_time, fval_seq[-1], epoch)
    beta, fval_seq, running_time, iteration, epoch = solver.solve(criteria='xseq')
    print(running_time, fval_seq[-1], epoch)
