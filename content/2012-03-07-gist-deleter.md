---
title: Announcing Gist-deleter
kind: article
created_at: 2012-03-07
location: New York, NY
h1: Scratching an Itch
categories:
- bookmarklet
- git
- gist-deleter
- javascript
- jquery
- github
---

## tl;dr

I've written a bookmarklet that makes it easier to delete multiple gists
from the main gist viewing page. (Normally, you need to visit each gist's
page in order to delete it. This is tedious if you want to delete five or
ten gists.)

Drag the link below to your bookmarks bar. Then to activate it, simply
visit [your main gists page][gists] and click the bookmarklet.

<p><a href='javascript:(function(){function b(e){var f=document.createElement("span");var d=document.createElement("a");var g="/delete"+e;d.href=g;d.className="gistDeleter";d.innerHTML="delete this gist";d.onclick=function(h){$.ajax(g,{type:"delete","data-method":"delete",success:function(){$(d).closest("div.file").fadeOut()}});h.preventDefault()};$(f).append(d);return f}function a(){return window.location.host==="gist.github.com"&&window.location.pathname==="/mine"&&$("a.gistDeleter").length===0}if(a()){var c=Array.prototype.slice;c.call($(".file .info span:first-child a")).forEach(function(d){var e=$(d).attr("href");$(d).closest("div.info").append(b(e))})}}());'>Gist deleter</a></p>

**NB**: This is v0.0.2, thanks to [Mathias Lafeldt][ml] who pointed out
that multiple clicks of the bookmarklet increased the number of links
exponentially.

**NB**: Now it's v0.0.3. Enjoy.

**NB**: And...v0.0.4. Amazing how quickly kids grow up, isn't it?

[gists]: https://gist.github.com/mine
[ml]: http://twitter.com/mlafeldt

## A little more explanation

I love Github. Truly. Love, love, love it. I love gists. Truly. Love, love,
love them. In fact, I probably love gists too much --- and that's where the
problem begins. I create a lot of gists: for myself, when I'm on irc, to
email people and so on. But many of these gists are very trivial. I'm not
likely to ever want them again. In and of itself, that's not a huge deal.
However, it makes it harder for me to find the gists I really care about in
the sea of throw-away ones.

So every now and again, I want to clean up my gists. This turns out to be
slightly harder than it should be. When you visit [your primary
gist-listing page][gists], there's no way to delete gists from that main
page. You can see about fifteen or so gists, but to delete any of them, you
must click on the gist's link and then delete it from an individual show
page. After deletion, you're redirected back to the main gist show page.
The pattern is: list gists, pick gist, delete gist, redirect, list gist,
pick gist, delete gist, redirect and so forth. What I want is a simpler
workflow: list gists, delete gist, delete gist, delete gist. Done.

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
