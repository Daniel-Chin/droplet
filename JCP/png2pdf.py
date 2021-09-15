import os
from img2pdf import convert
from chdir_context import ChdirContext

def main():
    for folder in ['figs', 'tableFigs']:
        with ChdirContext(folder):
            handleHere()

def handleHere(depth = 0):
    list_dir = os.listdir()
    for name in list_dir:
        print(' ' * depth, name)
        if os.path.isfile(name):
            if (
                name.lower().endswith('.png') 
            or 
                name.lower().endswith('.jpg')
            ):
                out_name = name[:-3] + 'pdf'
                with open(out_name, 'wb') as f:
                    f.write(convert(name))
        else:
            with ChdirContext(name):
                handleHere(depth + 1)

main()
