import numpy as np
from matplotlib import pyplot as plt

f = open("box0.hack").readlines()
pwrMAX = []
for i in range(0, len(f)):
    if "data ranges" in f[i]:
        pwrMAX.append(float(f[i].split('to ')[1].split('.\n')[0]))

def split_list(a_list):
    half = len(a_list)/2
    return a_list[:half], a_list[half:]

x1, x2 = split_list(fluxes)
x1 = np.asarray(x1)
x2 = np.asarray(x2)

plt.plot((inc[30:70] - R1[30:70])/inc[30:70]) # plot reflection %
plt.plot(T1[30:70]/inc[30:70]) # plot transmission %

plt.show()
