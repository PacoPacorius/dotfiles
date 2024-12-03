# Guide to Reproduce this Laptop Arch install


## urxvt and fonts
URxvt seems to be unable to use reverse video on xft fonts. That's fine,
xft fonts look ugly on terminals anyway. Install `xfontsel`. This will 
be our bitmap fonts previewer. They aren't disabled on arch by default like
some other lame distros... Install `xorg-fonts-100dpi`, `xorg-fonts-75dpi`
and `xorg-fonts-misc` to get the core Xorg bitmap fonts. Open xfontsel
and start previewing. Type in the string that xfontsel generates (manually,
I've haven't found a way to copy yet) in a `~/.Xresources` file under the
resource `URxvt.font: `. Run `xrdb -merge .Xresources` to load the new 
font and run `urxvt` to see the results. Most fonts other than fixed and 
unifont will look a bit ugly, but you can try to fix them using 
`URxvt.letterSpace` and `URxvt.lineSpace` resources (or use cli options
`-letsp` and `-lsp` respectively, you shouldn't need to feed them higher 
values than +-4).

URxvt is pretty good at handling unicode stuff so don't worry if a font
doesn't have greek/cjk glyphs, it will handle that automatically for you.
Or you can even set a specific font you'd like vy adding a secondary font 
to the `URxvt.font` resource (comma separated!)
You can use `xfd` to preview all the glyphs of a font in a separate 
application.

#### Making a new fontdir
If you want to install custom fonts it might be a good idea to reprise
the old-school `~/.fonts ` directory. Make it, run `mkfontdir` and 
`mkfontscale` on it and then run `xset +fp /home//$USER/.fonts` to tell the
X server that it is a fontdir. Refresh the fonts cache with `xset fp rehash`
and run `fc-cache` for good measure. You should be able to see your newly
installed font in every app now, not just `xfontsel`.
