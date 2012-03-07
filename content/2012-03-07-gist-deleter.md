---
title: Announcing gist-deleter v0.0.1
kind: article
created_at: 2012-02-20
location: New York, NY
h1: Scratching An Itch
---

## tl;dr

I've written a bookmarklet that makes it easier to delete multiple gists
from the main gist viewing page. (Normally, you need to visit each gist's
page in order to delete it. This is tedious if you want to delete five or
ten gists.)

Drag the link below to your bookmarks bar. Then to activate it, simply
visit [your main gists page][gists] and click the bookmarklet.

<p><a href='javascript:(function(){function a(c){var d=document.createElement("span");var b=document.createElement("a");var e="/delete"+c;b.href=e;b.innerHTML="delete this gist";b.onclick=function(f){$(b).closest("div.file").fadeOut();$.ajax(e,{type:"delete","data-method":"delete"});f.preventDefault()};$(d).append(b);return d}Array.prototype.slice.call($("div.file div.info a")).forEach(function(b){var c=$(b).attr("href");$(b).closest("div.info").append(a(c))})}());'>Gist deleter</a></p>

[gists]: https://gist.github.com/mine

## A little more explanation

I love Github. Truly. Love, love, love it. I love gists. Truly. Love, love,
love them. In fact, I probably love gists too much --- and that's where the
problem begins. I create a lot of gists: for myself, when I'm on irc, to
email people and so on. But many of these gists are very trivial. I'm not
likely to ever want them again. In and of itself, that's not a huge deal.
However, it makes it harder for me to find the gists I really care about in
the sea of throw-away ones.

So every now and again, I want to clean up my gists. This is where the
trouble starts. When you visit [your primary gist-listing page][gists],
there's no way to delete gists from that main page. You can see about
fifteen or so gists, but to delete any of them, you must click on the
gist's link and then delete it from an individual show page. After
deletion, you're redirected back to the main gist show page. The pattern
is: list gists, pick gist, delete gist, redirect, list gist, pick gist,
delete gist, redirect and so forth. What I want is a simpler workflow: list
gists, delete gist, delete gist, delete gist. Done.

As problems go, this isn't the end of the world. I posted a wishlist
support ticket on Github, but so far no luck. Fixing it myself didn't occur
to me. But yesterday [Alexis Sellier][c] tweeted about a bookmarklet he wrote
to tweak Github: [github-unwatcher][ghu]. And, thus, an idea was born ---
and stolen.

The bookmarklet is the result of a couple of hours noodling around. It
appears to work well, and I don't see any bugs. I've tested it on OSX,
using Safari, Chrome and Firefox. If you can think of any improvements in
the Javascript or have any trouble with the bookmarklet, please let me know
[on Github][gd] or [via Twitter][met]. Otherwise, enjoy deleting lots of
gists.

## A visual explanation

Before:

![No buttons][before]

[before]: http://f.cl.ly/items/3r3M1M2o2r1k1i2v0A1I/Screen%20Shot%202012-03-07%20at%2011.17.43%20AM.png

After:

![Buttons!][after]

[after]: http://f.cl.ly/items/2V1C210x2d1m1y013z1P/Screen%20Shot%202012-03-07%20at%2011.18.00%20AM.png

[c]: http://twitter.com/cloudhead
[ghu]: https://github.com/cloudhead/github-unwatcher
[met]: http://twitter.com/telemachus
[gd]: https://github.com/telemachus/gist-deleter
