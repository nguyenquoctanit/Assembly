from glob import glob                                                           
import os,shutil
from TOAN import Test

TM = Test.getPath1() 
def move(TM):  
    txt = glob(TM + '*.txt')
    try:
        os.mkdir(TM + 'TXT')
    except :
        pass
    out_dir = TM + 'TXT/'
    cnt = len(txt)

    for filename in txt:
        tenf = os.path.basename(filename)
        if tenf != 'classes.txt':
            out = open(out_dir + tenf,'w')
            with open(filename, 'r') as f:
                mylist = []
                while True:
                    line = f.readline()
                    if not line:
                        break
                    tmp = line.split(" ")  
                    line1 = [0.25, 0.75]     
                    a = float(line1[0]) 
                    b = float(line1[1]) 
                    # w = float(line1[2]) 
                    # h = float(line1[3]) 
                    # t1 = x - w/2     #tmp[1][2] = x1
                    # t2 = y - h/2
                    # p1 = x + w/2     #tmp[3][4] = x3
                    # p2 = y + h/2
                    if float(tmp[0])==3:
                        if (a < float(tmp[1]) < b):  
                            mylist.append(line)
                        else:
                            # cnt -=1
                            # if os.path.exists(filename[:-3]+'jpg'):
                            pass
                                # shutil.move(filename[:-3]+'jpg' , out_dir + tenf[:-3] + 'jpg')
                                # break
                    else:
                        # cnt -=1
                        # if os.path.exists(filename[:-3]+'jpg'):
                        mylist.append(line)  
            
            # print(mylist)
            with open(filename, 'w') as f:
                for ml in mylist:
                    f.write(ml)
    # for i in mylist :
    #     shutil.move(TM + i, out_dir + i) 
    # print('Tong Files', len(txt))

def xoa_txt_ko_co_jpg(TM):
    txt = glob(TM + 'TXT/' + '*.txt')
    c = 0
    for filename in txt:
        tenf = os.path.basename(filename)
        if not os.path.exists(filename[:-3] +'jpg'):
            c+=1
            os.remove(filename)
            print(c , tenf) 
    print('completed')   

move(TM)
xoa_txt_ko_co_jpg(TM)
                    
