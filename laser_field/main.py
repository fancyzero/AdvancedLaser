import numpy as np
import matplotlib.pyplot as plt
import Perlin
from PIL import Image

n = 128
X, Y = np.mgrid[0:n, 0:n]

v = np.ndarray((n,n))
pnf = Perlin.PerlinNoiseFactory(2,octaves=16)
for x in range(0,n):
    for y in range(0, n):
        v[x,y]=(pnf(float(x)/n,float(y)/n)+1)/2 * 255;

im = Image.fromarray(v.astype(int)).convert('RGB')

im.save("field.bmp")
gx = np.gradient(v)[1]
gy = np.gradient(v)[0]

plt.quiver(X,Y,gx,gy)


#plt.quiver(X,Y,v)

#
# plt.xlim(-1, n)
# plt.xticks(())
# plt.ylim(-1, n)
# plt.yticks(())

plt.show()