now=`date "+%Y-%m-%d_%H:%M"`
echo play | /Applications/VLC.app/Contents/MacOS/VLC  --intf=rc --rtsp-tcp rtsp://10.0.1.4/live_mpeg4.sdp --sout=file/avi:$now.avi
