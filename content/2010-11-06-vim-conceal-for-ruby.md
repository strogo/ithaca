---
layout: post
title: Ruby Loves Vim Conceal Too
kind: article
created_at: 2010-11-06
location: New York, NY
h1: This is completely silly, but oh so much fun...
categories:
- vim
- ruby
- conceal
---

## This is why Twitter is useful

Vim 7.3 has some serious new features, one of which at least (`:h persistent-undo`) is a really, really big deal. But I'm not going to talk about those right this moment. Instead, I'm going to talk about something I just came across in a [tweet](http://twitter.com/#!/c9s/status/852461900267520) and [blog post](http://c9s.blogspot.com/2010/11/vim73-conceal-feature-with-perl.html) by Perl hacker Yo-Ann Lin (aka [c9s](https://github.com/c9s), aka [cornelius](http://search.cpan.org/~cornelius/)).

The new feature is `conceal`, and it allows you to visually alter your code so that in place of a keyword `lambda` (or immediately before a lambda-like structure), you see `λ`. This is completely unnecessary (it doesn't really do anything to your code), but it became absolutely essential *to me*. Having seen it for [Perl](https://github.com/c9s/perl-conceal.vim) and [Python](https://github.com/ehamberg/vim-cute-python), I wondered how hard it would be to provide this for Ruby. It turns out not to be very hard at all.

## The code

You simply need to create a [small syntax file](https://gist.github.com/665624) for your language of choice, and define a `cchar` for specific items you want to *conceal*. (In a minute, I'll say more about what conceal really means here.) As an example, here's all it takes to conceal Ruby's `not` with `¬` and lambda with `λ`


        if !has('conceal')
            finish
        endif

        syntax keyword rubyControl not conceal cchar=¬
        syntax keyword rubyKeyword lambda conceal cchar=λ

        set conceallevel=2

The initial bit simply tells Vim to move along if the `conceal` feature isn't available. After that, we specify what we want to conceal, and with what character. The final line sets the conceal level to hide the specified item completely and replace it with the chosen alternative. (There are four choices for `conceallevel`. See `:h conceallevel` for further details.)

## The effect

Pictures speak louder than words here:

![Conceal in action](../../../images/conceal1.jpg "Note where the cursor is...")

![Conceal in action, part 2](../../../images/conceal2.jpg "Note where the cursor is now...")

Take a close look at the two images. If your cursor is off the line where the conceal would occur, you see the conceal character only. However, if you move back up to the relevant line, the actual code reappears (so that you can edit it). What's important to clarify is that *your code is never changed*. The effect is purely visual.

## Serious uses?

For the moment, I haven't gone any further with this, but I can imagine some cases where this feature could be genuinely useful:

+   HTML - no more `&#45;` or `&amp;` - replace the entity with the visual character you expect.
+   Markdown - See HTML, but imagine replacing `+` with a list's bullet.

On the other hand, you might argue that this would be a terrible idea for HTML. After all, you need to know that you typed `&lt;` and *not* `<` in order to avoid breakage. So I'm not entirely sure yet how much I will use this feature in these ways. That said, I will certainly be seeing a lot of `λ` instead of `lambda` in Ruby. That one shouldn't get me into any trouble.

## Links

For more on this feature and how people are using it, see the following:

+   [Haskell Conceal](http://www.vim.org/scripts/script.php?script_id=3200)
+   [Using the conceal Vim feature with LaTeX](http://b4winckler.wordpress.com/2010/08/07/using-the-conceal-vim-feature-with-latex/)
+   [Unicode goodness for Python code](https://github.com/ehamberg/vim-cute-python)
+   [Vim7.3 Conceal Feature with Perl](http://c9s.blogspot.com/2010/11/vim73-conceal-feature-with-perl.html)

The LaTeX example in particular might point towards more serious uses for `conceal`.
