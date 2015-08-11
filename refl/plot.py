import numpy as np
from matplotlib import pyplot as plt

f = open("atten1000.out").readlines()
fluxes = []
for i in range(0, len(f)):
    if "flux" in f[i]:
        fluxes.append(float(f[i].split(',')[2].split('\n')[0]))

def split_list(a_list):
    half = len(a_list)/2
    return a_list[:half], a_list[half:]

x1, x2 = split_list(fluxes)
x1 = np.asarray(x1)
x2 = np.asarray(x2)

plt.plot((inc[30:70] - R1[30:70])/inc[30:70]) # plot reflection %
plt.plot(T1[30:70]/inc[30:70]) # plot transmission %

plt.show()
