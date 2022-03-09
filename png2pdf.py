import os
import img2pdf

os.chdir('JFM')
for root, dirs, files in os.walk('.'):
    for file in files:
        fn = os.path.join(root, file)
        if fn.lower()[-4:] in ('.jpg', '.png'):
            print(fn)
            with open(fn[:-4] + '.pdf', 'wb') as f:
                f.write(img2pdf.convert(fn))
