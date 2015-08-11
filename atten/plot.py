import numpy as np
from matplotlib import pyplot as plt

A1 = np.genfromtxt("atten1.out", delimiter=',')
A2 = np.genfromtxt("atten2.out", delimiter=',')

plt.plot((inc[30:70] - R1[30:70])/inc[30:70]) # plot reflection %
plt.plot(T1[30:70]/inc[30:70]) # plot transmission %

plt.show()
