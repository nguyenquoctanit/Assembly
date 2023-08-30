from glob import glob                                                           
import os
import shutil
from TOAN import Test
TM = Test.getPath1()    
txt = glob(TM + '*.txt')
try:
    os.mkdir(TM + 'TXT')
except:
    pass
out_dir = TM + 'TXT/'
c = 0
for filename in txt:
    tenf = os.path.basename(filename)
    if tenf != 'classes.txt' and tenf != 'lastclasses.txt':
        out = open(out_dir + tenf,'w')
        with open(filename, 'r') as f:
            cls0 = 0
            while True:
                line = f.readline()
                if not line:
                    break
                tmp = line.split()
                # if tmp[0] not in ['6','7','8','9','10','11','12','13','14','15','16','17']:
                if tmp[0] not in ['0','1','2','3','12']: #KOPTC
                #if tmp[0] not in ['8','9','10','11','12','13','14']: #KOPTC
                # if tmp[0] not in ['6','7','8','9','10','11','12']:
                #if tmp[0] in ['0', '1', '3']:
                #if tmp[0] not in ['13']:
                # if tmp[0] not in ['6']:
                    out.writelines(line)
        f.close()
        out.close()
        c+=1
        os.replace(out_dir + tenf, filename)
        print(c, tenf)
print('compelted')
shutil.rmtree(out_dir)
