'''
File: pre-process-img.py
Author: Yutong Dai (rothdyt@gmail.com)
File Created: Thursday, 2018-12-06 01:31
Last Modified: Thursday, 2018-12-06 01:31
--------------------------------------------
Desscription:
'''
import os.path
import os
import PIL
from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
img_folder = "./data/iaprtc12/images/"
sub_folder = [(f, os.path.join(img_folder, f)) for f in os.listdir(img_folder) if os.path.isdir(os.path.join(img_folder, f))]
db = {}
for i in range(len(sub_folder)):
    key, item = sub_folder[i]
    db[key] = [os.path.join(item, f) for f in os.listdir(item) if os.path.isfile(os.path.join(item, f))]
for key in db.keys():
    print(key)
    img_class_db = db[key]
    if len(img_class_db) > 0:
        try:
            idxs = np.random.choice(range(0, len(img_class_db)), size=100, replace=False)
        except ValueError:
            idxs = np.random.choice(range(0, len(img_class_db)), size=len(img_class_db), replace=False)
            print("class {} less than 100".format(key))
        for idx in idxs:
            img_path = img_class_db[idx]
            img_data = Image.open(img_path).convert('RGB')
            img_data = img_data.resize((256, 256), PIL.Image.ANTIALIAS)
            dir_temp = os.path.dirname(img_path.replace("images", "processed"))
            if not os.path.exists(dir_temp):
                os.makedirs(dir_temp)
            file_name_temp = img_path.replace("images", "processed")
            img_data.save(file_name_temp)
