---
title: Gist-deleter updated
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

Gist-deleter v0.0.4

<p><a href='javascript:(function(){function b(e){var f=document.createElement("span");var d=document.createElement("a");var g="/delete"+e;d.href=g;d.className="gistDeleter";d.innerHTML="delete this gist";d.onclick=function(h){$.ajax(g,{type:"delete","data-method":"delete",success:function(){$(d).closest("div.file").fadeOut()}});h.preventDefault()};$(f).append(d);return f}function a(){return window.location.host==="gist.github.com"&&window.location.pathname==="/mine"&&$("a.gistDeleter").length===0}if(a()){var c=Array.prototype.slice;c.call($(".file .info span:first-child a")).forEach(function(d){var e=$(d).attr("href");$(d).closest("div.info").append(b(e))})}}());'>Gist deleter</a></p>

[ml]: https://twitter.com/mlafeldt
[t]: http://twitter.com/telemachus
[gh]: https://github.com/telemachus/gist-deleter
