---
layout: post
title: FTP meet HTTPS
location: New York, NY
h1: An easier way to talk to Github
---

## Grandpa, what's FTP?

Nah, I'm not really going to talk about [FTP](http://en.wikipedia.org/wiki/Ftp), but I learned something today about using an old-school FTP configuration file with a new-fangled version control system.

For some time now, both [git](http://progit.org/2010/03/04/smart-http.html) and [github](http://github.com/blog/642-smart-http-support) offer improved HTTP support. That is, using git over HTTP(S) is much, much more efficient than it once was. I've been somewhat randomly using HTTPS instead of SSH, and so up until earlier tonight, about 40% of my repos were HTTPS and the rest were still SSH. This is a pain, not least of all because my fingers often reflexively type one password when I need the other. Today, however, I read about a trick that convinced me (1) to change over to HTTPS altogether and (2) to stop using the damn password every time.

Short version: if you add something like the following to `~/.netrc`, then you can pull and push from Github using HTTPS, without entering your password:

<pre><code>machine github.com
login YOUR_NAME_HERE
password DONT_TELL</code></pre>

Now, if you're anything like me, you're saying, "`~/.netrc`? What's that?" And that is where we come back to FTP. Your [`.netrc`](http://man.cx/netrc) as the 'rc' suggests is a Unix/Linux configuration file. Apparently, back when dinosaurs walked the earth, people used this specific config file to store login information (and macros) for FTP sessions. Although most write-ups that I found online focus on FTP, [one source](http://publib.boulder.ibm.com/infocenter/aix/v6r1/index.jsp?topic=/com.ibm.aix.files/doc/aixfiles/netrc.htm) says more generally, "This file is part of TCP/IP in Network Support Facilities." As such, it makes sense for git to check there for credentials, but I'm guessing that most people no longer even use a `.netrc`. I certainly didn't have one until today.

Although I now see that use of this config file is mentioned in the comments to Github's [announcement of smart HTTP support](http://github.com/blog/642-smart-http-support#comment-7410), I only met the idea today in a [tweet](http://twitter.com/#!/atmos/status/27319420419) from Githubber (is that a noun?) @atmos (Corey Donohoe). After a little back and forth with him to figure out details, I suggest you do this:

<pre><code>vim ~/.netrc # mvim, mate, gedit, emacs, whatever...
chmod 600 ~/.netrc
cd where_you_keep_your_code
perl -i.bak -ple 's{git\@github\.com:}{https://github.com/}' */.git/config
perl -i.bak -ple 's{username\@}{}' */.git/config
</code></pre>

You can then test that all is working well by `cd`-ing into a repo and running: `git ls-remote`. You should get results without needing to enter your password. (By the way, you may not need the second one-liner. I had some repos which were still using `ssh` and others which were using git 1.6-friendly URLs. See below on that. In any case, the first one-liner changes `ssh` repos to HTTPS and the second changes one form of HTTPS URL for another which you need to make this work.)

## Caveats

Now for the fine print.

+ You are putting your Github password into a file in the clear. Depending on your machine's physical and network security, this might be a very **bad** idea. You've been warned.
+ This won't work with the URLs that Github currently suggests for HTTP, the ones that look like this: `https://telemachus@github.com/telemachus/ithaca.git`. According to @atmos, those exist for backward compatibility with older versions of git, and they are served from a different machine. Simply translate such URLs to `http://github.com/telemachus/ithaca.git`, and you're good to go.
+ That said, this also won't work with earlier versions of git (where earlier means 1.6 or lower, I think). So, depending on what version of git you're using, this whole idea might be moot for you.

If I've made any mistakes or you think this is a terrible idea, feel free to let me know at telemachus /at/ arpinum /dot/ org. Otherwise, I hope you find this as useful as I did.
