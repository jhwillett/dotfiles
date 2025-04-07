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

What, me presbyopia?
* In Apple / System Settings / Accessibility / Display:
  * Under Pointer, set pointer size to medium.
  * Under Text, set text size to 16 pt.
  * Under Text, set menu bar size to large.

Minor stuff.
* In Apple / System Settings / Appearance:
  * Set Accent color to green.

Install Chrome:
* Launch Safari.
* Browse to https://google.com.
* Note invitation to install Chrome.
* Install Chrome, then launch.
* Note call to action to set Chrome as default browser.

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

Clean up Dock:
* Removed almost everything from Dock.
* Right-click or CTRL-Click on each icon, select Options / Remove From Dock.
* Remove all but Finder, Applications, and Settings.  Even remove Safari.

Install iTerm 3.5.12:
* Download https://iterm2.com/ as zip file.
* Open in Finder and install.
* Make text bigger ;)
* In iTerm / Settings;
  * General / Selection select “Copy to clip on selection”
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
* Preferred packages: `brew install emacs`

Configure Git:
* Check for presence of `~/.gitconfig`.
* Edit if you don't like it.
* If not found, run `git config --global --edit`.
* Can also do `git config user.name "Jesse H. Willett"`.
* Can also do `git config user.email "jhw@roundingerrorgames.com"`.

There is a `~/.gitconfig` included with https://github.com/jhwillett/dotfiles as
of 2025-04-07.  This is convenient for a JHW who is self-employed and only has
to worry about one online identity.  If JHW has multiple dev accounts which he
uses in different contexts, but JHW still wants to share the same dotfiles repo,
then this Git identity file should be excluded from the dotfiles just like we
exclude more sensitive credentials such as those under `~/.ssh/`.

https://docs.github.com/en/get-started/git-basics/set-up-git#authenticating-with-github-from-git

Configure Git to authenticate to GitHub:
* https://docs.github.com/en/get-started/git-basics/set-up-git#authenticating-with-github-from-git
* https://docs.github.com/en/get-started/git-basics/caching-your-github-credentials-in-git#git-credential-manager
* To access Rounding Error Games:
```
git clone https://github.com/RoundingErrorGames/roundingerrorgames.github.io.git
brew install --cask git-credential-manager
cd
git clone https://github.com/RoundingErrorGames/deciduous.git
```
The first repository is public and did not require any special access.  The
second repository is private and will only work if `git-credential-manager` can
successfully push you through an auth flow with GitHub.
