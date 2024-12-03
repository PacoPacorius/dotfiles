# Guide to Reproduce this Desktop Arch install
I've had this desktop for 10 years as of 2024, always had Windows. I think it
initially came with Win8 which I eventually upgraded to Win10. Over the years
the HDD on this machine in conjunction with the ever-increasing mammoth 
Windows updates made this computer almost unusable on Windows... Whenever
an update would start, it would grind almost to a halt. Every time I booted
it up I had to wait 15 minutes before I could do any disk operations...
Until someday it stopped booting altogether. It froze on a loading screen. 
I thought the hard drive was toast for sure... I didn't manage to reset it 
to factory settings and for some reason Microsoft's website didn't let me
download a Win10 ISO... So I naturally decided to install Arch Linux, since
I liked it so much on my laptop.

Getting this install to a working condition from bare-bones to actually 
somewhat usable took me 5 days of long hours on the computer... Most of 
the time I just couldn't remember what I had done to make my other Arch 
functional. Having this guide to remember which steps I took for which
aspect of the install will not only hopefully save me tons of time, but also 
provide with a nice record of my Linux adventures.

Prepare for some Linux esoterica!

## Xfce and Chicago95
I opted for a Win95 classic look as opposed to my laptop's WindowMaker.

## REAPER and pipewire

## Vim plugins outside of Plug

## Git And Remote GitHub Repos
Install openssh package. enable/start the ssh-agent.service with systemd. 
It should be a user unit (systemctl --user). Generate a SSH key. 
Run the command `ssh-keygen -t ed25519 -C "your_email@example.com"`, you 
can see your GitHub email by typing `git config user.email`.
Run `eval "$(ssh-agent)"` and then `ssh-add path-to-private-key`. Then add
the public key to GitHub. This should make pushing and pulling from remote
repositories work. If it doesn't, make sure ssh-agent is running and re-run
`eval "$(ssh-agent)"`. If the command returns a pid, this is good and it 
should work.

If it still doesn't work, make sure to have the private key under one of 
GitHub's standard names for private keys (id_rsa for example). GitHub will
sometimes only look for those and will ignore custom names. I have a symlink
in this desk-arch install to a custom named private key file.

## g15daemon for my G15 keyboard
There is a daemon to drive the extra features of the G15 keyboard! I've used
this bad boy for 15 years and I never knew it could draw on the LCD screen 
and save macros.

#### Installation
Make sure libusb. Install libg15 from the AUR.  Then install libg15render 
also from the AUR.
Run the following commands to install and correctly patch g15daemon:
```
git clone https://aur.archlinux.org/g15daemon.git
sed -i "s/depends=('libg15render>=3.0')/depends=('libg15render')/" g15daemon/PKGBUILD
sed -i "s/pkgver=3.0.4/pkgver=3.0.4a/" g15daemon/PKGBUILD
sed -i "s/sha512sums=('4adbb11ca8128bbaff5ad1dee17ddcfcdfca589f7e8a1a264127dd9d5aec39e07e4986a4b78f4199fb7f3e12979fd8d50a851b047b6cb8cfa13410aa59df062a')/sha512sums=('SKIP')/" g15daemon/PKGBUILD
cd g15daemon
makepkg
pacman -U g15daemon-3.0.4a-1-x86_64.tar.zst
```

Why do I need to run all these? Long story short, some drama happened, but 
they should run with no problem. Running g15daemon as root now should
work, but I want to make it boot on startup. Inside the 
`src/src/g15daemon-3.0.4a/contrib/init/` folder there is a sample 
g15daemon.service file. I uncommented the `After=sys-subsystem-usb-g15.device`
line because I want a bit less ambiguousness and copied it under
`/etc/systemd/system/`. Finally I enabled the service.


#### Making the extra keys 

This should make the LCD work, but the extra G keys probably won't 
be recognized by the X server. Even if they do the X server will probably 
assign random garbage functions to them. Install xorg-xmodmap. 
Copy the `contrib/Xmodmap` file to `~/.Xmodmap`.
Run `xmodmap ~/.Xmodmap` to test the changes. A nice testing
tool is `xbindkeys -mk`, if xbindkeys is installed.
Add the line `xmodmap /home/pacopacorius/.Xmodmap &` to the `~/.xinitrc` 
file to set the keys when the X server is run. 

This is just to be able to bind the G keys to X11 shortcuts. The Macro 
Record key isn't functional yet.

#### Man pages
Just copy everything inside `Documentation/` in `/usr/local/share/man`.
Now you can read the man pages with `man`!
