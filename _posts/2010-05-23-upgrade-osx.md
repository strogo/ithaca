---
layout: post
title: Notes on Snow Leopard upgrade
location: New York, NY
h1: There's nothing new under the sun
---

## The short version

This is a write-up for myself on a recent upgrade (of two machines - MBP and an iMac desktop) to Snow Leopard. For the most part, things went well. Since I forget details easily, it should be useful for me to have these notes here.

## Procedure

+   Wipe drive. Apple tells you that you can upgrade the OS in-place, without wiping your hard drive. This is true insofar as it's *possible*, but when I last tried this method, the result was a very sluggish install. (This was when upgrading Tiger to Leopard. After a clean wipe, the install was zippity-quick.) If you go with a full reinstall, you must back up data, music, etc., but you do that already, right? (Don't kid yourself: no backup = eventual fail.) Also, you need to reinstall 3rd party applications. I won't lie - a full wipe makes everything take longer. I still think it's worth it. (You can wipe the hard drive with the installer's disk utility tools. Don't simply "erase" the disk. Write some ones and zeros to that sucker.)

+   Install the OS. Take the time to do a "custom install". You don't get many options, but you can choose to leave out a bunch of cruft - printer drivers, fonts and documentation - that you will never need.

+   Install more UNIX goodness. To do this, you first need to install Xcode from Apple. There's no other way to get a compiler onto OSX that I know of. There should be: something for me to think about. Anyhow, the version on the installation disc will need an update, so you may as well just download it directly from Apple. (The downside is that you must be an Apple developer to do so. You can register for free. Also, the newest version of Xcode seems to _only_ be available in a bundle with the iPhone OS tools and SDK. In the end, I installed from the disc and then upgraded.)

    Here we come to a fork in the road: [Fink][fink], [MacPorts][macports], [Rudix][rudix] or [Homebrew][homebrew]? I've used Fink, MacPorts and Rudix before, and there are good things to say about all of them. However, I decided to go with the new kid on the block. So far I like Homebrew very much. It's fast, and the installs stay much slimmer than Fink or MacPorts. The process for submitting patches or new packages is also easy to follow and fast. (Over the first weekend I was using Homebrew, I had two patches accepted and a new package as well. All in about 30 hours.)

+   Reinstall my data and 3rd party apps. This one is pretty self-explanatory, but some notes about which apps I really, really want.
    
    +   [Chrome][chrome] for browsing
    +   [Bean][bean] for word processing
    +   [MacVim][macvim] for editing
    +   [AppZapper][appzapper] for cleanup
    +   [Theremin] (backed by [mpd][mpd] via Homebrew) for music
    +   [Gruml][gruml] for RSS feeds
    +   [Itsy][itsy] and/or Echofon for Twitter (if Itsy supported lists, it would be Itsy period)
    +   [Growl][growl] for notifications

## Tweaks

+   There's no simple way to change the hideous default login background. Luckily, this works just fine:

        <pre class="textmate-source"><span class="source source_shell">defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture /path/to/picture/here</span></pre>

+   To enable extra Bash completions for Homebrew:

        <pre class="textmate-source"><span class="source source_shell">ln -s <span class="string string_interpolated string_interpolated_backtick string_interpolated_backtick_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">`</span>brew --prefix<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">`</span></span>/Library/Contributions/brew_bash_completion.sh <span class="string string_interpolated string_interpolated_backtick string_interpolated_backtick_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">`</span>brew --prefix<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">`</span></span>/etc/bash_completion.d/</span></pre>

+   Use [rvm][rvm] and [App-perlbrew][perlbrew] to manage my Ruby and Perl interpreters, respectively. They both work on the same principle: they automate the installation of multiple language interpreters in your $HOME directory, and they make it easy to switch between interpreters. (rvm hides things away in .rvm, and App-perlbrew puts things in $HOME/perl5. I prefer the tidiness of using a hidden directory, but it's not a dealbreaker. __Edit__: I didn't read the documentation carefully enough. You can change the default installation location easily. Simply set a different `PERLBREW_ROOT` prior to installation with export: `export PERLBREW_ROOT=/path/to/wherever/perlbrew`.)

    In the case of rvm, one problem is documentation. By default, rvm does not build docs for the Ruby interpreters that it installs. In addition, because the rdoc tool differs with each version of Ruby, I was unable to get _one_ command to do do what I wanted consistently. The trick is that you want the documentation to end up in the proper subfolder of $HOME/.rvm rather than in $HOME/.rdoc or the like.

[fink]: http://www.finkproject.org/
[macports]: http://www.macports.org/
[rudix]: http://rudix.org/
[homebrew]: http://wiki.github.com/mxcl/homebrew/
[rvm]: http://rvm.beginrescueend.com/
[perlbrew]: http://gugod.org/2010/03/perlbrew-home-perl-installation-made-easy.html
[chrome]: http://www.google.com/chrome?platform=mac
[bean]: http://www.bean-osx.com/Bean.html
[macvim]: http://code.google.com/p/macvim/
[appzapper]: http://appzapper.com/
[theremin]: http://theremin.sigterm.eu/
[mpd]: http://mpd.wikia.com/wiki/Music_Player_Daemon_Wiki
[gruml]: http://www.grumlapp.com/
[itsy]: http://mowglii.com/itsy/
[growl]: http://growl.info/
