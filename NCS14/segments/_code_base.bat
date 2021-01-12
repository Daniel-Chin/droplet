pause

ffmpeg -loop 1 -i start.png -i start.mp3 -pix_fmt yuv420p -t 8.5 0.mp4
ffmpeg -loop 1 -i eq.png -i eq.mp3 -pix_fmt yuv420p -t 7 2.mp4
ffmpeg -i raw.mp4 -ss 24 -t 60 3.mp4
ffmpeg -loop 1 -i title0.PNG -pix_fmt yuv420p -t 2 4.mp4
ffmpeg -i raw.mp4 -ss 3:25.5 -t 22 5.mp4
ffmpeg -i raw.mp4 -ss 3:55 -t 2:30 6.mp4
ffmpeg -i raw.mp4 -ss 6:33.5 -t 53 7.mp4
ffmpeg -i raw.mp4 -ss 8:08 -t 44 8.mp4
ffmpeg -i raw.mp4 -ss 9:12 -t 1:06.5 9.mp4
ffmpeg -loop 1 -i refs.png -pix_fmt yuv420p -t 3 10.mp4

ffmpeg -i open_demo.mp4 -vsync 0 "od/1_%d.png"

pause
exit

ffmpeg -i fast.mp4 -i fast.wav -c:a aac -b:a 192K -map 0:v:0 -map 1:a:0 output.mp4

legacy {
    ffmpeg -i open_demo.mp4 -i open_demo.wav -map 0:v:0 -map 1:a:0 0.mp4
    ffmpeg -i raw.mp4 -ss 2:15.8 -t 17 3.mp4
}
