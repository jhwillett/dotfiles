# dotfiles/setup/new-mac.mk
#
# Collection of commands used to install or update key development software in a
# new MacOs system.
#
#   make -f ~/setup/new-mac.mk toolchain
#

SHELL := /bin/sh -o pipefail
.DEFAULT: toolchain

THISFILE := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
BUILDDIR := $(dir $(THISFILE))build

.PHONY: peek
peek: 
	@echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo "THISFILE:      $(THISFILE)"
	@echo "BUILDDIR:      $(BUILDDIR)"

.PHONY: clean
clean:
	rm -rf $(BUILDDIR)

# Some things I did once to get more versions of the Android API installed
# locally, which I might want to repeat or riff on on some other system:
#
#	avdmanager create avd -n test -k "system-images;android-27;google_apis;x86"
#
.PHONY: toolchain
toolchain: $(BUILDDIR)/toolchain.ok
$(BUILDDIR)/toolchain.ok:
	mkdir -p $(dir $@)
	touch $@

.PHONY: brew
brew: $(BUILDDIR)/brew.ok
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/brew.ok
$(BUILDDIR)/brew.ok:
	brew update
	brew install emacs
	mkdir -p $(dir $@)
	touch $@

.PHONY: rust
rust: $(BUILDDIR)/rust.ok
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/rust.ok
$(BUILDDIR)/rust.ok:
	rustup update
	rustup update stable
	rustup default stable
	rustc --version
	rustup target add armv7-linux-androideabi aarch64-linux-android
	rustup target add i686-linux-android x86_64-linux-android
	rustup target add aarch64-apple-darwin x86_64-apple-darwin 
	rustup target add x86_64-pc-windows-gnu  i686-pc-windows-gnu
	rustup target add x86_64-pc-windows-msvc i686-pc-windows-msvc
	brew install mingw-w64
	cargo --version
	cargo install cargo-ndk cargo-machete cargo-outdated
	mkdir -p $(dir $@)
	touch $@

.PHONY: diesel
diesel: $(BUILDDIR)/diesel.ok
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/diesel.ok
$(BUILDDIR)/diesel.ok: $(BUILDDIR)/rust.ok
$(BUILDDIR)/diesel.ok:
	brew install sqlite
	cargo install diesel_cli --no-default-features --features sqlite
#	brew install mysql sqlite postgresql
#	cargo install diesel_cli
	mkdir -p $(dir $@)
	touch $@

# Per https://apple.stackexchange.com/questions/105846, the command:
#
#   defaults write com.apple.CrashReporter UseUNC 1
#
# changes it so crash reports are are notif instead of a popup.  This is nice to
# have when developing software which crashes a lot.
#
.PHONY: mac
mac: $(BUILDDIR)mac.ok
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/mac.ok
$(BUILDDIR)/mac.ok:
	defaults write com.apple.CrashReporter UseUNC 1

# sdkmanager is installed with android-commandlinetools, but it will not run
# without a Java Runtime.
#
# LOCAL_ARCH can be x86_64, which I used on an old Intel MacBook and would
# imagine using on Windows, and arm64-v8a which I use now on newer Mac silicon.
#
# NDK_VERSION comes from https://developer.android.com/ndk/downloads.  I chose
# the latest for my most-recent install.  Note that there is some hard-coding in
# ~/.bashrc where we set the ANDROID_NDK_HOME, which is sensitive to this
# valuye.
#
# ANDROID_VERSIONS is just whatever I find I need.  The make rules are built
# incrementally.  You can add a new value to ANDROID_VERSIONS and re-run:
#
#   make -f ~/setup/new-mac.mk android
#
# ...and expect a minimal incremental install.
#
LOCAL_ARCH       := arm64-v8a
NDK_VERSION      := 27.2.12479018
#ANDROID_VERSIONS := 21 23 27 29 30 31 34 35
ANDROID_VERSIONS := 21 35
CURRENT_VERSION  := 35

.PHONY: android
android: $(BUILDDIR)/android.ok
	echo
	sdkmanager --list_installed
	echo
	avdmanager list avd
	echo
	adb --version
	sdkmanager --version
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/android.ok

$(BUILDDIR)/android-core.ok:
	brew install android-platform-tools android-commandlinetools bundletool openjdk
	echo "TODO: sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"
	echo "TODO: sdkmanager --install platform-tools"
	sdkmanager --update
	sdkmanager --install "ndk;$(NDK_VERSION)" --channel=0
	sdkmanager "platform-tools" "emulator"
	mkdir -p $(dir $@)
	touch $@
$(BUILDDIR)/android.ok: $(BUILDDIR)/android-core.ok

$(ANDROID_VERSIONS:%=$(BUILDDIR)/android-%.ok): $(BUILDDIR)/android-%.ok: $(BUILDDIR)/android-core.ok
	sdkmanager "platforms;android-$*" "build-tools;$*.0.0" "system-images;android-$*;google_apis;$(LOCAL_ARCH)"
	mkdir -p $(dir $@)
	touch $@
$(BUILDDIR)/android.ok: $(ANDROID_VERSIONS:%=$(BUILDDIR)/android-%.ok)

.PHONY: jhw-vanilla
jhw-vanilla: $(BUILDDIR)/jhw-vanilla.ok
	avdmanager list avd
$(BUILDDIR)/jhw-vanilla.ok: $(BUILDDIR)/android-$(CURRENT_VERSION).ok
	avdmanager create avd --force --name "jhw-vanilla" -d "pixel_7" -k "system-images;android-$(CURRENT_VERSION);google_apis;$(LOCAL_ARCH)"
	mkdir -p $(dir $@)
	touch $@
$(BUILDDIR)/android.ok: $(BUILDDIR)/jhw-vanilla.ok
