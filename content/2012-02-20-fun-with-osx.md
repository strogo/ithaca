---
title: Just Works?
kind: article
created_at: 2012-02-20
location: New York, NY
h1: There's good news, and there's bad news.
categories:
- osx
- yak-shaving
- gcc
- xcode
---

## The good news

Apple now provides a simple, small package if you want a compiler and its
basic requirements, but you don't want Xcode. You can get the package
[here](https://developer.apple.com/downloads). The download is free, though
you will need an Apple developer account. (That's free too.)

If you regularly work on OSX, and you don't care for Xcode, you know this
is a big, big deal. The Xcode download is over 3GB. The new
command-line-tools-only download is only 164MB. There's also a principle or
two involved. I want to compile software. I don't want Xcode or the iOS SDK
or anything else. I just want a compiler and its toolchain. The person we
owe this to, primarily, is Kenneth Reitz. He's written more about how it
all happened and what it means for Homebrew users [on his
blog](http://kennethreitz.com/xcode-gcc-and-homebrew.html).

## How to get in on the fun

**Warning**: Don't do any of this until after you've read the bad news
below. You've been warned.

+ Uninstall Xcode:

        sudo /Developer/Library/uninstall-devtools --mode=all

+ Download the [Command Line Tools for
  Xcode](https://developer.apple.com/downloads). Install them.
+ Done (but see below).

## The bad news

Apple no longer provides `autoconf` or its (relatively) vanilla `gcc-4.2`.
This will cause you some problems if you want to install things that still
won't build with `clang` or Apple's `llvm`-powered `gcc`. (For example, Ruby
1.8.7.) It will also cause you problems if you want to install something
via Homebrew that has a hard-coded dependency on `/usr/bin/autoconf`. (Up
until recently, `gnupg` was doing this, though that formula was just
updated. A quick grep says `aplus`, `fuse4x` and `sshfs` are still
offenders.)


## How to deal with the bad

+ Install `gcc-4.2` following these instructions (which I owe to [Caius
  Durling](http://caiustheory.com/install-gcc-421-apple-build-56663-with-xcode-42)):

        curl -O http://opensource.apple.com/tarballs/gcc/gcc-5666.3.tar.gz
        tar zxf gcc-5666.3.tar.gz
        cd gcc-5666.3
        mkdir -p build/{obj,dst,sym}
        gnumake install RC_OS=macos RC_ARCHS='i386 x86_64' TARGETS='i386 x86_64' \
        SRCROOT=`pwd` OBJROOT=`pwd`/build/obj DSTROOT=`pwd`/build/dst SYMROOT=`pwd`/build/sym
        sudo ditto build/dst /

+ Install `autoconf` via [homebrew-alt](https://github.com/adamv/homebrew-alt):

        brew install https://raw.github.com/adamv/homebrew-alt/master/duplicates/autoconf.rb
        brew link autoconf

    This is [John Firebaugh's
    idea](http://jfire.posterous.com/xcode-43-homebrew-and-autoconf). I had
    forgotten that Homebrew even had a version of `autoconf`, so
    I installed it in `$HOME/local/autoconf`. His solution is simpler if
    you're already using Homebrew.

+ Fix any formula that demands `/usr/bin/autoconf` specifically.

Depending on your machine, the `gcc-4.2` build will take an hour or so. Use
the time to [do something useful](http://xkcd.com/303).
