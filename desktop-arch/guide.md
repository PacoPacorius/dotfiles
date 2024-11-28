# Guide to Reproduce this Desktop Arch install

## Xfce and Chicago95

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
Install libg15 from the AUR.  Then install libg15render also from the AUR.
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

Long story short, some drama happened. Running g15daemon as root now seems
to work, but I want to make it boot on startup. Inside the 
`src/src/g15daemon-3.0.4a/contrib/init/` folder there is a sample 
g15daemon.service file. I uncommented the `After=sys-subsystem-usb-g15.device`
line because I want a bit less ambiguousness and copied it under
`/etc/systemd/system/`. Finally I enabled the service.

This should make the LCD work, but the extra macro G keys probably won't 
be recognized by the X server. Even if they do the X server will probably 
assign random garbage functions to them. **Can I still assign macros in this 
mode?** Install xorg-xmodmap. Copy the `contrib/Xmodmap` file to `~/.Xmodmap`.
Run `xmodmap ~/.Xmodmap` to test the changes. A nice testing
tool is `xbindkeys -mk`, if xbindkeys is installed.
Add the line `xmodmap /home/pacopacorius/.Xmodmap &` to the `~/.xinitrc` 
file to set the keys when the X server is run. 


This will probably disable the Macro Record key however.

#### Making the extra keys 
