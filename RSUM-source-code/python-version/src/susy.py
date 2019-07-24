'''
File: susy.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-22 09:58
Last Modified: 2019-07-22 17:53
--------------------------------------------
Description:
'''
import os
from utils import get_data
from apcg import APCG
from rcsum import RCSUM
from csum import CSUM
from cgd import CGD
filename = os.path.basename(__file__).split('.')[0]
print(filename)
X, y = get_data("../db/SUSY")
print("Finishing Loading Data")
basedir = "../db/logs/{}".format(filename)
if not os.path.exists(basedir):
    os.makedirs(basedir)
    print("{} has been created!".format(basedir))

myLambda = 0.001
# print("rcsum...")
# rcsum_solver = RCSUM(x=X, y=y, Lambda=myLambda,
#                      logname="{}/rcsum_{}.log".format(basedir, myLambda))
# beta, fval_seq, running_time, iteration, epoch = rcsum_solver.solve(
#     checkpoint_path="{}/rcsum_{}.pkl".format(basedir, myLambda))
# print("apcg...")
# apcg_solver = APCG(x=X, y=y, Lambda=myLambda,
#                    logname="{}/apcg_{}.log".format(basedir, myLambda))
# beta, fval_seq, running_time, iteration, epoch = apcg_solver.solve(
#     checkpoint_path="{}/apcg_{}.pkl".format(basedir, myLambda))
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
