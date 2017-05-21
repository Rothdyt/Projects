import optparse
import sys
import os
from sys import maxint

from math import sqrt
import numpy as np
from copy import deepcopy
import time
import multiprocessing
import csv
import ctypes
from itertools import chain

import logging

try:
    from progress import Task
except:
    Task = None


def init_logger(logFile='sju_log.csv'):
    # PARSER
    logger = logging.getLogger('compute')
    logger.setLevel(logging.DEBUG)
    # create file handler which logs even debug messages
    fh = logging.FileHandler(logFile)
    fh.setLevel(logging.DEBUG)
    # create console handler with a higher log level
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    # create formatter and add it to the handlers
    formatter = logging.Formatter('%(message)s')
    fh.setFormatter(formatter)
    ch.setFormatter(formatter)
    # add the handlers to the logger
    logger.addHandler(fh)
    logger.addHandler(ch)




# Constants Settings here
# The following constants will need to be accessable by each thread
zeta = 0.01
threads = 4

# Shared memory objects for all threads
# Each is a 1*1 np.array, which will be initialised later

x_shared_base = multiprocessing.Array(ctypes.c_double, 1)
x_shared = np.ctypeslib.as_array(x_shared_base.get_obj())
x_shared = x_shared.reshape(1, 1)

current_shared_base = multiprocessing.Array(ctypes.c_double, 1)
current_shared = np.ctypeslib.as_array(current_shared_base.get_obj())
current_shared = current_shared.reshape(1, 1)

prob_shared_base = multiprocessing.Array(ctypes.c_double, 1)
prob_shared = np.ctypeslib.as_array(prob_shared_base.get_obj())
prob_shared = prob_shared.reshape(1, 1)


# Functions that needs to be used by each thread
def softT(m, t, zeta):
    # m: float
    # t: float
    # zeta: float
    if (zeta < abs(m)):
        z = (-m - zeta) / (2 * t) if (m < 0) else (-m + zeta) / (2 * t)
    else:
        z = 0
    return z

# The function for each thread
def process(arguments, def_parm=(x_shared, prob_shared, current_shared)):
    t, itc_current, s, maxCol = arguments
    n, p = x_shared.shape  # the number of rows
    sum_arr = x_shared.sum(axis=0)
    e = maxCol + (threads - 1) / threads
    s = s * e

    output = ()
    for j in range(s, s+e):
        if j > maxCol:
            break
        if (j == 0):
            sum_temp1 = np.sum(prob_shared)
        else:
            sum_temp1 = sum_arr[j-1]
        g_j = (-0.5 / n) * sum_temp1

        if (j == 0):
            m_j = g_j - 2 * t * itc_current
            output = output + ((-m_j) / (2 * t),)
        else:
            m_j = g_j - 2 * t * current_shared[j-1]
            output = output + (softT(m_j, t, zeta),)
    return output


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
        self.dataFile = dataFile
        print "loaded. n, p:", self.x.shape
        n, p = self.x.shape

        global x_shared_base
        global x_shared
        global current_shared_base
        global current_shared
        global prob_shared_base
        global prob_shared
        x_shared_base = multiprocessing.Array(ctypes.c_double, n*p)
        x_shared = np.ctypeslib.as_array(x_shared_base.get_obj())
        x_shared = x_shared.reshape(n, p)

        current_shared_base = multiprocessing.Array(ctypes.c_double, p*1)
        current_shared = np.ctypeslib.as_array(current_shared_base.get_obj())
        current_shared = current_shared.reshape(p, 1)

        prob_shared_base = multiprocessing.Array(ctypes.c_double, n*1)
        prob_shared = np.ctypeslib.as_array(prob_shared_base.get_obj())
        prob_shared = prob_shared.reshape(n, 1)

        return

    def compute(self, zeta=0.01, cr=0.01, targetValue=-1, rand=False, maxIteration=maxint, diff=1e-6, maxPool=100, maxCol=maxint):
        if Task:
            self.task = Task("DYT@" + self.dataFile, "t" + str(threads))
        init_logger()
        logger = logging.getLogger('compute')
        print "Threads:", threads
        print "diff:", diff
        print "rand:", rand
        print "lambda:", zeta
        print "cr:", cr
        maxCol = min(self.x.shape[1], maxCol)
        print "maxCol:", maxCol
        pool = multiprocessing.Pool(maxPool)

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
        x_shared[:, :] = x

        n, p = x.shape

        # Algorithms
        # Parameters
        it = 0  # iteration
        Gmax = 0.25
        c = (float(p) / (2 * p - 1)) * sqrt(p) * Gmax
        c = c * (1 + cr)
        t = 0.125 + c
        fvalue = []  # empty
        order = np.arange(p).T

        # Initialization
        current = {"itc": 0,
                   "beta": np.matrix(np.zeros((p, 1)))}

        fvalue.append(fval(x, y, current['beta'], current['itc'], zeta))

        # cyclic coordinate decent
        step1Time = 0.0
        step2Time = 0.0
        step3Time = 0.0
        step4Time = 0.0
        print "Training start"
        startTime = time.time()
        logger.info("%d, %.15f, %f, %s" % (it, fvalue[0], startTime - startTime, "q"+str(threads)+str(rand), ))

        while (it < maxIteration):
            it = it + 1  # iteration, starting from 1
            print "\rIteration", it,

            # Partition the dataset
            tmp = np.insert(x,   0, values=order,    axis=0)
            tmp = np.insert(tmp, 1, values=current['beta'].T, axis=0)
            tmp = np.array(tmp)
            if rand:
                tmp = np.random.permutation(tmp.T).T
            else:
                if maxCol < p:
                    h1 = np.matrix(tmp[:, 0:maxCol])
                    h2 = np.matrix(tmp[:, maxCol:])
                    tmp[:, 0:p-maxCol] = h2
                    tmp[:, p-maxCol:] = h1

            order           = tmp[0, :].astype(int)
            current['beta'] = np.matrix(tmp[1:2, :].T)
            x               = np.matrix(tmp[2:, :])

            step1Start = time.time()

            prob_shared[:, :] = y - 1 / (1 + np.exp(-(current['itc'] + x * current['beta'])))
            x_shared[:, :] = np.multiply(x, prob_shared)
            current_shared[:,:] = current['beta']

            step1End = time.time()

            arg = []
            for j in range((p + threads - 1) / threads):
                arg.append((t, current['itc'], j, maxCol))

            step2End = time.time()

            result = pool.map(process, arg)

            step3End = time.time()

            result = list(chain(*result))
            result = np.matrix(result)
            result = result.T

            current['itc'] = result[0, 0]
            current['beta'][0:result.shape[0]-1, :] = result[1:result.shape[0], :]

            fvalue.append(fval(x, y, current['beta'], current['itc'], zeta))

            step4End = time.time()

            step1Time += step1End - step1Start
            step2Time += step2End - step1End
            step3Time += step3End - step2End
            step4Time += step4End - step3End

            logger.info("%d, %.15f, %f, %s" % (it, fvalue[-1], step4End - startTime, "q"+str(threads)+str(rand), ))

            if Task:
                self.task.progress("Processing iteration: %d" % (it,))

            if diff:

                if targetValue != -1:
                    # if (abs(fvalue[it] - targetValue) < diff):
                    if (fvalue[it] < targetValue):
                        break
                else:
                    if (abs(fvalue[it-1] - fvalue[it]) < diff):
                        break

        # Restore order
        x = np.matrix(x[:, np.argsort(order)])
        current['beta'] = np.matrix(current['beta'][np.argsort(order)])

        endTime = time.time()

        print "\rTraining complete"

        results = {}
        results['hatbeta'] = np.vstack([current['itc'], current['beta']])
        results['data access'] = maxCol * it
        if diff:
            results['fvalseq'] = fvalue
            results['object_value'] = min(fvalue)
        results['iteration'] = it
        results['time'] = endTime - startTime
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
    optparser.add_option("-t", "--threads", dest="threads", default=4, type="int", help="Number of threads to use (default=4)")
    optparser.add_option("-c", "--convergen", dest="conv", default=-1, type="float", help="Convergence parameter (default=-1)")
    optparser.add_option("-l", "--lambda", dest="zeta", default=0.01, type="float", help="lambda parameter (default=0.01)")
    optparser.add_option("-w", "--cr", dest="cr", default=0.01, type="float", help="cr parameter (default=0.01)")
    optparser.add_option("-m", "--maxcol", dest="maxCol", default=maxint, type="int", help="Maximum columns per iteration (default=maxint)")
    optparser.add_option("-v", "--targetValue", dest="targetValue", default=-1, type="float", help="Target Value (default=-1)")


    optparser.add_option("-r", action="store_true", dest="rand")
    (opts, _) = optparser.parse_args()

    threads = opts.threads
    zeta = opts.zeta

    x = SJU(dataFile=opts.dataFile)
    if opts.conv == -1:
        print x.compute(targetValue=opts.targetValue, zeta=opts.zeta, cr=opts.cr, rand=opts.rand, maxIteration=opts.iter, maxCol=opts.maxCol, diff=None)
    else:
        print x.compute(targetValue=opts.targetValue, zeta=opts.zeta, cr=opts.cr, rand=opts.rand, maxIteration=opts.iter, maxCol=opts.maxCol, diff=opts.conv)
