from math import sqrt
import numpy as np
from copy import deepcopy
import time
import multiprocessing
import csv


zeta = 0.01


def softT(m, t, zeta):
    # m: float
    # t: float
    # zeta: float
    if (zeta < abs(m)):
        z = (-m - zeta) / (2 * t) if (m < 0) else (-m + zeta) / (2 * t)
    else:
        z = 0
    return z


def process(arguments):
    prob_all, x, y, t, current, j = arguments
    n, p = x.shape  # the number of rows

    if (j == 0):
        sum_temp1 = np.sum(y - prob_all)
        g_j = (-0.5 / n) * sum_temp1
    else:
        xy_j = np.multiply(y, x[:, j-1])  # jth column
        sum_temp1 = np.sum(xy_j - np.multiply(x[:, j-1], prob_all))
        g_j = (-0.5 / n) * sum_temp1

    if (j == 0):
        m_j = g_j - 2 * t * current['itc']
        return (-m_j) / (2 * t)
    else:
        m_j = g_j - 2 * t * current['beta'][j-1]
        return softT(m_j, t, zeta)


class SJU():
    def __init__(self, dataFile='training.csv'):
        with open(dataFile, 'rb') as f:
            reader = csv.reader(f)
            rawData = list(reader)

        f.close()

        del rawData[0]

        for i in range(len(rawData)):
        	del rawData[i][0]
        for i in range(len(rawData)):
        	for j in range(len(rawData[i])):
        		rawData[i][j] = float(rawData[i][j])

        rawData = np.matrix(rawData)

        # turn the R matrix into a numpy array
        self.x = np.matrix(rawData[:, 1:])
        self.y = np.matrix(rawData[:, 0])
        return

    def compute(self, zeta=0.01, cr=0.01):
        pool = multiprocessing.Pool(100)

        def softT(m, t, zeta):
            # m: float
            # t: float
            # zeta: float
            if (zeta < abs(m)):
                z = (-m - zeta) / (2 * t) if (m < 0) else (-m + zeta) / (2 * t)
            else:
                z = 0
            return z

        def prob(x, current):
            # x: matrix(vector, 1*p)
            # beta: matrix(vector, 1*p)
            # itc: float
            p = 1 / (1 + np.exp(-(current['itc'] + np.dot(x, current['beta']))))
            return p

        def gradient(prob_all, x, y, j):
            n, p = x.shape  # the number of rows

            if (j == 0):
                sum_temp1 = np.sum(y - prob_all)
                g_j = (-0.5 / n) * sum_temp1
            else:
                xy_j = np.multiply(y, x[:, j-1])  # jth column
                sum_temp1 = np.sum(xy_j - np.multiply(x[:, j-1], prob_all))
                g_j = (-0.5 / n) * sum_temp1

            return g_j

        def fval(x, y, beta, itc, zeta):
            # x: n*p matrix
            # y: n*1 matrix
            # beta: p*1 vector
            # itc: float
            # zeta: float
            n, tmp = x.shape  # the number of rows
            tmp = itc + x * beta  # x is a matrix, n * p, result is a n*1
            sum_temp2 = np.sum(np.multiply(y, tmp) - np.log(1 + np.exp(tmp)))
            f = (-sum_temp2) * 0.5 / n + zeta * np.sum(np.abs(beta))
            return f

        # data preprocess
        x = self.x
        y = self.y

        n, p = x.shape

        # Algorithms
        # Parameters
        op = 1  # switch, execute programme when 1
        it = 0  # iteration
        Gmax = 0.25
        c = (float(p) / (2 * p - 1)) * sqrt(p) * Gmax
        c = c * (1 + cr)
        t = 0.125 + c
        fvalue = []  # empty

        # Initialization
        current = {"itc": 0,
                   "beta": np.matrix(np.zeros((p, 1)))}

        fvalue.append(fval(x, y, current['beta'], current['itc'], zeta))

        # cyclic coordinate decent
        startTime = time.time()

        while (op == 1):
            it = it + 1  # iteration, starting from 1
            print "Iteration", it

            prob_all = np.matrix(np.zeros((0, 1)))
            for i in range(n):
                prob_all = np.concatenate((prob_all, prob(x[i, :], current)), axis=0)

            arg = []
            for j in range(p+1):
                arg.append((prob_all, x, y, t, current, j))

            result = pool.map(process, arg)

            result = np.matrix(result)
            result = result.T

            current['itc'] = result[0, 0]
            current['beta'] = result[1:, :]

            fvalue.append(fval(x, y, current['beta'], current['itc'], zeta))

            if (abs(fvalue[it-1] - fvalue[it]) < 1e-6):
                op = 2  # programme terminate

        endTime = time.time()

        results = {}
        results['hatbeta'] = np.vstack([current['itc'], current['beta']])
        results['fvalseq'] = fvalue
        results['object_value'] = min(fvalue)
        results['iteration'] = it
        results['time'] = "Total Training Time(seconds): %f" % (endTime - startTime,)
        return results

if __name__ == "__main__":
    x = SJU()
    print x.compute()
