ffmpeg -y -loop 1 -i colorbars/colorbar_980.png -t 3 -r 60 colorbars/980_60_3.mp4
ffmpeg -y -i Fig11b.mp4 -i colorbars/980_60_3.mp4 -filter_complex hstack _Fig11b.mp4

ffmpeg -y -loop 1 -i colorbars/colorbar_991.png -t 3 -r 60 colorbars/991_60_3.mp4
ffmpeg -y -i Fig21a.mp4 -i colorbars/991_60_3.mp4 -filter_complex hstack _Fig21a.mp4
ffmpeg -y -i Fig21b.mp4 -i colorbars/991_60_3.mp4 -filter_complex hstack _Fig21b.mp4

ffmpeg -y -loop 1 -i colorbars/colorbar_991.png -t 3 -r 30 colorbars/991_30_3.mp4
ffmpeg -y -i Fig21c.mp4 -i colorbars/991_30_3.mp4 -filter_complex hstack _Fig21c.mp4
