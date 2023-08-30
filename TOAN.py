import PySimpleGUI as sg
import datetime
class Test:
    def getPath():
        TM = ''
        while TM=='':
            TM = sg.PopupGetFolder(message='Hãy chọn thư mục',title='Filter OK')
            if TM != '' and TM != None:
                TM = TM.replace('\\','/') + '/'
            elif TM =='':
                sg.popup_error('Bạn chưa nhập folder')
            else:
                sg.popup('Bạn đã Cancel')
                quit()
        return TM
    def time_to_name():
                current_time = datetime.datetime.now() 
                name_folder = str(current_time)
                name_folder = list(name_folder)
                for i in range(len(name_folder)):
                    if name_folder[i] == ':':
                        name_folder[i] = '-'
                    if name_folder[i] == ' ':
                        name_folder[i] ='_'
                    if name_folder[i] == '.':
                        name_folder[i] ='-'
                name_folder = ''.join(name_folder)
                return name_folder