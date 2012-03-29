---
title: Blog Tweaks
kind: article
created_at: 2012-03-28
location: New York, NY
h1: Minor Improvements
categories:
- blog
- icons
- nanoc
- sprites
- css
- typography
- smartypants
---

## What's new?

I had a little vacation, and I took the opportunity to improve the site
a bit. Although I made a bunch of minor adjustments, there are three real
changes: typography, icons and categories.

### Typography

I've been using [Redcarpet][rc] for [Markdown][m] and [SmartyPants][sp]
parsing for some time now. Overall I love it and I'm still using it for
Markdown, but the SmartyPants handling [has][bug1] [some][bug2]
[bugs][bug3]. On the advice of [Justin Hileman][jh] and [Denis
Defreyne][dd], I'm trying out [Typogruby][t] instead. It does SmartyPants
transformations and more. So far, I like it a lot.

[rc]: https://github.com/tanoku/redcarpet
[m]: http://daringfireball.net/projects/markdown
[sp]: http://daringfireball.net/projects/smartypants
[bug1]: https://github.com/tanoku/redcarpet/issues/53
[bug2]: https://github.com/tanoku/redcarpet/issues/57
[bug3]: https://github.com/tanoku/redcarpet/issues/66
[jh]: https://twitter.com/bobthecow
[dd]: https://twitter.com/ddfreyne
[t]: http://avdgaag.github.com/typogruby/

### Icons

I worked through Code School's [CSS Cross-Country][csscc] last week, and
the course does a great job presenting [sprites][sprites]. So it seemed
like a good opportunity to practice something and add a little shiny to the
site at the same time. I found and bought a beautiful set of [social web
icons][mwsi] made by [@Simek][simek]. He includes a set of overlay effects
that make it easy to create simple hover effects. So after a little time
tweaking the icons and writing some CSS (with the help of [Sprite
Cow][sc]), we now have icons on every page with links to my Github
profile, my Twitter profile and the RSS feed of this site. 

[csscc]: http://css-tricks.com/css-sprites/
[sprites]: http://css-tricks.com/css-sprites/
[mwsi]: http://graphicriver.net/item/modern-web-social-icons/510541
[simek]: https://twitter.com/simek
[sc]: http://www.spritecow.com/

### Categories

To make browsing by subject possible, I've added categories. Each post
begins with them, and there's a [page that lists them all][cats]. That way,
if you want to see everything I've ever written on [ruby][ruby], it's easy.

I'm going to do a longer write-up about how I got these to work with
[nanoc][nanoc], but for the moment, it's enough that they work.

[cats]: ../../../categories.html
[ruby]: ../../../categories/ruby.html
[nanoc]: http://nanoc.stoneship.org
