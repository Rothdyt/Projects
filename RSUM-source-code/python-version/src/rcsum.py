'''
File: rcsum.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-10 09:19
Last Modified: 2019-07-23 11:35
--------------------------------------------
Description:
'''
import numpy as np
import time
import copy
import logging
import pickle


class RCSUM:
    def __init__(self, x, y, Lambda, logname="rcsum.log"):
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
        self.log.info("rcsum-- N:{} | d:{} | lambda:{}".format(self.n, self.d, self.Lambda))

    def soft(self, z, r):
        t = 0 if r >= np.abs(z) else (z-r if z > 0 else z+r)
        return t

    def get_fval(self, beta):
        z = np.matmul(self.x, beta[1:]) + beta[0]
        temp = -self.y * z + np.log(1 + np.exp(z))
        fval = np.mean(temp, axis=0) / 2 + self.Lambda * np.sum(np.abs(beta[1:]))
        return fval

    def solve(self, accuracy=1e-6, criteria='fseq', checkpoint=False, checkpoint_path='./rcsum.pkl', fmin=None):
        if checkpoint:
            self.log.info("Resume from checkpoint.")
            pickled = pickle.load(open(checkpoint_path, "rb"))
            epoch = pickled['epoch']
            iteration = pickled['iteration']
            beta_update = pickled['beta_update']
            fval_seq = pickled['fval_seq']
            time_used = pickled['time_used']
            flag = pickled['flag']
        else:
            epoch = iteration = 0
            flag = True
            beta_update = np.zeros((self.d+1, 1))
            fval_seq = [self.get_fval(beta_update)]
            time_used = 0.0
        if (criteria == 'fseq'):
            self.log.info("Function value sequence convergence criteria.")
            self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
            while flag:
                start_time = time.time()
                indexset = np.random.permutation(np.arange(1, self.d + 1))
                for j in indexset:
                    x_j = self.x[:, [j-1]]
                    hatyj = np.matmul(self.x, beta_update[1:]) - (x_j * beta_update[j]) + beta_update[0]
                    xstar_j = x_j / (2 * np.sqrt(2))
                    a_j = np.exp(hatyj + x_j * beta_update[j])
                    ystar_j = np.sqrt(2) * self.y - np.sqrt(2) * (1 - 1 / (1 + a_j)) + xstar_j * beta_update[j]
                    z_j = np.mean(xstar_j * ystar_j, axis=0)
                    beta_update[j] = 8 * self.soft(z_j, self.Lambda)
                    iteration += 1
                temp = np.exp(beta_update[0] + np.matmul(self.x, beta_update[1:]))
                temp = np.sum(1 - (1/(1 + temp)) - self.y)
                beta_update[0] = beta_update[0] - 4 * temp / self.n
                iteration += 1
                epoch += 1
                fval_seq.append(self.get_fval(beta_update))
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
                indexset = np.random.permutation(np.arange(1, self.d + 1))
                for j in indexset:
                    x_j = self.x[:, [j-1]]
                    hatyj = np.matmul(self.x, beta_update[1:]) - (x_j * beta_update[j]) + beta_update[0]
                    xstar_j = x_j / (2 * np.sqrt(2))
                    a_j = np.exp(hatyj + x_j * beta_update[j])
                    ystar_j = np.sqrt(2) * self.y - np.sqrt(2) * (1 - 1 / (1 + a_j)) + xstar_j * beta_update[j]
                    z_j = np.mean(xstar_j * ystar_j, axis=0)
                    beta_update[j] = 8 * self.soft(z_j, self.Lambda)
                    iteration += 1
                temp = np.exp(beta_update[0] + np.matmul(self.x, beta_update[1:]))
                temp = np.sum(1 - (1/(1 + temp)) - self.y)
                beta_update[0] = beta_update[0] - 4 * temp / self.n
                iteration += 1
                epoch += 1
                fval_seq.append(self.get_fval(beta_update))
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
            start_time = time.time()
            while flag:
                indexset = np.random.permutation(np.arange(1, self.d + 1))
                for j in indexset:
                    x_j = self.x[:, [j-1]]
                    hatyj = np.matmul(self.x, beta_update[1:]) - (x_j * beta_update[j]) + beta_update[0]
                    xstar_j = x_j / (2 * np.sqrt(2))
                    a_j = np.exp(hatyj + x_j * beta_update[j])
                    ystar_j = np.sqrt(2) * self.y - np.sqrt(2) * (1 - 1 / (1 + a_j)) + xstar_j * beta_update[j]
                    z_j = np.mean(xstar_j * ystar_j, axis=0)
                    beta_update[j] = 8 * self.soft(z_j, self.Lambda)
                    iteration += 1
                temp = np.exp(beta_update[0] + np.matmul(self.x, beta_update[1:]))
                temp = np.sum(1 - (1/(1 + temp)) - self.y)
                beta_update[0] = beta_update[0] - 4 * temp / self.n
                iteration += 1
                epoch += 1
                self.log.info('Epoch: {:4d} | FVAL: {:.7f}'.format(epoch, *[*fval_seq[-1]]))
                fval_seq.append(self.get_fval(beta_update))
                if (np.max(np.abs(beta_update - beta)) < accuracy):
                    flag = False
                beta = copy.deepcopy(beta_update)  # take care! You must use deepcopy.
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
    solver = RCSUM(x=X, y=y, Lambda=0.01)
    beta, fval_seq, running_time, iteration, epoch = solver.solve()
    print(running_time, fval_seq[-1], epoch)
    # beta, fval_seq, running_time, iteration, epoch = solver.solve(checkpoint=True)
    # print(running_time, fval_seq[-1], epoch)
    beta, fval_seq, running_time, iteration, epoch = solver.solve(criteria='xseq')
    print(running_time, fval_seq[-1], epoch)
