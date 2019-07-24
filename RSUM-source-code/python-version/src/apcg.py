'''
File: apcg.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-09 12:22
Last Modified: 2019-07-23 11:35
--------------------------------------------
Description:
'''
import numpy as np
import time
import copy
import logging
import pickle


class APCG:
    def __init__(self, x, y, Lambda, logname="apcg.log"):
        self.x = x
        self.y = y
        self.Lambda = Lambda
        self.n, self.d = x.shape
        logger = logging.getLogger(__name__)
        logger.setLevel(logging.INFO)
        handler = logging.FileHandler(logname)
        handler.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - [%(levelname)s] - %(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        self.log = logger
        self.log.info("apcg-- N:{} | d:{} | lambda:{}".format(self.n, self.d, self.Lambda))

    def soft(self, z, r):
        t = 0 if r >= np.abs(z) else (z-r if z > 0 else z+r)
        return t

    def get_fval(self, beta):
        z = np.matmul(self.x, beta[1:]) + beta[0]
        temp = -self.y * z + np.log(1 + np.exp(z))
        fval = np.mean(temp, axis=0) / 2 + self.Lambda * np.sum(np.abs(beta[1:]))
        return fval

    def get_root(self, gamma, sigma):
        root0 = (sigma - gamma + np.sqrt((sigma - gamma) ** 2 + 4 * self.d ** 2 * gamma)) / (2 * self.d ** 2)
        root1 = (sigma - gamma - np.sqrt((sigma - gamma) ** 2 + 4 * self.d ** 2 * gamma)) / (2 * self.d ** 2)
        if root0 > 0 and root0 <= 1 / self.d:
            return root0
        else:
            return root1

    def solve(self, accuracy=1e-6, criteria='fseq', checkpoint=False, checkpoint_path='./apcg.pkl', fmin=None):
        sigma = 0.5
        if checkpoint:
            self.log.info("Resume from checkpoint.")
            pickled = pickle.load(open(checkpoint_path, "rb"))
            epoch = pickled['epoch']
            iteration = pickled['iteration']
            beta_update = pickled['beta_update']
            z = pickled['z']
            gamma = pickled['gamma']
            fval_seq = pickled['fval_seq']
            time_used = pickled['time_used']
            flag = pickled['flag']
        else:
            epoch = iteration = 0
            beta_update = np.zeros((self.d+1, 1))
            gamma = 0.5
            z = np.zeros((self.d+1, 1))
            fval_seq = [self.get_fval(beta_update)]
            flag = True
            time_used = 0.0
        if (criteria == 'fseq'):
            self.log.info("Function value sequence convergence criteria.")
            self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
            while flag:
                if iteration % self.d == 0:
                    start_time = time.time()
                alpha = self.get_root(gamma, sigma)
                gamma_update = (1 - alpha) * gamma + alpha * sigma
                theta = alpha * sigma / gamma_update
                eta = (1 / (alpha * gamma + gamma_update)) * (alpha * gamma * z +
                                                              gamma_update * beta_update)
                j = np.random.randint(1, self.d+1)
                z_update = (1 - theta) * z + theta * eta  # will over write coordinate-th position later
                inner_prod = np.matmul(self.x, eta[1:]) + eta[0]
                inner_prod = 1 - (1 / (1 + np.exp(inner_prod)))
                x_j_star = np.sqrt(self.d * alpha / 8) * self.x[:, [j-1]]
                y_star = np.sqrt(2 / (self.d * alpha)) * (self.y - inner_prod) + \
                    np.sqrt(self.d * alpha / 8) * ((1 - theta) * z[j] + theta * eta[j]) * self.x[:, [j-1]]
                z_j_hat = (1 / self.n) * np.matmul(y_star.T, x_j_star)
                z_update[j] = 8 * self.soft(z_j_hat, self.Lambda) / (self.d * alpha)
                z_update[0] += (4 / (self.n * self.d * alpha)) * np.sum((self.y - inner_prod))
                beta_update = eta + self.d * alpha * (z_update - z) + sigma * (z - eta) / self.d
                iteration += 1
                gamma = gamma_update
                z = copy.deepcopy(z_update)
                if iteration % self.d == 0:
                    epoch += 1
                    fval_seq.append(self.get_fval(beta_update))
                    self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                    if (fval_seq[-2] - fval_seq[-1] < accuracy):
                        flag = False
                    time_used += time.time() - start_time
                    checkpoint = {"time_used": time_used,
                                  "fval_seq": fval_seq,
                                  "beta_update": beta_update,
                                  "gamma": gamma,
                                  "z": z,
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
                if iteration % self.d == 0:
                    start_time = time.time()
                alpha = self.get_root(gamma, sigma)
                gamma_update = (1 - alpha) * gamma + alpha * sigma
                theta = alpha * sigma / gamma_update
                eta = (1 / (alpha * gamma + gamma_update)) * (alpha * gamma * z +
                                                              gamma_update * beta_update)
                j = np.random.randint(1, self.d+1)
                z_update = (1 - theta) * z + theta * eta  # will over write coordinate-th position later
                inner_prod = np.matmul(self.x, eta[1:]) + eta[0]
                inner_prod = 1 - (1 / (1 + np.exp(inner_prod)))
                x_j_star = np.sqrt(self.d * alpha / 8) * self.x[:, [j-1]]
                y_star = np.sqrt(2 / (self.d * alpha)) * (self.y - inner_prod) + \
                    np.sqrt(self.d * alpha / 8) * ((1 - theta) * z[j] + theta * eta[j]) * self.x[:, [j-1]]
                z_j_hat = (1 / self.n) * np.matmul(y_star.T, x_j_star)
                z_update[j] = 8 * self.soft(z_j_hat, self.Lambda) / (self.d * alpha)
                z_update[0] += (4 / (self.n * self.d * alpha)) * np.sum((self.y - inner_prod))
                beta_update = eta + self.d * alpha * (z_update - z) + sigma * (z - eta) / self.d
                iteration += 1
                gamma = gamma_update
                z = copy.deepcopy(z_update)
                if iteration % self.d == 0:
                    epoch += 1
                    fval_seq.append(self.get_fval(beta_update))
                    self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                    if (fval_seq[-1] - fmin < accuracy):
                        flag = False
                    time_used += time.time() - start_time
                    checkpoint = {"time_used": time_used,
                                  "fval_seq": fval_seq,
                                  "beta_update": beta_update,
                                  "gamma": gamma,
                                  "z": z,
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
            start_time = time.time()
            while flag:
                alpha = self.get_root(gamma, sigma)
                gamma_update = (1 - alpha) * gamma + alpha * sigma
                theta = alpha * sigma / gamma_update
                eta = (1 / (alpha * gamma + gamma_update)) * (alpha * gamma * z +
                                                              gamma_update * beta)
                j = np.random.randint(1, self.d+1)
                z_update = (1 - theta) * z + theta * eta  # will over write coordinate-th position later
                inner_prod = np.matmul(self.x, eta[1:]) + eta[0]
                inner_prod = 1 - (1 / (1 + np.exp(inner_prod)))
                x_j_star = np.sqrt(self.d * alpha / 8) * self.x[:, [j-1]]
                y_star = np.sqrt(2 / (self.d * alpha)) * (y - inner_prod) + \
                    np.sqrt(self.d * alpha / 8) * ((1 - theta) * z[j] + theta * eta[j]) * self.x[:, [j-1]]
                z_j_hat = (1 / self.n) * np.matmul(y_star.T, x_j_star)
                z_update[j] = 8 * self.soft(z_j_hat, self.Lambda) / (self.d * alpha)
                z_update[0] += (4 / (self.n * self.d * alpha)) * np.sum((self.y - inner_prod))
                beta_update = eta + self.d * alpha * (z_update - z) + sigma * (z - eta) / self.d
                iteration += 1
                condition1 = iteration % self.d == 0
                if condition1:
                    epoch += 1
                    fval_seq.append(self.get_fval(beta_update))
                    self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                    if (np.max(np.abs(beta_update - beta)) < 1e-6):
                        flag = False
                gamma = gamma_update
                beta = copy.deepcopy(beta_update)
                z = copy.deepcopy(z_update)
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
    solver = APCG(x=X, y=y, Lambda=0.01)
    beta, fval_seq, running_time, iteration, epoch = solver.solve()
    print(running_time, fval_seq[-1], epoch)
    beta, fval_seq, running_time, iteration, epoch = solver.solve(checkpoint=True)
    print(running_time, fval_seq[-1], epoch)
    beta, fval_seq, running_time, iteration, epoch = solver.solve(criteria='xseq')
    print(running_time, fval_seq[-1], epoch)
