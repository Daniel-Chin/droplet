from os import system
from re import TEMPLATE
import sys

TOP = 'TOP'
BOTTOM = 'BOTTOM'

class Text:
    def __init__(self, msg, template = None):
        self.msg = msg
        self.x = '(w-text_w)/2'
        if template is None:
            self.y = ''
        elif template is TOP:
            self.y = '10'
        elif template is BOTTOM:
            self.y = 'h-text_h-10'
        self.fontsize='30'

    def render(self):
        if '\n' in self.msg:
            y = int(self.y)
            s = []
            for msg in self.msg.split('\n'):
                t = Text(msg)
                t.x = self.x
                t.y = str(y)
                t.fontsize = self.fontsize
                y += 10 + int(self.fontsize)
                s.append(t.render())
            s = ','.join(s)
        else:
            s = "drawtext=fontfile=verdana.ttf:text='"
            s += self.msg
            s += "':fontcolor=black:fontsize="
            s += self.fontsize
            s += ":x="
            s += self.x
            s += ":y="
            s += self.y
        return s

def buildCommand(filename, texts):
    s = 'ffmpeg -y -i raw/' + filename + ' -vf "'
    s += ','.join([x.render() for x in texts])
    s += '" ' + filename
    return s

def preview(fn):
    system('explorer ' + fn)
    sys.exit(0)

def main():
    filename = '1_demo_benchmark_rising_bubble_case_1.mp4'
    texts = []
    texts.append(Text(
        'Rising bubble test case 1, 10\\:10 viscosity ratio', 
        TOP, 
    ))
    x = buildCommand(filename, texts)
    system(x)

    filename = '2_conv_drop_slide_2x4.mp4'
    texts = []
    texts.append(Text(
        'Droplet sliding \ndown a wall', 
        TOP, 
    ))
    texts[-1].fontsize = '70'
    texts.append(Text(
        'dt=\n0.00002', 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = '60'
    texts[-1].y = '400'
    texts.append(Text(
        'dt=\n0.00001', 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = '60'
    texts[-1].y = '1300'
    N_LEFT = 440
    N_PAD = 990
    texts.append(Text(
        'N=96', BOTTOM, 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = str(N_LEFT + N_PAD * 0)
    texts.append(Text(
        'N=128', BOTTOM, 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = str(N_LEFT + N_PAD * 1)
    texts.append(Text(
        'N=192', BOTTOM, 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = str(N_LEFT + N_PAD * 2)
    texts.append(Text(
        'N=256', BOTTOM, 
    ))
    texts[-1].fontsize = '48'
    texts[-1].x = str(N_LEFT + N_PAD * 3)
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '3_conv_merge_two.mp4'
    texts = []
    texts.append(Text(
        'Two droplets merging', 
        TOP, 
    ))
    texts.append(Text(
        'The gray markers in the background are visual helpers and do not interact with the physics. ' +
        'The contour lines show the velocity curl. ', 
        BOTTOM, 
    ))
    texts.append(Text(
        'N=64, dt=0.0005', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2-850-text_w'
    texts[-1].y = 'h-text_h*2-20'
    texts.append(Text(
        'N=96, dt=0.0002', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2-text_w/2'
    texts[-1].y = 'h-text_h*2-20'
    texts.append(Text(
        'N=128, dt=0.0001', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2+850'
    texts[-1].y = 'h-text_h*2-20'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '4_conv_merge_six_new.mp4'
    texts = []
    texts.append(Text(
        'six droplets merging', 
        TOP, 
    ))
    texts.append(Text(
        'The black markers in the background are visual helpers and do not interact with the physics. ' +
        'The contour lines show the velocity curl. ', 
        BOTTOM, 
    ))
    texts[-1].fontsize = '24'
    texts.append(Text(
        'N=96, dt=0.0002', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2-850-text_w'
    texts[-1].y = 'h-text_h*2-20'
    texts.append(Text(
        'N=128, dt=0.0001', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2-text_w/2'
    texts[-1].y = 'h-text_h*2-20'
    texts.append(Text(
        'N=192, dt=0.00005', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2+850'
    texts[-1].y = 'h-text_h*2-20'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '5_letter_demo.mp4'
    texts = []
    texts.append(Text(
        'Letters \\"IB\\" fall into an elastic pouch', 
        TOP, 
    ))
    texts[-1].fontsize = '36'
    texts[-1].y = '20'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '6_compare_droplet_size.mp4'
    texts = []
    texts.append(Text(
        'How sliding responds to droplet size', 
        TOP, 
    ))
    texts.append(Text(
        'Diameter=0.36', 
    ))
    texts[-1].fontsize = '36'
    texts[-1].x = 'w/2-650-text_w'
    texts[-1].y = 'h-text_h*2'
    texts.append(Text(
        'Diameter=0.4', 
    ))
    texts[-1].fontsize = '36'
    texts[-1].x = 'w/2-text_w/2'
    texts[-1].y = 'h-text_h*2'
    texts.append(Text(
        'Diameter=0.5', 
    ))
    texts[-1].fontsize = '36'
    texts[-1].x = 'w/2+680'
    texts[-1].y = 'h-text_h*2'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '7_demo_big_chase_small.mp4'
    texts = []
    texts.append(Text(
        'Big droplet catches up and merges with a small droplet', 
        TOP, 
    ))
    texts[-1].fontsize = '26'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '8_compare_resample.mp4'
    texts = []
    texts.append(Text(
        'The effect of interface re-sampling', 
        TOP, 
    ))
    texts.append(Text(
        'The gray markers in the background are visual helpers and do not interact with the physics. ', 
        BOTTOM, 
    ))
    texts[-1].fontsize = '24'
    texts.append(Text(
        'Re-sampling OFF', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2-370-text_w'
    texts[-1].y = 'h-text_h*2-20'
    texts.append(Text(
        'Re-sampling ON', 
    ))
    texts[-1].fontsize = '24'
    texts[-1].x = 'w/2+370'
    texts[-1].y = 'h-text_h*2-20'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '9_split.mp4'
    texts = []
    texts.append(Text(
        'Droplet splitting', 
        TOP, 
    ))
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '10_demo_wallMerge0.mp4'
    texts = []
    texts.append(Text(
        'Droplets merging at the wall', 
        TOP, 
    ))
    texts.append(Text(
        '''The black markers in the background are visual helpers and do not 
interact with the physics. The contour lines show the velocity curl. ''', 
    ))
    texts[-1].y = '930'
    texts[-1].fontsize = '24'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '11_demo_wallSplit0.mp4'
    texts = []
    texts.append(Text(
        'Droplet splitting at the wall', 
        TOP, 
    ))
    texts.append(Text(
        '''The black markers in the background are visual helpers and do not 
interact with the physics. The contour lines show the velocity curl. ''', 
    ))
    texts[-1].y = '930'
    texts[-1].fontsize = '24'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '12_demo_wallAttach0_short.mp4'
    texts = []
    texts.append(Text(
        'Droplet attaching to the wall', 
        TOP, 
    ))
    texts.append(Text(
        '''The black markers in the background are visual helpers and do not 
interact with the physics. The contour lines show the velocity curl. ''', 
    ))
    texts[-1].y = '930'
    texts[-1].fontsize = '24'
    x = buildCommand(filename, texts)
    system(x)
    
    filename = '13_demo_air_water_collide.mp4'
    texts = []
    texts.append(Text(
        'Air bubble collides with water droplet', 
        TOP, 
    ))
    texts.append(Text(
        '''The black markers in the background are visual helpers and do not 
interact with the physics. The contour lines show the velocity curl. ''', 
    ))
    texts[-1].y = '930'
    texts[-1].fontsize = '24'
    x = buildCommand(filename, texts)
    system(x)
    
#     filename = '14_demo_leave_trail.mp4'
#     texts = []
#     texts.append(Text(
#         'Droplet leaves a trial on the wall', 
#         TOP, 
#     ))
#     texts.append(Text(
#         '''The gray markers in the background are visual 
# helpers and do not interact with the physics. ''', 
#     ))
#     texts[-1].y = '910'
#     texts[-1].fontsize = '24'
#     x = buildCommand(filename, texts)
#     system(x)

main()
