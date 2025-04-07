# HOWTO Make a Fresh MacOS Install Feel Right

This doc last updated 2025-04-07, during install of a newly-purchased
refurbished 2024 M4 Macbook Pro which came with newly-installed MacOS Sequoia
15.1.

During initial MacOS setup:
* Used my personal AppleID.
* Did not enable payments, fingerprint, or location services.
* Did not enable Siri, Apple Intelligence, or most everything else.
* Did enable encrypted drives.
  * _NOT_ via AppleID.
  * _NOT_ via a contact account.
  * Via recovery key, which _NOT_ via a contact account.
* Once on clean desktop, restarted to verify bootability and password.

Make typing feel right:
* In Apple / System Settings / Keyboard:
  * Set key repeat rate to "fast".
  * Set delay until repeat to "short".
  * Much better!

Install Chrome:
* Launch Safari.
* Browse to https://google.com.
* Note invitation to install Chrome.
* Install Chrome, then launch.
* Note call to action to set Chrome as default browser.

Clean up Dock:
* Removed almost everything from Dock.
* Right-click or CTRL-Click on each icon, select Options / Remove From Dock.
* Remove all but Finder, Applications, and Settings.  Even remove Safari.

Install iTerm 3.5.12:
* Download https://iterm2.com/ as zip file.
* Open in Finder and install.
* Make text bigger ;)
* In iTerm / Settings;
  * General / Selection deselect “Copy to clip on selection”
  * Profiles / Text / Font select Andale Mono 22
  * Terminal set scrollback lines to 10000.

Install Emacs For Mac:
  * https://emacsformacosx.com/ has an installer download that "just works".
  * Configuration will come later, from dotfiles on GitHub.

Installed Xcode and Homebrew:
* Launch Terminal.
* Run `xcode-select --install`.
* Note ToS dialog spawned in background, must be alt-tabbbed to front.
* Accept ToS and complete install.

Set preferred shell from Mac default of `zsh` to `bash`:
* Run `chsh -s /bin/bash`.

Install [JHW's dotfiles|https://github.com/jhwillett/dotfiles]:
```
cd
git init
git remote add origin https://github.com/jhwillett/dotfiles.git
git pull origin main
```

Exit iTerm2 and relaunch, note larger fonts, $PS1 with `[jhw@mac ~]`, and that
`printenv SHELL` reports `/bin/bash`.

Exit Emacs and relaunch.
* Note new fonts and screen position.
* Note that `rust-mode` is not found, with suggestion of `emacs --debug-init`.
* Issue Emacs command `M-x package-install<ENTER>rust-mode<ENTER>`.
* Issue Emacs command `M-x package-install<ENTER>beancount<ENTER>`.
* Note, the Emacs key combo M-x aka META-x means the MacOS key combo option-x.
* Relaunch Emacs again.
* Note familiar context coloring when you reload this file.

Install Homebrew:
* Browse to https://brew.sh/, run provided instruction:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Uninstall as much pre-installed cruft as permitted:
* Under Finder / Applications.
* Right-click on apps, look for Move To Trash.
* You will find regrettably few pre-installed apps which can be deleted.
* In Monterey I found a handful of things which I could cut.
* In Sequoria, I found zero pre-installed apps which were removable.
  * Only Emacs, iTerm, and Chrome were removable.
  * I installed all of these myself.
* Crap like Stocks and Apple TV is considered a "core component" of MacOS. :/
* Maybe the DoJ will unbundle Apple after they forced Google to sell Chrome.

Review iCloud cruft and minimize.
* Under System Settings / Apple Account / iCloud / Saved to iCloud / See All.
* Disable everything, except maybe "Find My Mac".
* Under iCloud Drive / Apps syncing to iCloud Drive, make sure all are disabled.
