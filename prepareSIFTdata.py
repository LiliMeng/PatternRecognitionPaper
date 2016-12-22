"""

@author: Lili

prepare SIFT data
"""
import random
import numpy as np


pose_names = []

path = '/Users/jimmy/Desktop/images/posenet/Kings_frames/'
for i in range(0, 1534):
    buf3 = '%08d.xml' % i
    pose_names.append(path + buf3)


N = len(pose_names)

index = range(0,N)
#random.shuffle(index)

index = index[0:200]
print('sampled frame number is %d' % len(index))


f = file('scene_points_list.txt', 'w');
for item in pose_names:
    f.write('%s\n' % item)
f.close()


