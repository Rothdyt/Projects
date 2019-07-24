'''
File: generateSimulatedData.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-15 11:29
Last Modified: 2019-07-15 12:02
--------------------------------------------
Description:
'''
'''
File: duke-breast-cancer.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: 2019-07-11 12:32
Last Modified: 2019-07-13 19:55
--------------------------------------------
Description:
'''
from utils import generate_data
import pickle
import numpy as np

def save_data(n, p, rho):
    PATH = "../db/n{}-p{}-rho{}.pkl".format(n, p, rho)
    X, y = generate_data(n, p, rho)
    X = (X - np.mean(X, axis=0)) / np.std(X, axis=0)
    data = {'X': X, 'y': y}
    pickle.dump(data, open(PATH, "wb"))
    print("Data is saved at {}".format(PATH))


if __name__ == '__main__':
    n = 1000
    p = 100
    rho = 0.5
    save_data(n, p, rho)
