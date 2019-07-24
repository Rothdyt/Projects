'''
File: utils.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-09 13:15
Last Modified: 2019-07-24 13:56
--------------------------------------------
Description:
'''
import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_svmlight_file
import pickle


def get_data(filename, keep_sparse=False):
    data = load_svmlight_file(filename)
    if keep_sparse:
        pass
    else:
        # X, y = np.array(data[0].todense()), data[1].reshape(-1, 1)
        X, y = data[0].toarray(), data[1].reshape(-1, 1)
        y[y == -1] = 0
        X = (X - np.mean(X, axis=0)) / np.std(X, axis=0)
    return X, y


def generate_data(n, p, rho, snr=3, seed=0):
    beta = np.sqrt(rho / (1 - rho))
    np.random.seed(seed)
    x0 = np.random.standard_normal((n, p))
    z = np.random.standard_normal((n, 1))
    x = z * np.ones((n, p)) * beta + x0
    b = (-1) ** np.arange(1, p+1) * np.exp(-2 * (np.arange(p)) / 20)
    f = np.matmul(x, b.reshape(-1, 1))
    np.random.seed(seed)
    e = np.random.standard_normal((n, 1))
    k = np.std(f) / (np.std(e) * snr)
    prob = 1 / (1 + np.exp(-(f + k * e)))
    rng = np.random.RandomState(1234)
    y = np.array([rng.binomial(1, p) for p in prob]).reshape(-1, 1)
    return x, y


def plot_utils(name, title, folder='fseq', gap=False):
    mylambda = 0.01
    rcsum = pickle.load(open("../db/logs/{}/{}/rcsum_{}.pkl".format(folder, name, mylambda), "rb"))
    csum = pickle.load(open("../db/logs/{}/{}/csum_{}.pkl".format(folder, name, mylambda), "rb"))
    cgd = pickle.load(open("../db/logs/{}/{}/cgd_{}.pkl".format(folder, name, mylambda), "rb"))
    apcg = pickle.load(open("../db/logs/{}/{}/apcg_{}.pkl".format(folder, name, mylambda), "rb"))
    fig = plt.figure(figsize=(10, 10))
    ax = fig.add_subplot(2, 2, 1)
    if gap:
        candidate = [np.min(rcsum['fval_seq']), np.min(csum['fval_seq']), np.min(cgd['fval_seq']), np.min(apcg['fval_seq'])]
        global_min = np.min(candidate)
        ax.plot(range(len(rcsum['fval_seq'])), np.array(rcsum['fval_seq']) - global_min, 'r-', label='rcsum')
        ax.plot(range(len(csum['fval_seq'])), np.array(csum['fval_seq']) - global_min, 'b-.', label='csum')
        ax.plot(range(len(cgd['fval_seq'])), np.array(cgd['fval_seq']) - global_min, 'k--', label='cgd')
        ax.plot(range(len(apcg['fval_seq'])), np.array(apcg['fval_seq']) - global_min, 'm--', label='apcg')
        ax.set_yscale('log')
        ax.set_ylabel('optimal gap (log scale)')
        ax.set_xlabel('epoch')
    else:
        ax.plot(range(len(rcsum['fval_seq'])), rcsum['fval_seq'], 'r-', label='rcsum')
        ax.plot(range(len(csum['fval_seq'])), csum['fval_seq'], 'b-.', label='csum')
        ax.plot(range(len(cgd['fval_seq'])), cgd['fval_seq'], 'k--', label='cgd')
        ax.plot(range(len(apcg['fval_seq'])), apcg['fval_seq'], 'm--', label='apcg')
        ax.set_yscale('log')
        ax.set_ylabel('function value (log scale)')
        ax.set_xlabel('epoch')
    # ax.set_xlim(0, len(cgd['fval_seq']))
    ax.legend()
    ax.set_title("lambda = {}".format(mylambda))
    ax = fig.add_subplot(2, 2, 2)
    methods = ('rcsum', 'csum', 'cgd', 'apcg')
    y_pos = np.arange(len(methods))
    performance = [rcsum['time_used']/rcsum['epoch'],
                   csum['time_used']/csum['epoch'],
                   cgd['time_used']/cgd['epoch'],
                   apcg['time_used']/apcg['epoch']]

    ax.bar(y_pos, performance, align='center', alpha=0.5)
    plt.xticks(y_pos, methods)
    ax.set_ylabel('Time per Epoch (s)')
    ax.set_title(title)
    print("[Lambda]:{}".format(mylambda))
    print("[Total Time]  | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(rcsum['time_used'], csum['time_used'],
                                                                         cgd['time_used'], apcg['time_used']))
    print("[Time per Epoch] | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(performance[0], performance[1],
                                                                            performance[2], performance[3]))
    print("[Epoch] | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(rcsum['epoch'], csum['epoch'],
                                                                   cgd['epoch'], apcg['epoch']))
    mylambda = 1e-3
    rcsum = pickle.load(open("../db/logs/{}/{}/rcsum_{}.pkl".format(folder, name, mylambda), "rb"))
    csum = pickle.load(open("../db/logs/{}/{}/csum_{}.pkl".format(folder, name, mylambda), "rb"))
    cgd = pickle.load(open("../db/logs/{}/{}/cgd_{}.pkl".format(folder, name, mylambda), "rb"))
    apcg = pickle.load(open("../db/logs/{}/{}/apcg_{}.pkl".format(folder, name, mylambda), "rb"))
    ax = fig.add_subplot(2, 2, 3)
    if gap:
        candidate = [np.min(rcsum['fval_seq']), np.min(csum['fval_seq']), np.min(cgd['fval_seq']), np.min(apcg['fval_seq'])]
        global_min = np.min(candidate)
        ax.plot(range(len(rcsum['fval_seq'])), np.array(rcsum['fval_seq']) - global_min, 'r-', label='rcsum')
        ax.plot(range(len(csum['fval_seq'])), np.array(csum['fval_seq']) - global_min, 'b-.', label='csum')
        ax.plot(range(len(cgd['fval_seq'])), np.array(cgd['fval_seq']) - global_min, 'k--', label='cgd')
        ax.plot(range(len(apcg['fval_seq'])), np.array(apcg['fval_seq']) - global_min, 'm--', label='apcg')
        ax.set_yscale('log')
        ax.set_ylabel('optimal gap (log scale)')
        ax.set_xlabel('epoch')
    else:
        ax.plot(range(len(rcsum['fval_seq'])), rcsum['fval_seq'], 'r-', label='rcsum')
        ax.plot(range(len(csum['fval_seq'])), csum['fval_seq'], 'b-.', label='csum')
        ax.plot(range(len(cgd['fval_seq'])), cgd['fval_seq'], 'k--', label='cgd')
        ax.plot(range(len(apcg['fval_seq'])), apcg['fval_seq'], 'm--', label='apcg')
        ax.set_yscale('log')
        ax.set_ylabel('function value (log scale)')
        ax.set_xlabel('epoch')
    # ax.set_xlim(0, len(cgd['fval_seq']))
    ax.legend()
    ax.set_title("lambda = {}".format(mylambda))
    ax = fig.add_subplot(2, 2, 4)
    y_pos = np.arange(len(methods))
    performance = [rcsum['time_used']/rcsum['epoch'],
                   csum['time_used']/csum['epoch'],
                   cgd['time_used']/cgd['epoch'],
                   apcg['time_used']/apcg['epoch']]

    ax.bar(y_pos, performance, align='center', alpha=0.5)
    plt.xticks(y_pos, methods)
    ax.set_ylabel('Time per Epoch (s)')
    ax.set_title(title)
    print("[Lambda]:{}".format(mylambda))
    print("[Total Time]  | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(rcsum['time_used'], csum['time_used'],
                                                                         cgd['time_used'], apcg['time_used']))
    print("[Time per Epoch] | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(performance[0], performance[1],
                                                                            performance[2], performance[3]))
    print("[Epoch] | RCSUM:{} | CSUM:{} | CGD:{} | APCG:{}".format(rcsum['epoch'], csum['epoch'],
                                                                   cgd['epoch'], apcg['epoch']))
    if gap:
        plt.savefig("{}-gap.jpg".format(name), dpi=300)
    else:
        plt.savefig("{}.jpg".format(name), dpi=300)
    plt.show()

