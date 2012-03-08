---
title: Gist-deleter v0.0.3
kind: article
created_at: 2012-03-08
location: New York, NY
h1: More good. Less bad.
---

When I released gist-deleter yesterday, I knew it had one stupid flaw: if
you clicked repeatedly on the bookmarklet, it would create extra 'delete
this gist' links. But I figured that most people wouldn't do that, and
I wanted to get it out quickly.

Unfortunately, I got a quick bug report from [Mathias Lafeldt][ml] who told
me that the problem was worse than I thought. Repeated clicks on the
bookmarklet created an almost exponential explosion of links. I pushed out
a quick-fix yesterday, but here is a full and proper update.

As of now, multiple clicks should not produce any redundant links. Please
delete your old version of gist-deleter and update it with the one below.
If you find any trouble with this version, please let me know via
[Github][gh] or [Twitter][t].

Gist-deleter v0.0.3:

<p><a href='(function(){function a(c){var d=document.createElement("span");var b=document.createElement("a");var e="/delete"+c;b.href=e;b.className="gistDeleter";b.innerHTML="delete this gist";b.onclick=function(f){$(b).closest("div.file").fadeOut();$.ajax(e,{type:"delete","data-method":"delete"});f.preventDefault()};$(d).append(b);return d }if($("a.gistDeleter").length===0){Array.prototype.slice.call($(".file .info span:first-child a")).forEach(function(b){var c=$(b).attr("href");$(b).closest("div.info").append(a(c))})} }());'>Gist deleter</a></p>

[mt]: https://twitter.com/mlafeldt
[t]: http://twitter.com/telemachus
[gh]: https://github.com/telemachus/gist-deleter
