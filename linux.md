## Contents

* [Audio, Video](#audio-video)
  * [Modify Command Prompt](#audio-video-modify-command-prompt)
  * [Manipulating Movies](#audio-video-manipulating-movies)
  * [Screen Recording](#screen-recording)
  * [Croping Screen Capture](#audio-video-croping-screen-capture)
  * [Video to Gif](#video-to-gif)
  * [Wav to Mp3](#wav-to-mp3)
* [Fdisk](#fdisk)
* [Lshw](#lshw-hardware-lister-for-linux)
* [Macchanger](#macchanger)
* [Nethogs](#nethogs)
* [SSH](#ssh)
  * [Authentication Agent Forwarding](#ssh-authentication-agent-forwarding)
  * [Sshuttle](#ssh-sshuttle)
  * [Socks](#ssh-socks)
  * [Tunnel](#ssh-tunnel)
* [Scp](#scp-secure-copy)
* [Books](#books)
* [Awesome Lists](#awesome-lists)
* [Other Lists](#other-lists)

## Audio, Video (A/V) <a id="audio-video"/>

The `avconv` audio and video encoder is contained within the libav-tools package. Make sure it is installed before you attempt to use it. In Debian based distros, a simple `apt-get install libav-tools` will do. In Linux Mint 20 onwards avconv is no longer available. The drop-in replacement is [ffmpeg](https://trac.ffmpeg.org/wiki/Capture/Desktop).

### Modify Command Prompt <a id="audio-video-modify-command-prompt"/>

#### For bash

A useful temporary change to make when screen recording for the masses is to anonymise your command prompt.  
Change command prompt from `<your-account>@<your-host>:/dir1/dir2/etc`  
to `root:/etc#`  
non-printable bytes [need to be contained](https://askubuntu.com/questions/24358/how-do-i-get-long-command-lines-to-wrap-to-the-next-line#answer-24422) within `\[` and `\]` escapes.  
run this command:
```shell
# Syntax
#          start colour scheme   colour   dislay current user name   stop colour scheme          start colour scheme   colour   base dir   stop colour scheme        non root or root user
PS1=' \[   \e[                   1;31m    \u:                        \e[m                 \]\[   \e[                   1;32m    \w         \e[m                 \]   \$ '
# Example:
PS1='\[\e[1;31m\u:\e[m\]\[\e[1;32m\w\e[m\]\$ '
# Technically you can do away with the first "\]" since there is a "\[" starting directly after it.
```
#### for ZSH

I've found the following works nicely:

```shell
export PROMPT='%{$fg[cyan]%}%#%{$reset_color%}'

```

Or if you are using ohmyzsh, pick a [theme](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) and just source the theme for a temporary change:

```
source /home/[your-user]/.oh-my-zsh/themes/robbyrussell.zsh-theme
```

Changing the font size of the terminal to 18 usually works well for viewers.  
Useful resources:  
* [http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/](http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/)
* [http://askubuntu.com/questions/145618/how-can-i-shorten-my-command-line-bash-prompt](http://askubuntu.com/questions/145618/how-can-i-shorten-my-command-line-bash-prompt)

### Manipulating Movies <a id="audio-video-manipulating-movies"/>

`-i` specifies the input files.  
`-ss` Start extracting from a certain point in time, the argument should be in the `hh:mm:ss[.xxx]` format.  
`-t` specifies the lenght of time to extract.  
`-vcodec` specifies which video codec to use for the output.

#### Extracting

For non subtitled:
```shell
# Example:
avconv -i Mr.Robot.S01E03.720p.HDTV.x264-IMMERSE.mkv -ss 00:23:08 -t 00:00:15 -vcodec libx264 cut.mkv
```

For subtitled:  
_"[Stream copy](https://libav.org/avconv.html#Stream-copy) is a mode selected by supplying the `copy` parameter to the `-codec` option. It makes `avconv` omit the decoding and encoding step for the specified stream"_.
```shell
# Example:
avconv -i in.mkv -ss 00:23:08 -t 00:00:06.5 -vcodec copy -acodec copy -scodec mov_text cut.mp4
```
#### Concatenating mp4 files:

The `-qscale n` argument (where `n` is a number between 1 (highest quality) and 31 (lowest quality)) allows for variable bitrates but with a constant quality.  
`-f` [Force](https://libav.org/avconv.html#Main-options) input or output file format.  
`-strict` specifies how strict the standards should be followed. Addition documentation around the arguments to be used can be found [here](https://libav.org/avconv.html#Codec-AVOptions).
```shell
# Example:
# Create first clip:
avconv -i clip.mp4 -qscale 3 out.mpeg
# Craete second clip:
avconv -i clip1.mp4 -qscale 3 out1.mpeg
# Create a third clip using previous two clips as input:
cat out.mpeg out1.mpeg | avconv -f mpeg -i - -vcodec mpeg4 -qscale 3 -strict experimental outcombined.mp4
```
Useful resources:

* [http://notesofaprogrammer.blogspot.co.nz/2013/10/join-multiple-video-files.html](http://notesofaprogrammer.blogspot.co.nz/2013/10/join-multiple-video-files.html)
* [https://libav.org/avconv.html#Tips](https://libav.org/avconv.html#Tips)

On Linux Mint 21, the above doesn't work. Instead:

With your mp4 files, these could be losslessly concatenated by first transcoding them to MPEG-2 transport streams. With H.264 video and AAC audio, the following can be used:

```shell
ffmpeg -i input1.mp4 -c copy intermediate1.ts
ffmpeg -i input2.mp4 -c copy intermediate2.ts
ffmpeg -i "concat:intermediate1.ts|intermediate2.ts" -c copy output.mp4
```

#### Concatenating mov files:

Once you have the files you would like to concatenate, create a file (let's call it `files_to_combine`) and add the files you want concatenated to it. The file should like similar to the following:

```
file ./cut1.mov
file ./cut2.mov
file ./cut3.mov
```

```shell
# Example:
ffmpeg -safe 0 -f concat -i files_to_combine -vcodec copy -acodec copy outcombined.mov
# Will concatenate cut1.mov, cut2.mov and cut3.mov from your current working directory into a file called outcombined.mov in your current working directory.
```

Useful resources:

* [Combine MOV video files](https://superuser.com/questions/1256223/combine-mov-video-files/1256224)

### Screen Recording <a id="screen-recording"/>

`-f` _"[Force](https://libav.org/avconv.html#Main-options) input or output file format. The format is normally autodetected for input files and guessed from file extension for output files."_ `x11grab` is the desktop format.  
`-s` specifies the width and height of the recorded area.  
`-r` is the frame rate.  
`-i` specifies the name of the input file, or in the below case, the `0.0` is display.screen number of your X11 server. This can work in conjunction with the `-f`. `0,0` is the x and y offset for grabbing.  
`nameOfFile.mov` is the name of the output file. `mov` is the quicktime format.
```shell
# Example:
avconv -f x11grab -s hd1080 -r 10 -i :0.0+0,0 nameOfFile.mov
```
Useful resources:  
* [http://www.penguinproducer.com/Blog/2012/06/command-for-recording-desktop/](http://www.penguinproducer.com/Blog/2012/06/command-for-recording-desktop/)
* [http://wiki.oz9aec.net/index.php/High_quality_screen_capture_with_avconv](http://wiki.oz9aec.net/index.php/High_quality_screen_capture_with_avconv)
* [http://unix.stackexchange.com/questions/73622/how-to-get-near-perfect-screen-recording-quality](http://unix.stackexchange.com/questions/73622/how-to-get-near-perfect-screen-recording-quality)
* [https://libav.org/avconv.html](https://libav.org/avconv.html)

Screen recording can also be [done with VLC](http://www.howtogeek.com/120202/how-to-record-your-desktop-to-a-file-or-stream-it-over-the-internet-with-vlc/), including [setting the position and size](https://forum.videolan.org/viewtopic.php?t=101510) of the grab.

### Croping Screen Capture <a id="audio-video-croping-screen-capture"/>

`-vf` specifies the crop of `<width>`:`<height>`:`<x-offset>`:`<y-offset>` of the source video to use in the output.
```shell
# Example:
avconv -i input.mov -vf crop=1920:910:0:122 output.mov
```
Useful resource:  
* [http://oliversmith.io/technology/2012/12/30/cropping-videos-using-ffmpeg-libav-avconv/](http://oliversmith.io/technology/2012/12/30/cropping-videos-using-ffmpeg-libav-avconv/)

### Video to Gif <a id="video-to-gif"/>

`ffmpeg` works well for this. I often use this technique for converting videos to gifs to add to wikis or git `README`s.

```shell
ffmpeg -i input.mov -pix_fmt rgb24 output.gif
```

This may create a file that is too large, so you can reduce the frame rate and size of the image as well. You can also set where the image should start from and the duration, with the following command:

`-ss <start-point>`  
`-i <input-file>`  
`-pix_fmt [stream_specifier]`  
`-r <frame-rate>`. I find that setting this to `2` usually provides as small as posible image size while keeping enough definition for [CLI images](https://user-images.githubusercontent.com/2862029/48294186-aa449600-e4e7-11e8-8c0e-418ff56adc8a.gif).  
`-s <size-of-image>` 800 wide seems to be fine for git readme files, then setting the width to 900 on the actual `README.md`  
`-t <length>`  

```shell
ffmpeg -ss 00:00:00.000 -i input.mov -pix_fmt rgb24 -r 2 -s 800x700 -t 00:00:10.000 output.gif
```

If you want to add the image file to your git wiki or readme, simply navigate to your github repository issues, click "New Issue", drag your image into the "Write" box, and your image will upload, copy the url and add it to your wiki page or readme, you don't need to actually create the issue.

## [Wav to Mp3](https://trac.ffmpeg.org/wiki/Encode/MP3)

Converting your riped CD songs to .mp3:

```shell
ffmpeg -i Track2.wav -codec:a libmp3lame -qscale:a 2 Track2.mp3
```

## Fdisk

Shows partition information.
```shell
# Run command as root.
fdisk -l
```

## [Lshw: HardWare LiSter for Linux](https://github.com/lyonel/lshw) <a id="lshw-hardware-lister-for-linux"/>

Provides detailed information on the hardware configuration of the machine.
```shell
# Run command as root.
# Shows disk info.
# Example:
lshw -C disk
```
`-C`_`class`_ is an alias for `-class`_`class`_  
You can check all the _class_ types at the [home page](http://www.ezix.org/project/wiki/HardwareLiSter)  
The [man page](https://linux.die.net/man/1/lshw) is quite useful also.

## [Macchanger](https://github.com/alobbs/macchanger)

On a debian based system, install `macchanger` as root with:  
`apt-get install macchanger`  
Common usage example:
```shell
# Run commands as root.
# Syntax:
ifconfig <interface> down
macchanger -r <interface>
ifconfig <interface> up
```

## [Nethogs](https://github.com/raboof/nethogs)

On a debian based system, install `nethogs` as root with:  
`apt-get install nethogs`  
```shell
# Run command as root.
# Syntax:
nethogs [options] [device(s)]
# Example:
nethogs eth0
```
Some usage details [here](http://www.cyberciti.biz/faq/linux-find-out-what-process-is-using-bandwidth/)

## Scp: Secure copy <a id="scp-secure-copy"/>

`scp` uses `ssh` to copy.

`-p` preserves modification times, access times, and modes from the original file.  
`-r` is for recursion.  
`-P` Specify for non-default port.

Copy all files within a given directory from your local machine to a given directory on a remote host.
```shell
# Syntax:
scp -p -r -P <non-default-port> <given-directory>/* <your-file-server-account>@<file-server>:/file-server/path/<given-directory>/
```
Copy a given directory recursivly from remote host to within your current directory. Note the dot at the end of the command.
```shell
# Syntax:
scp -p -r -P <non-default-port> <your-file-server-account>@<file-server>:/file-server/path/<given-directory> .
```

## SSH

### Authentication Agent Forwarding <a id="ssh-authentication-agent-forwarding"/>

Using the `-A` argument allows you to forward the authentication agent connection. Essentially this allows you to hop (or pivot) from one ssh server to another.  
Example: laptop -> mail-server (through router) -> file-server  

You need to be aware that using agent forwarding opens an attack vector for  
"_users with the ability to bypass file permissions on the remote host (for the agent's Unix-domain socket) can access the local agent through the forwarded connection. An attacker cannot obtain key material from the agent, however they can perform operations on the keys that enable them to authenticate using the identities loaded into the agent._"  
> SSH man page

Example of copying a file from file-server (through router), to mail-server, to your laptop.

```shell
# In one terminal:
#    Find file first:
#    SSH to mail-server from WAN.
ssh <your-mail-server-account>@<router-wan-interface> -A -p <non-default-port>
#    From mail-server SSH to file-server.
ssh <your-file-server-account>@<file-server> -p <non-default-port>
#    Now you are on the file-server, locate the file to copy.
         
# In 2nd terminal: Copy from file-server to mail-server:
ssh <your-mail-server-account>@<router-wan-interface> -A -p <non-default-port>
scp -P <non-default-port> <your-file-server-account>@<file-server>:/file-server/path/filetocopy.txt ~/
         
# In 3rd terminal: Copy from mail-server to laptop:
scp -P <non-default-port> <your-mail-server-account>@<router-wan-interface>:/home/<your-mail-server-account>/filetocopy.txt /home/you/
```
Multi-hop [example](http://sshmenu.sourceforge.net/articles/transparent-mulithop.html).

### [Sshuttle](https://github.com/apenwarr/sshuttle/tree/master) <a id="ssh-sshuttle"/>

`sshuttle` combines an `ssh` tunnel with a system wide proxy, sometimes called a poor mans VPN.

On a debian based system, install `sshuttle` as root with:  
`apt-get install sshuttle`  
For a later version:  
`git clone git://github.com/apenwarr/sshuttle`  
After the server you intend to tunnel though has `sshd` running, from your local machine, run:  
```shell
# Syntax:
sshuttle --dns -vvr <proxy-user-account>@<proxy> 0/0
# Example:
sshuttle --dns -vvr kim@myproxy.net 0/0
```
Now all network traffic is `ssh` proxied through the `proxy` server, including DNS.

Test with: [http://ifconfig.me/](http://ifconfig.me/)  
Test if there is any leakage by visiting the DNS leak test [Web site](https://www.dnsleaktest.com/) and clicking on the Standard test button, you can also visit the IP/DNS Detect [site](http://ipleak.net/).

`-v` is just additional verbosity.  
`-r`, `--remote`_`=[username@]sshserver[:port]`_ _is the remote hostname and optional username and ssh port number to use for connecting to the remote server._  
`0/0` is short for `0.0.0.0/0`, which represents the subnets to route over the `ssh` tunnel. The usage of `0/0` routes all the traffic except DNS requests to the remote server.  
`--dns` will also proxy your DNS queries through the server you are tunneled to.

### Socks <a id="ssh-socks"/>
Setup socks proxy through `<proxy>`
```shell
ssh -D9090 <proxy-user-account>@<proxy>
```
Useful resource:  
* [http://linux.byexamples.com/archives/115/ssh-dynamic-tunneling/](http://linux.byexamples.com/archives/115/ssh-dynamic-tunneling/)

### Tunnel <a id="ssh-tunnel"/>
To forward (or tunnel) from one machine to another, you need to use the -L argument for Local port forwarding.  
`localhost` is the optional default `hostname`.  

```shell
# Syntax:
ssh -L [hostname:]<localport>:<localhost-name-on-remote-host>:<remoteport> <proxy-user-account>@<proxy>
# Example:
# Bind default proxy port (9090) to Tor port (9050) on proxy.net
# In this example, port 9050 is only accessible to the localhost interface of proxy.net
ssh -L 127.0.0.1:9090:127.0.0.1:9050 kim@myproxy.net
# If port 9050 was accessible to proxy.net interfaces other than localhost, then we could do the following:
ssh -L 127.0.0.1:9090:proxy.net:9050 kim@myproxy.net
```
From there, if Tor is listening on port `9050` of `proxy.net` and you set your browsers proxy to `localhost:9090` all browsing traffic will go through Tor, except DNS.

You can also do remote port forwarding by swapping the `-L` for `-R`, the rest of the command syntax stays the same. What this allows us to do is open a tunnel from a remote machine to our local machine. Further details can be seen [here](http://blog.trackets.com/2014/05/17/ssh-tunnel-local-and-remote-port-forwarding-explained-with-examples.html).

Details on tunneling RDP on my [blog post](https://blog.binarymist.net/2010/08/26/installation-of-ssh-on-64bit-windows-7-to-tunnel-rdp/).

You can also **combine tunnel with socks proxy**:
```shell
# Syntax:
ssh -D9090 -L 127.0.0.1:9090:127.0.0.1:9050 <proxy-user-account>@<proxy>
```

## Books


## Awesome Lists


## Other Lists

* [https://www.blackmoreops.com/2016/12/20/kali-linux-cheat-sheet-for-penetration-testers/](https://www.blackmoreops.com/2016/12/20/kali-linux-cheat-sheet-for-penetration-testers/) - Kali Linux Cheat Sheet for Penetration Testers.
* [https://www.rebootuser.com/?p=1623](https://www.rebootuser.com/?p=1623) - Local Linux Enumeration & Privilege Escalation Cheatsheet.


## License

[![Creative Commons License](http://i.creativecommons.org/l/by/4.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)

This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/)
