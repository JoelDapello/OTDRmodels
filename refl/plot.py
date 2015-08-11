import numpy as np
from matplotlib import pyplot as plt

inc = np.genfromtxt("inc.txt", delimiter=',')
R = np.genfromtxt("atten1.txt", delimiter=',')
T = np.genfromtxt("atten2.txt", delimiter=',')

plt.plot((inc[30:70] - R1[30:70])/inc[30:70]) # plot reflection %
plt.plot(T1[30:70]/inc[30:70]) # plot transmission %

plt.show()
