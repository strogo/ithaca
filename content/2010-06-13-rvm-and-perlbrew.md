---
layout: post
title: Rvm and Perlbrew
kind: article
created_at: 2010-06-13
location: New York, NY
h1: Meet two tools you should be using, if you aren't already.
categories:
- rvm
- ruby
- perlbrew
- perl
---

## What were those names again?

Meet my two new best friends: [RVM][rvm] and [Perlbrew][perlbrew]. They both do similar things, namely install and keep track of multiple Ruby or Perl interpreters and the matching gems or modules. These tools allow you to install and use multiple versions of Perl or Ruby without going crazy or doing hideous damage to any of your projects, co-workers or loved ones. They make me happy.

[rvm]: http://rvm.beginrescueend.com/
[perlbrew]: http://search.cpan.org/perldoc?App::perlbrew

## Why do I need them?

Let's go back a step. Ruby and Perl (with the capitals) are languages. By contrast, ruby and perl (with the miniscules) are interpreters. An interpreter is a program that turns source code into something that your machine can execute. (You like what I did there? I completely glossed over all the gory details of intermediate representation, machine code, bytecode and pretty much everything else. See [Wikipedia's article on interpreted languages][il] if you want more detail.) Ruby and Perl are also _evolving_ languages. Ruby is moving towards Ruby 2.0, and new releases of Perl 5.x appear frequently. As the languages evolve, they gain new features, lose (some) old features and shift in various ways - some subtle, some not very subtle at all. Writing code for Ruby 1.8.6 is not quite the same thing as writing code for Ruby 1.9.2. This brings us back to the question in this section: Why do you need RVM and Perlbrew?

You need these tools because you will often want or need to have more than one version of the Ruby or Perl interpreter installed on a machine at a time. Why would you want that? Well, perhaps you have been working for years on a codebase using Perl. When you wrote that project, which is now being maintained rather than actively worked on, Perl 5.8 was the new thing. You know it works well with Perl interpreters of the 5.8.x series. However, Perl has kept improving, and you want to start a new project using 5.12 and its new features. When bug reports come in about the older project, you need to have an older interpreter handy, and you also want to keep all the CPAN modules you installed under the 5.8.x interpreter just where they are (we'll come back to modules in a minute.) Another reason you might want to have more than one interpreter is for learning and experimentation. You keep reading about how wonderful the Enumerators in Ruby 1.9.x are, but you've also read Yehuda Katz's warnings about the stability of Ruby 1.9.1. So you don't want to do _all_ your work in 1.9.1, but you want a 1.9 interpreter around to play with. (Ruby has an additional complication: in addition to the standard MRI or YARV, written in C, for various versions of Ruby, there are also now a number of other implementations of Ruby interpreters written in other languages altogether: JRuby, Iron Ruby, Rubinius, etc.) A third reason, similar to the first, is that you won't always have control over what version of the interpreter you get to work with. I host this site (and some other things) using [Geekisp][geek], where their servers run OpenBSD. At work, I use various Macs running OS X 10.5 or 10.6. Those machines may or may not have the same version of the Perl or Ruby interpreter, and what they have isn't up to me. So if I want to work at home on one or another project, I may need to have access to more than one interpreter.

Assuming you now agree that you need multiple Perls and Rubies, you may still wonder why you need RVM or Perlbrew. Answer: installing and keeping track of multiple versions of Perl or Ruby is no small thing. Don't get me wrong, it's not the end of the world, but it does require thought, care and a lot of repetitive labor. That sounds like _exactly_ the kind of task that you should automate via a program. The program would provide a systematic way to install new interpreters and keep track of where you have installed them, in case you want to remove one or more later. RVM and Perlbrew do just this. Moreover, each interpreter carries along with it a whole little ecosystem for documentation and user-installed libraries - Ruby gems or Perl modules from CPAN. You will want some method to switch not just which interpreter your shell is using, but the corresponding `gem` or `perldoc` commands as well. Again, RVM and Perlbrew have you covered here. If you are working in Ruby, for example, it's as easy as `rvm 1.8.7` or `rvm 1.9.2`, and you have switched interpreters. Because RVM is smart, when you switch interpreter, everything else switches automagically: your `irb`, `ri` and `gem` follow along without any further intervention from you. Again, you could do all this yourself by installing different interpreters in carefully named subdirectories in `/usr/local` and adjusting your `$PATH` variable as needed. You would probably end up wanting to automate the installations and `$PATH`-switching. Before you knew it, you would end up reimplementing either RVM or Perlbrew. Most likely, you wouldn't do it as well. I certainly wouldn't. That's why you want one or both of these tools.

[il]: http://en.wikipedia.org/wiki/Interpreted_language
[geek]: http://www.geekisp.com/

## Installing and using RVM

First of all, RVM has [excellent documentation][rvm-doc] on its website. You should read it. That said, here's a short overview of how to install and use RVM.

As a regular user, install this way:

    bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

That command simply uses curl to fetch the latest version of the installation script and then feeds it to your shell to run. For the curious or paranoid, at the time of this writing, the installation script looks like this (note that you can always view the latest script before running it, simply by running the inner `curl` command without feeding its output to `bash`):

    #!/usr/bin/env bash
    if [[ -f /etc/rvmrc ]] ; then source /etc/rvmrc ; fi

    if [[ -f "$HOME/.rvmrc" ]] ; then source "$HOME/.rvmrc" ; fi

    rvm_path="${rvm_path:-$HOME/.rvm}"

    mkdir -p $rvm_path/src/

    builtin cd $rvm_path/src

    rm -rf ./rvm/ 

    git clone --depth 1 git://github.com/wayneeseguin/rvm.git

    builtin cd rvm

    dos2unix scripts/* >/dev/null 2>&1

    bash ./scripts/install

When things are done, you will be prompted to add some lines to your shell's startup files, sourcing RVM. Add the necessary lines, and then either open a new shell or re-source your startup files. You're now ready to use RVM.

Some essential commands, with brief explanation about what each does:

    # get help - these two are equivalent, very helpfully
    rvm --help
    rvm usage

    # install and uninstall Rubies
    # NB: you need to specify a patchlevel only if you want to install
    # a patchlevel that isn't the default for rvm. At the moment, the
    # default patchlevel for 1.8.7 is p174, and I'm living on the edge.
    rvm install 1.8.7-p249
    rvm uninstall 1.8.7-p249
    rvm install 1.9.1

    # switch to a specific version of Ruby
    # again, the patchlevel isn't necessary unless you've installed a
    # non-default version of that interpreter
    rvm 1.8.7-p249
    rvm 1.9.1

    # choose a default Ruby for new shells
    rvm --default 1.9.1

    # switch to the default you've set
    rvm default

    # switch to the system's built-in Ruby interpreter, pre-rvm
    rvm system

    # show what rvm has installed and is currently managing for you
    rvm list

RVM can do even fancier, more complicated things for you, but this is plenty to get you started. Again, read the [excellent documentation][rvm-doc]. If you get very stuck or have trouble, visit #rvm on irc. RVM's creator Wayne E. Seguin is often there, and the room is helpful and friendly, in my experience.

[rvm-doc]: http://rvm.beginrescueend.com/rvm/

## Installing and using Perlbrew

Perlbrew is quite easy to install, but there's one thing worth considering before you do so. By default, Perlbrew will create a folder in your `$HOME` called perl5, and that's where it will install and manage various Perl interpreters. There's nothing especially wrong with this behavior (it's pretty standard, actually), but I prefer hidden directories (like RVM's `.rvm`) for things that I never view or touch except via the command-line. (I take this to the degree that my mail directories for Mutt and my music directories for MPD are hidden away as well.) If you are like me, or you want to change _where_ Perlbrew works in any way, it's easily done. All you need to do is set and export a `PERLBREW_ROOT` variable in your shell before installation (and later in your startup files). Even with that extra step, installing Perlbrew is as easy as this:

    export PERLBREW_ROOT=$HOME/.perl5/perlbrew
    curl -LO http://xrl.us/perlbrew
    chmod +x perlbrew
    ./perlbrew install

As with RVM, after you install Perlbrew, you will need to add some initialization to your shell's startup files. Once you've done that, open a new shell or re-source your startup files. Using Perlbrew then is as easy as this (these examples are taken directly from Perlbrew's own documentation, which you can get via `perlbrew -h`):

    # Install some Perls
    perlbrew install perl-5.12.0
    perlbrew install perl-5.13.0

    # Install from a git checkout
    cd /path/to/src/perl
    perlbrew install .

    # See what were installed
    perlbrew installed

    # Switch perl in the $PATH
    perlbrew switch perl-5.13.0
    perl -v

    # Turn it off. Disable it.
    perlbrew off

    # Turn it back on. Re-enable it.
    perlbrew switch perl-5.13.0

## Wrapping up

I've been using RVM for about a month now and Perlbrew for about two weeks. I already don't know how I managed without them. They take something tedious, error-prone and time-consuming and make it trivial and nearly error proof. Thanks to Wayne E. Seguin (@wayneeseguin on Twitter) and Kang-min Liu (@gugod on Twitter, and online here: [http://gugod.org/](http://gugod.org/)) for these excellent tools.
