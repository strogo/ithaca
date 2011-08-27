---
layout: post
title: Some Vim-related notes
kind: article
created_at: 2010-06-28
location: New York, NY
h1: Vim for fun and profit
---

## Vim rocks, but you knew that, right?

I use Vim as my primary editor in a variety of environments (OS X, Debian and OpenBSD), and it's the bee's knees. Having said that, this post won't offer Vim-boosterism. Instead, I will note down a few things I've either discovered or improved lately.

## Pathogen = plugin-organizing demon ninja

I have no idea what that header means either. However, I do know that Tim Pope's [Pathogen][pathogen] plugin is an outstanding way to manage all your many Vim add-ons. It takes the same approach to package management that [Homebrew][homebrew] or [Stow][stow] does: each item goes into its own folder inside `$HOME/.vim/bundle`, and then Pathogen makes sure that everything inside there gets properly loaded at runtime. It makes updating or uninstalling individual items a breeze. Go get it; I'll wait.

[homebrew]: http://mxcl.github.com/homebrew/
[stow]: http://www.gnu.org/software/stow/

Oh, ok, here's a brief run through of how to get it and set it up:

+  If you already have lots of things in `$HOME/.vim`, then the best thing is to move that entire folder out of the way and start fresh. It's a bit of work to repopulate your add-ons (took me about an hour and a half to get things all just so again), but it's worth it.

        cd ~
        mv .vim vim_backup-`date "+%Y-%m-%d"`
        rm -rf .vim
        mkdir -p .vim/{autoload,bundle}
        cd autoload
        curl -o pathogen.vim -L http://www.vim.org/scripts/download_script.php?src_id=12116

    That last command uses the download link for the most up-to-date version of Pathogen today. In the future, I will try to remember to update this post, but if you have a problem, go to the main Pathogen download site (that link should never change) and adjust accordingly.

+  To enable Pathogen, you need to add some lines to your vimrc file. It's important that these lines go at the very top of that file, before the built-in filetype plugin is loaded.

        filetype off
        call pathogen#runtime_append_all_bundles()
        call pathogen#helptags()

    Those lines insure that every time you start Vim, all your plugins, colors, etc. are loaded (as well as their documentation). Make sure to turn on filetype detection somewhere below this (as normal).

+ Now you are ready to start installing add-ons. All additional Vim goodies, must go into distinct sub-directories of a the `$HOME/.vim/bundle` folder. So, if you download a zipfile from Vim's home site, you can simply unzip it this way:

        unzip zowie_cool_plugin.zip -d ~/.vim/bundle/zowie_cool_plugin

    But there's an easier, better way to handle this: use git and Github.

        cd .vim/bundle
        git clone http://github.com/msanders/snipmate.vim
        git clone http://github.com/Townk/vim-autoclose
        etc.

    No unzipping needed, and in the future, you can upgrade those plugins by `cd`-ing into their directories and issuing `git pull` to get the latest changes from Github. To facilitate all this, many Vim add-ons now list Github repositories on their Vim.org pages.

+  To make it even better, you can automate the git{,hub} bit with a script [like this one][gist]. (I adapted that from a script by Tammer Saleh. You can find the original on [his post about Pathogen][tsaleh].)

Cool, huh?

[pathogen]: http://www.vim.org/scripts/script.php?script_id=2332
[gist]: http://gist.github.com/455162
[tsaleh]: http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen

## What's in your status line?

I had never really messed with my Vim status line. The status line, if you don't already know, is the bar right down at the bottom of your editor with information about what you're currently doing. If you've enabled it but not tweaked its settings, it probably has the name of the file your working on and some information about the line and column number of the cursor. Useful, but not exciting.

Then a few days ago @bryanl asked people [on Twitter][tweet] about their Vim status lines. I looked at a few, thought about it and got to work. A couple of days later, and I'm finally done. (Along the way, I learned a bit of Vimscript and went back and forth a bunch with @fuzzymonk about how to get [rvm.vim][rvm.vim] to show your current Ruby interpreter in the status line just right. Lots of fun.)

Here's the final result of my labors:

    " status line hijinks
    set statusline=%<%f\ %h%m%r%y
    \%{exists('g:loaded_fugitive')?fugitive#statusline():''}
    \%{exists('g:loaded_rvm')?rvm#statusline_ft_ruby():''}
    \%{&filetype=='perl'?'['.system($perlv).']':''}
    \%=%-14.(%l,%c%V%)\ %P

If you're visually inclined, try this: 

![My groovy status line](../../../images/vim-status.jpg "This is _so_ meta, man...")

[tweet]: http://twitter.com/bryanl/status/17013225815
[rvm.vim]: http://github.com/csexton/rvm.vim

## Can't forget Perlbrew & Perl

I was able to get the current Ruby interpreter into the status line by installing Christoper Sexton's [rvm.vim][rvm.vim], as I said, but what about the current Perl interpreter? This turned out to be surprisingly tricky, and it highlights a difference between [rvm][rvm] and [perlbrew][perlbrew] that I didn't mention [in my last post][post]. Whereas rvm exports a _lot_ of variables into your environment, perlbrew does not. That means that it's harder to get the information from perlbrew to Vim. (This isn't a criticism of perlbrew or rvm. They just handle things differently. Perlbrew is a pure Perl solution, and by definition a Perl script cannot export environmental variables back into its parent process. This is a good thing for security reasons. On the other hand, rvm makes use of Bash scripting, and this obviously can alter your environment. Neither way is better or worse. In different situations, they each have strengths or challenges.)

**Edit 2010-06-23:** Please ignore the crossed out bits below. I've worked out a slightly better solution and hope to post about it soon.

**Edit 2010-08-06:** Ok, I finally have the better solution worked out so
that it's presentable. See [today's post for more][t]

<del>

Here's what I ended up doing. To manage your current Perl installation, Perlbrew switches a mess of symlinks in `$PERLBREW_ROOT/perlbrew/bin`. At any given moment, however, `perl` is guaranteed to point at your current Perl interpreter. And obviously Perl itself knows its version (it's in the built-in variable `$^V` for 5.6 and higher). So, I created this environment variable:

    export perlv='perl -e "print $^V"'

Notice that's not an alias. It's a variable. Variables in your current environment are available to Vimscript by using the `$` prefix (just as in Bash itself you prefix variables with `$` when you want to use them). That's how rvm.vim gets your current Ruby interpreter: it's in `$rvm_ruby_version` (or other variables). Since perlbrew doesn't export such a variable, I created one, called 'perlv'. The magic comes when you consider what's in that variable and how Vim grabs it.

The variable `$perlv` holds a string, and we grab it with Vimscript's built-in `system('command')` syntax. That syntax is normally for running external comamnds. By feeding `$perlv` to `system()` in this way, it's as if we're `eval`-ing the command that lies hiding in the string. It's a gross and utter hack, but it works. (It also switches when your Perl interpreter switches. Imagine you're already working in Vim and you issue `perlbrew switch perl-x.x.x`. Most of my initial solutions would never update the interpreter version. They were stuck with whatever version you had _when you started Vim_. However, the `perlv` solution updates: as soon as the status line refreshes, you will see the change.)

Finally, if you want the Perl interpreter in a Bash prompt or Bash script, simply `eval` it:

    echo $(eval $perlv)

Again, not elegant, but it's the best I could come up with right now.

</del>



[rvm]: http://rvm.beginrescueend.com/
[perlbrew]: http://search.cpan.org/perldoc?App::perlbrew
[post]: http://ithaca.arpinum.org/2010/06/13/rvm-and-perlbrew.html
[t]: http://ithaca.arpinum.org/2010/08/06/fun-with-perlbrew.html
