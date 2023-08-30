from glob import glob                                                           
import os,shutil
from TOAN import Test

TM = Test.getPath1()       
txt = glob(TM + '*.txt')
os.mkdir(TM + 'TXT')
out_dir = TM + 'TXT/'
cnt = len(txt)
for filename in txt:
    tenf = os.path.basename(filename)
    out = open(out_dir + tenf,'w')
    with open(filename, 'r') as f:
        while True:
            line = f.readline()
            if not line:
                break
            tmp = line.split()
            if int(tmp[0])==3:
                if float(tmp[1])> 0.25:
                    line ='0 '+ line[2:]
            out.writelines(line)
    out.close()
    cnt -= 1
    os.replace(out_dir + tenf, filename)
    print(cnt, tenf)
print('completed')
shutil.rmtree(out_dir)
