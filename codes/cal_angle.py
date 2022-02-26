from cmath import atan, pi
import pandas as pd
import numpy as np
import math

df1 = pd.read_csv("./3dgraphdata.csv", encoding='latin1', on_bad_lines='skip')
lst = []

for i in range(1,len(df1)):
    x1 = float(df1.iat[i,0])
    y1 = float(df1.iat[i,1])
    x2 = float(df1.iat[i-1,0])
    y2 = float(df1.iat[i-1,1])
    if x1 >= x2 and y1 >= y2:
        if x1 == x2:
            angle = pi/2
        else:
            angle = math.atan(abs(y2-y1)/abs(x2-x1))
    elif x1 < x2 and y1 >= y2:
        angle = pi-math.atan(abs(y2-y1)/abs(x2-x1))
    elif x1 < x2 and y1 < y2:
        angle = pi+math.atan(abs(y2-y1)/abs(x2-x1))
    elif x1 >= x2 and y1 < y2:
        if x1 == x2:
            angle = 3*pi/2
        else:
            angle = 2*pi-math.atan(abs(y2-y1)/abs(x2-x1))
    ang = angle/(2*pi)*360
    df1.at[i,2] = ang
    lst.append(ang)
    if(len(lst) == 10):
        df1.at[i/10,3] = sum(lst)/10
        lst = []

df1.to_csv("result.csv")    