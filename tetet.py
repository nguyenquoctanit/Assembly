from glob import glob                                                           
import os,shutil,math
from TOAN import Test
TM = Test.getPath1() 
save_path = Test.getPath2()          
def loc(TM):
    txt = glob(TM + '*.txt')
    c = len(txt)
    mylist =[]
    for filename in txt:
        tenf = os.path.basename(filename)
        with open(filename, 'r') as f:
            while True:
                line = f.readline()
                if not line:
                    break
                # tmp = line.split(" ")[1:]
                tmp = line.split()
                for i in tmp:
                    if float(i) < 0 :
                        c -= 1
                        mylist.append(tenf)
                        if os.path.exists(filename[:-3]+'jpg'):
                            shutil.move(filename[:-3]+'jpg' , save_path  + tenf[:-3] + 'jpg')
                            print(f'{c}_{tenf}') 

    for i in mylist:
        if os.path.exists(TM + i):
            shutil.move(TM + i, save_path + i) 
            print('Tong Files', len(txt)) 


def xoa_txt_ko_co_jpg(save_path):
    txt = glob(save_path+ '*.txt')
    c = 0
    for filename in txt:
        tenf = os.path.basename(filename)
        if not os.path.exists(filename[:-3] +'jpg'):
            c+=1
            os.remove(filename)
            print(c , tenf) 
    print('completed') 

loc(TM)
xoa_txt_ko_co_jpg(save_path)