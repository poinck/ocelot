Paste clipboard content using the default urxvt extensions. Handles the X11 clipboard too.
The default **selection-to-clipboard** extension will put the selected content into the buffer automatically, no need to bind any key.

XMonad users can use the universal pasting:

```haskell
import XMonad.Util.Paste 
 , ((mod4Mask , xK_v), pasteSelection) 
```

# Installation
------------

Simply place the script in **/usr/lib/urxvt/perl/** for
system-wide availability or in **~/.urxvt/ext/** for user-only availability.
You can also put it in a folder of your choice, but then you have to add this
line to your **.Xdefaults/.Xresources**:

```bash
# Don't type ~ or $HOME below
URxvt.perl-lib: /home/user/your/folder/

# extensions to activate, do not omit selection-to-clipboard
URxvt.perl-ext-common           : selection-to-clipboard,pasta

# keyboard shortcut to trigger the extension
URxvt.keysym.Control-Shift-V    : perl:pasta:paste
```

# Requirements

* urxvt (rxvt-unicode) compiled with support for perl
