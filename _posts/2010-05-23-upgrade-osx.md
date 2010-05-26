---
layout: post
title: Notes on Snow Leopard upgrade
location: New York, NY
h1: There's nothing new under the sun
---

## The short version

This is a write-up for myself on a recent upgrade (of two machines - MBP and an iMac desktop) to Snow Leopard. For the most part, things went well. Since I forget details easily, it should be useful for me to have these notes here.

## Procedure

Nothing too fancy, but let's make sure I remember the basic steps.

First, wipe the drive. Apple tells you that you can upgrade the OS in-place, without wiping your hard drive. This is true insofar as it's *possible*, but when I last tried this method, the result was a very sluggish install. (This was when upgrading Tiger to Leopard. After a clean wipe, the install was zippity-quick.) If you go with a full reinstall, you must back up data, music, etc., but you do that already, right? (Don't kid yourself: no backup = eventual fail.) Also, you need to reinstall 3rd party applications. I won't lie - a full wipe makes everything take longer. I still think it's worth it. (You can wipe the hard drive with the installer's disk utility tools. Don't simply "erase" the disk. Write some ones and zeros to that sucker.)

Next, install the OS. Take the time to do a "custom install". You don't get many options, but you can choose to leave out a bunch of cruft - printer drivers, fonts and documentation - that you will never need.

Then get more Unix goodness. To do this, you first need to install Xcode from Apple. There's no other way to get a compiler onto OSX that I know of. There should be: something for me to think about. Anyhow, the version on the installation disc will need an update, so you may as well just download it directly from Apple. (The downside is that you must be an Apple developer to do so. You can register for free. Also, the newest version of Xcode seems to _only_ be available in a bundle with the iPhone OS tools and SDK. In the end, I installed from the disc and then upgraded.)

Here we come to a fork in the road: we need a package manager to handle the complexities of installing all our Unix goodies, and there are lots to choose from. [Fink][fink], [MacPorts][macports], [Rudix][rudix] or [Homebrew][homebrew]? I've used Fink, MacPorts and Rudix before, and there are good things to say about all of them. However, I decided to go with the new kid on the block. So far I like Homebrew very much. It's fast, and the installs stay much slimmer than Fink or MacPorts. The process for submitting patches or new packages is also easy to follow and fast. (Over the first weekend I was using Homebrew, I had two patches accepted and a new package as well. All in about 30 hours.)

Finally, reinstall my data and 3rd party apps. This one is pretty self-explanatory, but some notes about which apps I really, really want.

+ [Chrome][chrome] for browsing
+ [Bean][bean] for word processing
+ [MacVim][macvim] for editing
+ [AppZapper][appzapper] for cleanup
+ [Theremin][theremin] (backed by [MPD][mpd] via Homebrew) for music
+ [Gruml][gruml] for RSS feeds
+ [Itsy][itsy] and/or [Echofon][echofon] for Twitter (if Itsy supported lists, it would be Itsy period)
+ [Growl][growl] for notifications

## Tweaks

Even less fancy, but again, it may be useful sometime to have these collected somewhere.

There's no preference to change the hideous default login background. Luckily, this works just fine:

<pre class="textmate-source"><span class="source source_shell">defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture /path/to/picture.png</span></pre>

To manage multiple Ruby and Perl installations (and stay sane), use [rvm][rvm] and [App-perlbrew][perlbrew]. They both work on the same principle: they automate the installation of multiple language interpreters in your `$HOME` directory, and they make it easy to switch between interpreters. (`rvm` hides things away in `$HOME/.rvm`, and App-perlbrew puts things in `$HOME/perl5`. I prefer the tidiness of using a hidden directory, but it's not a dealbreaker. __Edit__: I didn't read the documentation carefully enough. You can change the default installation location easily. Simply set a different `PERLBREW_ROOT` prior to installation with export: `export PERLBREW_ROOT=/path/to/wherever/perlbrew`.) I'm going to write up a whole post just on these two later, but if you haven't checked them out, you should.

If you have a Homebrew-installed Python and you install [Getmail][getmail], the binaries end up lost in `/usr/local/Cellar/python/2.x.x/bin` - far away from your likely `$PATH`. This breaks Mutt - or to be more precise, it means that Mutt can't receive mail. My solution: symlink the four Getmail binaries to `/usr/local/bin`. (There is probably a better fix for this, but I don't care enough about Python installations to bother searching for it.)

<pre class="textmate-source"><span class="source source_shell">ln -s /usr/local/Cellar/python/2.6.5/bin/getmail /usr/local/bin/getmail
ln -s /usr/local/Cellar/python/2.6.5/bin/getmail_fetch /usr/local/bin/getmail_fetch
ln -s /usr/local/Cellar/python/2.6.5/bin/getmail_maildir /usr/local/bin/getmail_maildir
ln -s /usr/local/Cellar/python/2.6.5/bin/getmail_mbox /usr/local/bin/getmail_mbox</span></pre>

Homebrew will install MPD, MPC and Flac just fine, but you will also need to create a `$HOME/.mpdconf`. Most of the file is standard, but the audio output is odd. (Thanks to Evan Hanson for this tip in his post about [MPD on OSX](http://evanhanson.com/2010/03/22/mpd-on-os-x/). I also hide my music files away in a hidden directory `$HOME/.musica`. Both MPD and MPC can find them there just fine, and I don't fiddle with them by hand. For whatever it's worth, here's my basic configuration file:

<pre class="textmate-source"><span class="source source_shell">music_directory     <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.musica<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
playlist_directory  <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.mpd/playlists<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
db_file             <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.mpd/mpd.db<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
log_file            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.mpd/mpd.log<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
pid_file            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.mpd/mpd.pid<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
state_file          <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>~/.mpd/mpd.state<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>


user                <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>username<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
bind_to_address     <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>any<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
port                <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>6600<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
log_level           <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>default<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
metadata_to_use     <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>artist,album,title,track,name,genre,date,composer,performer,disc<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>

input <span class="meta meta_scope meta_scope_group meta_scope_group_shell"><span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">{</span>
   plugin           <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>curl<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
<span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">}</span></span>


audio_output <span class="meta meta_scope meta_scope_group meta_scope_group_shell"><span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">{</span>
    <span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">type</span>            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>httpd<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
    name            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>My HTTP Stream<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
    port            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>8000<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
    bitrate         <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>128<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>           <span class="comment comment_line comment_line_number-sign comment_line_number-sign_shell"><span class="punctuation punctuation_definition punctuation_definition_comment punctuation_definition_comment_shell">#</span> do not define if quality is defined
</span>    format          <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>44100:16:1<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
<span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">}</span></span>
audio_output <span class="meta meta_scope meta_scope_group meta_scope_group_shell"><span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">{</span>
    <span class="punctuation punctuation_definition puctuation_definition_group punctuation_definition_group_shell">type</span>            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>osx<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
    name            <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>OSX<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span>
<span class="punctuation punctuation_definition punctuation_definition_group punctuation_definition_group_shell">}</span></span>

mixer_type          <span class="string string_quoted string_quoted_double string_quoted_double_shell"><span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_begin punctuation_definition_string_begin_shell">"</span>software<span class="punctuation punctuation_definition punctuation_definition_string punctuation_definition_string_end punctuation_definition_string_end_shell">"</span></span></span></pre>

The HTTPD output is not necessary if you don't want to stream music over HTTP. I haven't bothered to set up a Launchd item so that MPD launches automatically on boot. I should, but I need to read up first on Launchd. For the moment, I just launch it manually when I want music. (There's a discussion on the MPD wiki [about setting up Launchd][launchd], but it's a bit brief. I want to read more about the whole process first.) 

__Edit__: I forgot about fonts. For monospace fonts, I really like Microsoft's [Consolas][consolas] and Ralph Levien's [Inconsolata][inconsolata]. At the moment, I'm using David Zhou's straight apostrophe version of Inconsolata, [Inconsolata-dz][inconsolata-dz], which is worth looking at if you like Inconsolata itself. In order to get Microsoft's fonts on a Mac without installing Office or whatever, I use a modified version of Aristotle Pagaltzis's [vistafonts-installer][vistafonts] script. (This requires cabextract to work with the fonts, but you can get that from Homebrew. Pagaltzis's script is designed for a Linux environment, but it works well on OSX with only cosmetic changes.)

__Edit 2__: Last one, I promise, but I forgot one other annoyance. Out of the box on a Mac, you will discover a number of folders in your `$HOME` directory which you cannot remove. If you try to delete 'Music' or 'Sites' or the like, you get told you can't do that. The message, as I recall, seems designed to make you think removing those folders will break your system - which is bullshit. In a nutshell, Apple uses ACLs to lock these directories down. ([ACLs][aclw] provide permissions for complex scenarios where POSIX permissions give out.) You can remove the ACLs, however, with `chmod -N`. Once you remove this extra layer of permissions, you can do as you like with your `$HOME` directory. (The fullest discussion I could find from Apple on ACLs is in their documentation for [file server administration][acls]. **Warning**: link goes directly to a pdf.)

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
[echofon]: http://www.echofon.com/
[growl]: http://growl.info/
[getmail]: http://pyropus.ca/software/getmail/
[launchd]: http://mpd.wikia.com/wiki/MPD_on_OSX#LaunchD
[consolas]: http://www.microsoft.com/typography/ClearTypeFonts.mspx
[inconsolata]: http://www.levien.com/type/myfonts/inconsolata.html
[inconsolata-dz]: http://nodnod.net/2009/feb/12/adding-straight-single-and-double-quotes-inconsola/
[vistafonts]: http://plasmasturm.org/code/vistafonts-installer/vistafonts-installer
[aclw]: http://en.wikipedia.org/wiki/Access_control_list
[acls]: http://manuals.info.apple.com/en_US/FileServerAdmin_v10.6.pdf
