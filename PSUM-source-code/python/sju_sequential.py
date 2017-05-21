import optparse
import sys
import os
from sys import maxint

from math import sqrt
import numpy as np
from copy import deepcopy
import time
import csv


class SJU():
    def __init__(self, dataFile='training.csv'):
        print "loading dataset:", dataFile
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
        print "loaded. n, p:", self.x.shape
        return

    def compute(self, zeta=0.01, cr=0.01, maxIteration=maxint, diff=1e-6):
        print "diff:", diff
        def softT(m, t, zeta):
            # m: float
            # t: float
            # zeta: float
            if (zeta < abs(m)):
                z = (-m - zeta) / (2 * t) if (m < 0) else (-m + zeta) / (2 * t)
            else:
                z = 0
            return z

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
        itc_current = 0
        beta_current = np.matrix(np.zeros((p, 1)))
        itc_update = 0
        beta_update = np.matrix(np.zeros((p, 1)))

        fvalue.append(fval(x, y, beta_current, itc_current, zeta))

        # cyclic coordinate decent
        step1Time = 0.0
        step2Time = 0.0
        step3Time = 0.0
        step4Time = 0.0
        print "Training start"
        startTime = time.time()

        while (it < maxIteration):
            it = it + 1  # iteration, starting from 1
            print "\rIteration", it,

            step1Start = time.time()

            prob_all = y - 1 / (1 + np.exp(-(itc_current + x * beta_current)))
            x_sum = np.multiply(x, prob_all).sum(axis=0)
            prob_sum = np.sum(prob_all)

            step1End = time.time()

            step2End = time.time()

            for j in range(p+1):

                n, p = x.shape  # the number of rows

                if (j == 0):
                    sum_temp1 = prob_sum
                else:
                    sum_temp1 = np.sum(np.multiply(x[:, j-1], prob_all))
                g_j = (-0.5 / n) * sum_temp1

                if (j == 0):
                    m_j = g_j - 2 * t * itc_current
                    itc_update = (-m_j) / (2 * t)
                else:
                    m_j = g_j - 2 * t * beta_current[j-1]
                    beta_update[j-1] = softT(m_j, t, zeta)

            step3End = time.time()


            beta_current = deepcopy(beta_update)
            itc_current = deepcopy(itc_update)

            step4End = time.time()

            step1Time += step1End - step1Start
            step2Time += step2End - step1End
            step3Time += step3End - step2End
            step4Time += step4End - step3End

            if diff:
                fvalue.append(fval(x, y, beta_current, itc_current, zeta))
                if (abs(fvalue[it-1] - fvalue[it]) < diff):
                    break
        endTime = time.time()

        print "\rTraining complete"

        results = {}
        results['hatbeta'] = np.vstack([itc_update, beta_update])
        if diff:
            results['fvalseq'] = fvalue
            results['object_value'] = min(fvalue)
        results['iteration'] = it
        print "stage1Time:", step1Time,
        print "; stage2Time:", step2Time
        print "stage3Time:", step3Time,
        print "; stage4Time:", step4Time
        print "Total time (sec):", endTime - startTime
        return results

if __name__ == "__main__":
    optparser = optparse.OptionParser()
    optparser.add_option("-d", "--datafile", dest="dataFile", default="training.csv", help="training data (default=training.csv)")
    optparser.add_option("-i", "--iterations", dest="iter", default=244, type="int", help="Number of maximum iterations to train")
    optparser.add_option("-c", "--convergen", dest="conv", default=-1, type="float", help="Convergence parameter (default=1e-6)")
    (opts, _) = optparser.parse_args()

    x = SJU(dataFile=opts.dataFile)
    if opts.conv == -1:
        print x.compute(maxIteration=opts.iter, diff=None)
    else:
        print x.compute(maxIteration=opts.iter, diff=opts.conv)
