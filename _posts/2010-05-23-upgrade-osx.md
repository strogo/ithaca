---
layout: post
title: Notes on Snow Leopard upgrade
location: New York, NY
h1: There's nothing new under the sun
---

## Diving in

This is a write-up for myself on a recent upgrade (of two machines - MBP and an iMac desktop) to Snow Leopard. For the most part, things went well. Since I forget details easily, it should be useful for me to have these notes here.

## Procedure

+ Wipe drive. Apple tells you that you can upgrade the OS in-place, without wiping your hard drive. This is true insofar as it's *possible*, but the one time I tried this, the result was a very sluggish install. (This was when upgrading Tiger to Leopard. After a clean wipe, the install was zippity-quick.) If you go this route, you must back up data, music, etc., but you do that already, right? (Don't kid yourself: no backup = eventual fail.) Also, you need to reinstall 3rd party applications. I won't lie - a full reinstall makes everything take longer. I still think it's worth it. (You can wipe the hard drive with the installer's disk utility tools. Don't simply "erase" the disk. Write some ones and zeros to that sucker.)
+ Install the OS. Take the time to do a "custom install". You don't get many options, but you can choose to leave out a bunch of cruft - printer drivers, fonts and documentation - that you will never need.
+ Install essentials: [MacVim][mvim], [Git][git], my dotfiles.
+ Install more UNIX goodness. Here we come to a fork in the road: [Fink][fink], [MacPorts][macports], [Rudix][rudix] or [Homebrew][homebrew]. I've used Fink, MacPorts and Rudix before, and there are good things to say about all of them. However, I decided to go with the new kid on the block. 
