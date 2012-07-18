---
title: Grep Trimming
kind: article
created_at: 2012-07-18
location: New York, NY
h1: A Pretty Trick
categories:
- shell
- bash
- bashism
- grep
---

## The Trick

Today I learned that you can avoid one of the two uses of `grep` in things
like the following:

     ps a | grep cmd | grep -v grep

If that's not clear to you already, the `-v` option in the second call to
`grep` inverts the matching. So the last bit of the pipeline selects items
that *don't* match the string 'grep'. By adding that second `grep`, we can
trim results that would otherwise look like this:

    telemachus ~$ ps a | grep irssi
     2118 s000  R+     0:00.00 grep irssi # We don't want to see this.
      867 s001  S+     0:07.86 irssi

Here's the trick:

    # Replace [c]md with whatever command you really have. E.g., [i]rssi.
    ps a | grep [c]md
    # Let's test it on the example from above.
    telemachus ~$ ps ax | grep [i]rssi
      867 s001  S+     0:10.71 irssi

We replaced `grep cmd | grep -v grep` with `grep [c]md`. That removes one
process from the pipeline. It turns out that we can get the same result
*without* two calls to `grep`. Awesome. But, um, how the hell does it work?

## The How

The pattern `[c]md` should seem odd. More specifically, it should look
useless. Here, however, the apparently "useless use of a character class"
serves an important purpose.  It hides the `grep` invocation from the
`grep` results.  By the time `grep` gets to work, the character class `[c]`
has been expanded to just `c`. So `grep` goes looking for 'cmd'.  However,
what ends up in your process list is the unexpanded version: `grep [c]md`.
*That* of course is not a match for 'cmd', and so the `grep` you wanted
left out of the results disappears. QED. Exactly *why* the process list
gets the unexpanded `grep [c]md` is still not 100% clear to me. I need to
read more about the precise order of operations for shell lines.

(I'm assuming readers know about the use of `[]` for a [character
class](http://www.regular-expressions.info/charclass.html). Just in case
anyone doesn't know about those or wants a review: inside of a character
class, you can include one or more literal characters or a type of
characters to match. You can also have a negated class, but let's stay
simple. So, for example, `[bm]at` would match 'bat' as well as 'mat'.
What's weird about `[c]md` is that it should be exactly equivalent to `cmd`
since there's only one thing in the character class. Hence, the thought
above that it should look useless.)

## The Wrinkle

First, a detour. I discovered this trick in a great set of
[slides](http://www.netmeister.org/slides/nycbug201205/) by [Jan
Schaumann](https://twitter.com/jschauma). Also, to be perfectly honest, I
didn't understand *why* the trick worked until I listened to the [audio
recording](http://www.fetissov.org/public/nycbug/nycbug-05-02-12.mp3). It's
important to give credit where it's due. Finally, the talk's title is
"Useless Use of...This and That", and even if you're not a fan of "useless
use of cat"-style lectures, it's very worth a look. (I have mixed feelings
myself about "useless use of x" as a slogan. On the one hand, I like the
opportunity to improve code by simplifying. On the other hand, people who
actually say "That's a useless use of x" in IRC or forums are often just
showing off. Bottom line: Jan isn't being a jerk or showing off. He knows a
ton.  Learn from him.)

Once I understood the idea, I had a further problem. The places where I
wanted to use the trick were slightly different: instead of a literal
'cmd', they used a parameter passed to a shell function. My new problem was
"How can I use the same trick when I don't have a literal string?" I
tweeted Jan himself, and he quickly suggested `ps waux | grep $(echo
${cmd})`. But he added, "a bit hackish, though." My initial response was
that if I was willing to create another process for `echo`, I might as well
just use `grep -v` (since it's far clearer). After thinking more about Bash
parameter tricks, I came up with this:

    ps ax | grep [${cmd:0:1}]${cmd:1}

That's foul to read, but it works. The crazy `${cmd:0:1}` stuff is built-in
[Bash substring
expansion](http://wiki.bash-hackers.org/syntax/pe#substring_expansion).  In
addition to being ugly, though, [it's a
Bashism](https://wiki.ubuntu.com/DashAsBinSh/#A.24.7Bfoo:3.5B:1.5D.7D), as
Jan pointed out to me.  It's not supported in POSIX shell.  In my case that
was fine, but it's not always a good idea. (I was dealing with an
explicitly Bash script.)

## Where Are We?

Well, I learned a good trick today, but it has some limitations. I figured
I would share the tip since I haven't blogged in a bit. Also, I was hoping
that maybe some reader would have a suggestion I haven't thought of for how
to use the trick even with variable parameters. I'll probably post this to
Hacker News and/or Reddit, but you can also respond to me [on
Twitter](http://twitter.com/telemachus). Please let me know if my
explanation or examples have any problems.

More importantly, [Jan's site](http://www.netmeister.org/) is filled with
good things (both slide decks from talks and blog posts). You should
probably check that out and stop hanging out here.

(Thanks to [@nadir](https://twitter.com/nadir_tornow) for reading a draft
and giving me helpful feedback.)
