from glob import glob                                                           
import os
from TOAN import Test

TM = Test.getPath()
        
fname = glob(TM + '*.jpg')
cnt=0
for filename in fname:
    tenf = Test.time_to_name()      
    os.rename(filename, TM + tenf + '.jpg')
    os.rename(filename[:-3] + 'txt', TM + tenf + '.txt')
    cnt += 1
    print(cnt)
