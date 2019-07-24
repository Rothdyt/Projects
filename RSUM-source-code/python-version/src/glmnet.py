'''
File: glmnet.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-12 08:44
Last Modified: 2019-07-12 08:46
--------------------------------------------
Description:
'''
import pandas as pd
import numpy as np
import os
from utils import get_data
from apcg import APCG
from rcsum import RCSUM
from csum import CSUM
from cgd import CGD
filename = os.path.basename(__file__).split('.')[0]
print(filename)

df = pd.read_csv('../db/training.csv')
y = np.array(df.iloc[:, 1]).reshape(-1, 1)
x = np.array(df.iloc[:, 2:])
X = (x - np.mean(x, axis=0)) / np.std(x, axis=0)
basedir = "../db/logs/{}".format(filename)
if not os.path.exists(basedir):
    os.makedirs(basedir)
    print("{} has been created!".format(basedir))

myLambda = 0.001
print("rcsum...")
rcsum_solver = RCSUM(x=X, y=y, Lambda=myLambda,
                     logname="{}/rcsum_{}.log".format(basedir, myLambda))
beta, fval_seq, running_time, iteration, epoch = rcsum_solver.solve(
    checkpoint_path="{}/rcsum_{}.pkl".format(basedir, myLambda))
print("apcg...")
apcg_solver = APCG(x=X, y=y, Lambda=myLambda,
                   logname="{}/apcg_{}.log".format(basedir, myLambda))
beta, fval_seq, running_time, iteration, epoch = apcg_solver.solve(
    checkpoint_path="{}/apcg_{}.pkl".format(basedir, myLambda))
print("csum...")
csum_solver = CSUM(x=X, y=y, Lambda=myLambda,
                   logname="{}/csum_{}.log".format(basedir, myLambda))
beta, fval_seq, running_time, iteration, epoch = csum_solver.solve(
    checkpoint_path="{}/csum_{}.pkl".format(basedir, myLambda))
print("cgd...")
cgd_solver = CGD(x=X, y=y, Lambda=myLambda,
                 logname="{}/cgd_{}.log".format(basedir, myLambda))
beta, fval_seq, running_time, iteration, epoch = cgd_solver.solve(
    checkpoint_path="{}/cgd_{}.pkl".format(basedir, myLambda))
