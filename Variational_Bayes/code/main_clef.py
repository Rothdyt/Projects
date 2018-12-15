import cv2
import os
import numpy as np
from sklearn import mixture
import matplotlib.pyplot as plt
import PIL
from PIL import Image

out_dir = './outputs/calssification/'
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

img_folder = "./data/iaprtc12/processed/"
sub_folder = [(f, os.path.join(img_folder, f)) for f in os.listdir(img_folder) if os.path.isdir(os.path.join(img_folder, f)) and f != '.ipynb_checkpoints']
db = {}
for i in range(len(sub_folder)):
    key, item = sub_folder[i]
    db[key] = [os.path.join(item, f) for f in os.listdir(item) if os.path.isfile(os.path.join(item, f)) and f != ".DS_Store"]

save = []
img_paths = []
for key in db.keys():
    print("process class {}".format(key))
    img_class = db[key]
    for img in img_class:
        img_paths.append(img)
        img_data = cv2.imread(img)
        color = ('b', 'g', 'r')
        im = np.array([])
        for i, col in enumerate(color):
            histr = cv2.calcHist([img_data], [i], None, [196], [30, 226])
            histr = histr.flatten()
            im = np.concatenate((im, histr))
        save.append(im)
save = np.asarray(save)


result = mixture.BayesianGaussianMixture(n_components=30, weight_concentration_prior_type="dirichlet_distribution",
                                         covariance_type='full', n_init=5, tol=1e-4).fit(save)
cluster = result.predict(save)
label_ = np.array(img_paths)

for img_class in range(30):
    print("process class {}".format(img_class))
    img_path = label_[cluster == img_class]
    if img_path.shape[0] > 1:
        random_idx = np.random.choice(range(1, img_path.shape[0]), size=9, replace=False)
        for i, img_idx in enumerate(random_idx):
            plt.subplot(3, 3, i+1)
            plt.subplots_adjust(wspace=0, hspace=0, left=0.3, right=0.8)
            img_data = Image.open(img_path[img_idx])
            plt.imshow(img_data)
            plt.axis('off')
        plt.savefig('./outputs/calssification/{}.jpg'.format(img_class), dpi=300)
