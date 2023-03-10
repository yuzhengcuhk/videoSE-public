import numpy as np
title = 'data\coco\coco_64_database_hash'  # 读取的文件名
A = np.load(title + '.npy')
k = 0
for i in range(len(A)): #generate pairs
    for j in range(i+1,len(A)):
        if np.array_equal(A[i],A[j]): #compare rows
            print (j)
            print (i)
            print ('/n')
            k = k + 1
print (k)
        #else: pass