---
layout: post
title: Including Ruby Modules Dynamically
kind: article
created_at: 2010-07-29
location: New York, NY
h1: <code>include</code> is hard. Let's go shopping.
categories:
- ruby
- include
- fileutils
- modules
- privacy
- stackoverflow
---

## You want what?

I'm not sure whether this is a common need, but I also doubt I'm the only
person ever to want it. At a certain point in my application, I will
`include FileUtils`. However, `FileUtils` comes in three flavors:
`FileUtils`, `FileUtils::DryRun` and `FileUtils::Verbose`. The three
flavors do pretty much what you would expect:

+ Default flavor: export `cp`, `mkdir` and company
+ A simulation flavor: export `cp` and company, but *don't actually do
  anything*. (This is like adding a `:noop` option to every command.)
+ A verbose flavor: export `cp` and company, but be chatty whenever you run
  a command. (This is like adding a `:verbose` option to every command.)

What would be nice is if I could let the user pick which version of
`FileUtils` she wants by passing an appropriate flag at runtime. (It's a
command-line application.) The options part is no problem (thanks to
[`OptionParser`][op]), and I can easily pass the choice over to the part of the
application that will do the `include`. However, this is where it gets
tricky. This won't work. Can you guess why?

[op]: http://www.ruby-doc.org/stdlib/libdoc/optparse/rdoc/classes/OptionParser.html

    class Worker
      def initialize(choice)
        if choice == 'dryrun'
          include FileUtils::DryRun
        elsif choice == 'verbose'
          include FileUtils::Verbose
        else
          include FileUtils
        end
      end
    end

It doesn't work because `include` is a private method of `Module`, and
`self` is the instance inside the `initialize` not the class. Hrmm. At this
point, I came up with two bad solutions. (They worked, but stank, and I
won't even go into them here.) I also posted a [question to Stack
Overflow][so]. (See the question, if you are really curious about the two
bad solutions.) What follows are two better answers and a bit of increased
Ruby understanding for me.

[so]: http://stackoverflow.com/questions/3358601/

## First solution: use the `self`

The first (and so far, only) response to my SO question began, "So what if
it's private?" The author then reminded me that there are ways around that
kind of privacy:

    class Worker
      def initialize(choice)
        if choice == 'dryrun'
          self.class.send(:include, FileUtils::DryRun)
        elsif choice == 'verbose'
          self.class.send(:include, FileUtils::Verbose)
        else
          self.class.send(:include, FileUtils)
        end
      end
    end

This delivers the desired `include` to the right object (the instance's
class). Works great, and for my specific use-case, this is the answer. It
does mean, however, that *all* instances of this class share the same
`include`. But the response I got also showed me another way.

## Second solution: let each instance do its own thing

In my case, all instances should work together. Either they all do a dry
run only, or they all do it for real. But sometimes, you will want more
granularity than that. You may want *this* instance to be verbose, but
*that* one to work silently, while *that third* one over there is a no-op
dry run. You can get that too:

    class Worker
      def initialize(choice)
        if choice == 'dryrun'
          extend FileUtils::DryRun
        elsif choice == 'verbose'
          extend FileUtils::Verbose
        else
          extend FileUtils
        end
      end
    end

Using `extend`, we bring the module's methods in for each object on a
per-object basis (as singleton methods for *that* object, rather than
class-level methods). Again, in my case, this isn't necessary, but it's
good to know for some other time. While I'm here, there's another way to
write this up as well:

    class Worker
      def initialize(choice)
        if choice == 'dryrun'
          class << self; include FileUtils::DryRun; end
        elsif choice == 'verbose'
          class << self; include FileUtils::Verbose; end
        else
          class << self; include FileUtils; end
        end
      end
    end

I can't think of any reason to prefer the more verbose version, but it's
good to be familiar with the look since I may see it in other people's
code.
