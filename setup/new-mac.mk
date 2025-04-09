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
	rustup target add armv7-linux-androideabi aarch64-linux-android
	rustup target add i686-linux-android x86_64-linux-android
	rustup target add aarch64-apple-darwin x86_64-apple-darwin 
	rustup target add x86_64-pc-windows-gnu
	cargo install cargo-ndk cargo-machete cargo-outdated
	mkdir -p $(dir $@)
	touch $@

# sdkmanager is installed with android-commandlinetools, but it will not run
# without a Java Runtime.
#
# On my older Mac, I held firm at openjdk@21.  There were reports from the
# React Native community that Java 22 compiles to class file version 66, yet
# gradle cannot work past Java 21.
#
# This is shocking and casts gradle in a bad light, but I am no longer trying to
# use gradle so I am just going with latest Java:
#
.PHONY: android
android: $(BUILDDIR)/android.ok
$(BUILDDIR)/toolchain.ok: $(BUILDDIR)/android.ok
$(BUILDDIR)/android.ok:
	brew install android-platform-tools android-commandlinetools openjdk
	adb --version
	echo "TODO: sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"
	echo "TODO: sdkmanager --install platform-tools"
	sdkmanager --update
	sdkmanager --install "ndk;27.0.12077973" --channel=0
	sdkmanager "build-tools;21.0.0" "build-tools;23.0.0" "build-tools;27.0.0" "build-tools;29.0.0" "build-tools;30.0.0" "build-tools;31.0.0" "build-tools;35.0.0"
	sdkmanager "platforms;android-21" "platforms;android-23" "platforms;android-27" "platforms;android-29" "platforms;android-30" "platforms;android-31" "platforms;android-34" "platforms;android-35"
	sdkmanager "system-images;android-21;google_apis;x86" "system-images;android-21;google_apis;x86_64" "system-images;android-23;google_apis;x86" "system-images;android-23;google_apis;x86_64" "system-images;android-27;google_apis;x86" "system-images;android-29;google_apis;x86" "system-images;android-29;google_apis;x86_64" "system-images;android-30;google_apis;x86" "system-images;android-30;google_apis;x86_64" "system-images;android-31;google_apis;x86_64" "system-images;android-34;google_apis_playstore;arm64-v8a" "system-images;android-35;google_apis;arm64-v8a" "system-images;android-35;google_apis;x86_64"
	sdkmanager "platforms;android-32" "platforms;android-33"
	sdkmanager "platform-tools" "emulator"
	sdkmanager "platforms;android-21" "build-tools;21.0.0" "system-images;android-21;google_apis;x86"
	sdkmanager "platforms;android-23" "build-tools;23.0.0" "system-images;android-23;google_apis;x86"
	sdkmanager "platforms;android-29" "build-tools;29.0.0" "system-images;android-29;google_apis;x86"
	sdkmanager "platforms;android-30" "build-tools;30.0.0" "system-images;android-30;google_apis;x86"
	sdkmanager "platforms;android-31" "build-tools;31.0.0"
	sdkmanager "system-images;android-21;google_apis;x86_64" "system-images;android-23;google_apis;x86_64" "system-images;android-29;google_apis;x86_64" "system-images;android-30;google_apis;x86_64" "system-images;android-31;google_apis;x86_64"
	sdkmanager --list_installed
	avdmanager create avd --force -n "jhw-vanilla" -d "pixel_7" -k "system-images;android-35;google_apis;x86_64"
	avdmanager list avd
	mkdir -p $(dir $@)
	touch $@
