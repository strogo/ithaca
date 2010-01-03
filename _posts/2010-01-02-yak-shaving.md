---
layout: post
title: Yak shaving
location: New York, NY
h1: Yak shaving, or Why does this website have no style?
---

## Huh?

Let's start a little bit back from the central idea. I'm good at wasting time. I'm really good at it. I'm all-city, all-pro, all-American. I'm world class. I really wanted this website to have a great CSS-based look. I just haven't done it because of all the time-wasting. Having said that, it's still important to explain a bit more about *how* and *why* I waste time so well. Let's do that, shall we?

I don't have a lot to say about *why*, so I 'll do that first. I've thought about it a lot - it's a good way to waste time, after all - but I don't really understand why I have this tendency. I can say that it has something to do with a fear of not knowing enough. If I use Ruby, but Ruby's interpreter is written in C, do I need to know C? Part of me answers "No" for all sorts of good, sane reasons, but it nags me. I have this lingering guilt and shame that I don't *really* know Ruby, since I don't understand the language that its interpreter is written in. I know this is irrational (and just plain false), but again, it eats at me anyhow. In the case of making a website, there are endless things I might want or need to know more about, so this itch offers a lot of potential pain.

The *how* is somewhat more entertaining. What I like to do is begin task A, but then (almost immediately) delay A in order to work on task pre-A. Task pre-A - maybe it's obvious, but maybe not - is a task related to A as an (allegedly) necessary pre-cursor. It's something that I decide I absolutely must do *before* I can begin task A. It happens to everyone at one time or another: you start something and then realize that you have some prepatory work to do first. So you delay the goal and do the groundwork. Fine and good. However, what *I* do is start task pre-A, but then (almost immediately) push it off in order to do task pre-pre-A. You can probably see where this is going.

Before long, I have a deeply nested stack of things I need to do before I can get anywhere near whatever I started out to do. I'll take this site as an example. For about - awful confession time - five or six months now, I've been working on this site. Once upon a time, I had an [ikiwiki][ikiwiki] blog that I used to post notes and reminders to myself about Perl or Bash or Vim or Debian or sys-admin stuff. It wasn't really a blog, just a place for me to put up things that I thought were cool or I figured out how to do or that I wanted to remember how to do later. I gave up that site some time ago, and eventually I wanted a new one. So I got right to work: I got some new hosting and immediately began stacking up things to do before I could actually write anything here.

[ikiwiki]: http://ikiwiki.info/

Here's an abbreviated list (with sub-lists, naturally) of things I did first.

+ Push it way back and worry about platforms and version control:
	+ Git or Subversion?
	+ Ruby or Perl?
	+ Jekyll or Rails?
		+ Markdown?
		+ Textile?
		+ Haml?
+ Are my standards in order?
	+ XHTML or HTML?
	+ HTML5 or HTML4?
	+ I should really learn more about HTML...
		+ Microformats?
			+ This whole semantic markup thing sounds cool. Let's read more about that.
				+ Do I really understand REST? 
					+ I really need to know more about HTTP...
+ Should it have a feed?
	+ RSS?
	+ Atom?
	+ Feedburner or do-it-myself?
+ Comments?
	+ DISQUS?
	+ IntenseDebate?
+ What should the site look like?
	+ CSS?
	+ Sass?

At some point around here, I broke out of that cycle of despair. I realized that although I had read a lot and thought a lot and learned some useful things, I was hopeless. A few coincidences helped. First, I read [Project Stack Push/Pop][push] by Dave Rolsky and saw [Randal Schwartz's comment][comment] about [yak shaving][yak]. The article struck a nerve because it fit too well *and* my time-wasters aren't nearly as productive as Rolsky's. Second I'm a teacher, so I just had a two-week vacation. Naturally I planned to (finally) get the site going, and naturally I made zero headway. Finally, a new year just began. Although I don't really go in for resolutions, inevitably you get that hopeful but scary feeling that it's a clean slate and anything is possible.

[push]: http://blog.urth.org/2009/12/project-stack-pushpop.html
[comment]: http://blog.urth.org/2009/12/project-stack-pushpop.html#comment-138
[yak]: http://catb.org/jargon/html/Y/yak-shaving.html

So, that's why this page has no style. After a *long*, *long* time I had accomplished nothing except some decisions: Git, Ruby, Jekyll, Markdown, HTML4, an Atom feed and no comments. I was in the process of reading up more on HTTP and retooling my CSS chops in order to design the site. There's a line in Vergil's <cite>Aeneid</cite> where the hero Aeneas describes Italy as "semper cedentia" - always receding - because he feels as though no matter how much he struggles, he's no closer to reaching his goal (<cite>Aeneid III, 496</cite>). I felt like that, but less well written. So, the hell with it. I can write an article now about yak shaving and just post the damn thing. This will be good because (a) it will be some actual forward momentum and (b) I can hope that it will shame me into working on the CSS bit more quickly. It's January 2nd now. We'll see how that goes. (Oh, and by the way, the About page is a non-link at the moment. One thing at a time.)

## What was that about a yak?

Here's <cite>[Zed Shaw on yak shaving][zed]</cite>:

> "Yak shaving" is a programmer's slang term for the distance between a task's start and completion and the tangential tasks between you and the solution. If you ever wanted to mail a letter, but couldn't find a stamp, and had to drive your car to get the stamp, but also needed to refill the tank with gas, which then let you get to the post office where you could buy a stamp to mail your letter—then you've done some yak shaving.

In the process of writing this up, I went looking in Eric Raymond's [Jargon file][jargon] and elsewhere for definitions and quotations about yak shaving. I had always thought that it meant the unnecessary, neurotic activity where you spin in ever widening circles *away* from your goal, but apparently not. I use the word with this negative connotation, but the strict meaning appears to be neutral - or negative but in a different way. In Zed Shaw's example, you actually do need to fill the tank, to go to the post office, to buy the stamps, to finally mail the letter. This is a pain, but it's real work. It turns out that I've been using the phrase wrong all this time. When I figured this all out, my first thought was that I should retitle and rewrite this post. I didn't, for obvious reasons. After all, the first step may be admitting I have a problem, but for me the most important step is the rake task that will *post this damn page*.

## What next?

Well, you know, baby steps and all that. Soon enough I hope to write the About page and add some CSS. At that point, I will have to decide whether to leave this page unstyled - it's kind of the point, really - or to link the style to this page as well. That will be one of those good problems to have. I should also write more posts. Lots to do. And I still need to learn more about HTTP. I hear that [HTTP-bis][httpbis] is coming...

[zed]: http://www.cio.com/article/191000/
[jargon]: http://catb.org/jargon/html/index.html
[httpbis]: http://www.ietf.org/dyn/wg/charter/httpbis-charter.html
