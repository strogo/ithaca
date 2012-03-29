---
title: Two New Vim Plugins
kind: article
created_at: 2011-11-22
location: New York, NY
h1: "Vim: A Work in Progress"
categories:
- vim
- unbundle
- pathogen
- matchtag
- html
- stackoverflow
---

Like many Unix people, I'm perpetually tweaking, changing, updating and
amending my dotfiles. (If you don't know what dotfiles are, that's cool.
But you should probably stop reading now. This will only bore you.)

Today's little post is about two new plugins that I'm using in Vim. One is
organizational (a kind of meta-plugin, if you like). The other is a small,
but very helpful syntax highlighter for HTML files.

## Unbundle

[Unbundle][ub-gh] is a light replacement for Tim Pope's [Pathogen][p]. I've
talked about Pathogen itself [in another post][post], but here's the tl;dr
version. Pathogen manages all of your other Vim plugins. It makes sure that
Vim loads plugins (and their documentation), and it allows for a much,
much more organized `~/.vim` directory. (It also works very nicely with
version control, since you can maintain each of the separate plugins in its
own version-controlled folder.)

[ub-gh]: https://github.com/sunaku/vim-unbundle/#readme
[p]: https://github.com/tpope/vim-pathogen
[post]: http://ithaca.arpinum.org/2010/06/28/vim-updates.html

Unbundle, which [Suraj N. Kurapati wrote][snj], does the same basic thing
as Pathogen. However, it's meant to be lighter, and it has one nice
improvement. Using Pathogen, you place all of your plugins under
`~/.vim/bundle` and they are *all* loaded when you start Vim. Unbundle
allows you to place bundles either under `~/.vim/bundle` (in which case
they are always available) or under `~/.vim/ftbundle/<something>`. If you
go the second route, then bundles are only loaded per filetype. So, for
example, if you have a great number of complex plugins for Ruby, those will
not be loaded when you are working on Perl (or Bash or Haskell or
whatever). In all honesty, I haven't ever noticed sluggishness when first
starting Vim with Pathogen, but I like the cleanliness of this approach.
More modular is often more better.

Having said that, Pathogen is more mature than Unbundle, and I can imagine
some edge cases where using `~/.vim/ftbundle/` gets complicated (see below
for a specific example). However, so far I'm finding Unbundle to be a solid
alternative to Pathogen. Thanks to [Luca Pette for a post][lp] which led me
to discover Unbundle.

[snj]: http://snk.tuxfamily.org/log/vim-script-management-system.html
[lp]: http://lucapette.com/vim/rails/vim-for-rails-developers-lazy-modern-configuration/

## MatchTag

Meanwhile, over on [Stackoverflow][so], someone wondered "Can Vim highlight
matching pairs of HTML tags in the way that Notepadd++ does?" Now I have to
admit that I've never used Notepad++, but the [screenshot][shot] made me
curious to try this in Vim. The idea is that when the cursor is on an HTML
tag, that tag and whatever tag matches it are both highlighted. This isn't
*essential*, but it's a nice way to be visually grounded as you're editing
HTML. Stackoverlow and Vim's ecosystem being what they are, the question
was answered in a few days. Even more: [Greg Sexton][gs] answered by
writing MatchTag, a [new Vim plugin][mt] to provide this feature for Vim.
I've only been using it for a few hours so far, but in a nutshell: I love
it.

[gs]: http://www.gregsexton.org/
[mt]: http://www.vim.org/scripts/script.php?script_id=3818

![MatchTag in action](../../../images/matchtag.jpg)

When I installed MatchTag, I ran into a small issue with Unbundle (or with
*my* use of Unbundle). Initally I placed MatchTag at `~/.vim/ftplugin/html`
since - duh - the plugin is for HTML. However, what about html.erb files
(which are classified as eruby files by Vim)? At the moment, my hackish fix
was to put MatchTag *also* at `~/.vim/ftplugin/eruby`. This solves the
immediate problem, and disc space is cheap. However, it feels kludgy, and
I would need to repeat it for other filetypes. Working through this has
also made me realize that I have no idea how Vim handles files with
multiple syntaxes in them. I'll probably try to learn more about that and
rethink how I'm handling this over the next few days, but if you have any
suggestions, please let me know via [Twitter][tel]. You can also discuss
this post on [Hacker News][hn] or [Reddit][r].

**Edit**: (20111125) The colorscheme in the screenshot is Anthony
Carapetis&rsquo; [github.vim][cs]. A number of people asked, so I thought
I should add it here.

[so]: http://stackoverflow.com/questions/8168320/can-vim-highlight-matching-html-tags-like-notepad
[shot]: http://i.stack.imgur.com/swLB4.png
[tel]: https://twitter.com/#!/telemachus
[hn]: http://news.ycombinator.com/item?id=3266233
[r]: http://www.reddit.com/r/vimplugins/comments/mlnir/two_new_vim_plugins/
[cs]: http://www.vim.org/scripts/script.php?script_id=2855
