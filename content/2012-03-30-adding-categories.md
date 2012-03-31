---
title: Adding Categories
kind: article
created_at: 2012-03-30
location: New York, NY
h1: Categories
categories:
- blog
- ruby
- nanoc
- categories
---

## nanoc

Before discussing how I added categories to the blog, I need to say
a little about how this site works. I use [nanoc][n], a static site
generator. (If you already know all about tools to make static websites or
nanoc in particular, you should probably skip this section.)

[n]: http://nanoc.stoneship.org/

Here's a simplified version of how nanoc works. You create an input folder
and fill it with content. The content can be images and other media, but in
general it will be text files in whatever format. Common examples will be
HTML, CSS, Javascript, Markdown and so on. Once you have everything ready,
you run nanoc and it processes the input folder and creates an output
folder. The output folder *is* your website, which you can then upload to
your server via FTP or rsync or whatever means you like.

Based on what I've said so far, you might be wondering, "Why not just
create the files, place them directly in the output folder and skip the
nanoc step?" That is, what does nanoc add? Again this is simplified, but
what nanoc adds is filters and processing rules. These give you a lot of
the strengths of a dynamic website (rapid site-wide changes, easy to work
on in pieces) without giving up the strengths of a static site (speed,
security). For example, I write content in Markdown and layouts in ERB.
When I have new content or a new layout ready, nanoc automates the process
of (1) turning the Markdown into HTML, (2) piping that HTML though the ERB
layout and then (3) running the finalized HTML content + ERB layout through
Typogruby to give me prettier content. Another simple example: the front
page of my site always shows the latest five articles in reverse order of
posting. If the site were completely static, I would have to update that
list of links every time I wrote a new article. With nanoc, that's handled
automatically (via a little Ruby in a template).

Out of the box, nanoc provides a ton of [helpers][h] and [filters][f], but
I wanted a categories helper. There is a [tagging][t] helper, but it
wasn't quite what I had in mind. Also, this was a nice opportunity to learn
more about nanoc's internals by building something extra for it. For the
most part, this was very simple, but I'm going to walk through it anyhow.
It will help me solidify what I learned and maybe help someone else too.

[h]: http://nanoc.stoneship.org/docs/api/3.3/Nanoc/Helpers.html
[f]: http://nanoc.stoneship.org/docs/api/3.3/Nanoc/Filters.html
[t]: http://nanoc.stoneship.org/docs/api/3.3/Nanoc/Helpers/Tagging.html

## Categories?

What do I mean by categories? My site is mostly posts. Each post covers one
or more topics, and those topics often overlap. I talk about Vim in
a number of places. Same with Ruby, Bash and so on. I wanted every post to
display its key topics (its categories), and I also wanted to have the
categories be clickable links. Click on [Ruby][r], and you should be taken
to a page that shows you all the posts that include Ruby as a topic. Also,
I wanted to create a page on the site that displays [all the categories][c]
as clickable links. When a new category is added anywhere in the site, that
page should be updated. (Another good example where a static site generator
makes life easier than a truly static site.)

[r]: ../../../categories/ruby.html
[c]: ../../../categories.html

## Code, please.

So enough talking, how does it work? There are three main pieces of
functionality:

+ Add categories to posts and display those categories in individual posts
+ Create a page for all categories
+ Create pages for individual categories

The first step is simple. In nanoc, textual items are always content plus
metadata. The metadata is stored as YAML, and it's completely freeform. So
you can add whatever you need there. As an example, the YAML for this page
looks like this:

    ---
    title: Adding Categories
    kind: article
    created_at: 2012-03-30
    location: New York, NY
    h1: Categories
    categories:
    - blog
    - nanoc
    - categories
    ---

Add that `categories` item to the YAML, and boom. Now every page has an
array of categories.

It's equally easy to access that information about an item. Any metadata
for a page can be accessed at `@item[:attribute]`. So to add the list of
categories to each post, I just added this to the posts layout:

    <p>Categories: <%= link_categories(@item[:categories]).join(', ') %></p>

The `link_categories` method hasn't been explained yet, but we'll get
there soon. Notice that it takes zero new code to add metadata to an item
in nanoc. In order to create category pages, however, and to make the
categories links, we need to add helper code. By default, nanoc will
require any Ruby code we place in a `lib` folder at the root of our
project. The following lives at `lib/categories.rb`:

      def all_categories(posts=articles)
        cats = []
        posts.each do |article|
          next if article[:categories].nil?
          cats << article[:categories]
        end
        cats.flatten.compact.uniq
      end
      memoize :all_categories

      def has_category?(category, article)
        if article[:categories].nil?
          false
        else
          article[:categories].include?(category)
        end
      end

      def articles_with_category(category, posts=articles)
        posts.select { |article| has_category?(category, article) }
      end
      memoize :articles_with_category

      def articles_by_category(posts=articles)
        cats = []
        all_categories.each do |cat|
          cats << [cat, articles_with_category(cat)]
        end
        cats
      end
      memoize :articles_by_category

      def link_categories(cats)
        cats.map do |cat|
          ['<a href="/categories/', cat, '.html">', cat, '</a>'].join
        end
      end

The first method goes through an array of articles (all of them by default,
though you can pass in a smaller selection) and returns an array of all the
unique categories. (Maybe I should use a [Set][s]? I'm thinking about it.)
The `has_category?` method should be pretty clear: return true or false if
a given category is found for a given article. That method in turn is used
by `articles_with_category` to find all the posts for a given category. The
`articles_by_category` method returns what I think of as an array of
tuples. Each item in the array is a two-member array: the first item is
a category, and the second is an array of all the articles in that
category. I'll need that method soon to build up all the individual
category pages and display their posts. The final method, which is pretty
kludgy takes an array of categories and returns an array of those category
names as HTML links. It's ugly, but better hidden away here then in an ERB
view.

[s]: http://ruby-doc.org/stdlib-1.9.3/libdoc/set/rdoc/Set.html

## The Hard Part

So far, all of this has been pretty simple stuff. The only thing that was
complicated was the following. Normally nanoc scans the input folder for
items which it then runs through filters according to a set of rules,
placing the final results in the output folder. But in this case, the
individual category files aren't yet in the input folder. In fact, *they
can't be there yet*. Until we've scanned the articles for their categories,
there's no way to know what pages we will need. This gave me a bit of
a headache at first, but it turns out that nanoc has us covered. During
processing nanoc works with an `@items` array, and it's possible to add
things to that array dynamically and in-memory. That is, you can add things
to `@items` that have no textual representation in advance. In addition,
nanoc provides a `preprocess` method that you can call during compilation.
Whatever code you run in that method happens *after* the site has been
scanned but *before* nanoc compiles the `@items`. This is exactly the hook
I needed. Here's the final method in `lib/categories.rb`:

    def create_category_pages
      articles_by_category.each do |category, posts|
        @items << Nanoc::Item.new(
          "<%= render('category', :category => '#{category}') %>",
          {
            :title => "Posts in #{category}",
            :h1 => "#{category} posts",
            :posts => posts
          },
          "/categories/#{category}",
          :binary => false
        )
      end
    end

Using the `articles_by_category` method from above, we go through each
category, create a new nanoc item for it and add that item to the `@items`
array. The content of each item is a single line of ERB that renders some
metadata through a template. The rest of the parameters provide the
metadata, specify the items identifier (which is sort of its filename) and
specify that the item is textual not binary. (For more information about
`Nanoc::Item` initialization, see [the API docs][docs].) All of the posts
for each category are fed as metadata to the category's in-memory page,
waiting to be rendered as links later in a template. It's a little bit of
hocus-pocus, but not very much work at all for us to create a large set of
pages with no textual reality at all. Shiny.

[docs]: http://nanoc.stoneship.org/docs/api/3.3/Nanoc/Item.html#constructor_details


## Links and Credits

The source code of my site is available [on Github][source]. Here's the
[categories code][cats] if that's all you want to look at. I just noticed
that I don't have a license there, but I'll put one up shortly. In
a nutshell, it's "take what you like, but don't blame me". While working on
all of this, I received advice from [Justin Hileman][jh] and [Denis
Defreyne][dd] (nanoc's creator). Justin also shared a gist of some code he
uses on [his blog][jhb] for tags. However, nobody but me is to blame for
anything stupid in my categories implementation. That's all me.

[source]: https://github.com/telemachus/ithaca
[cats]: https://github.com/telemachus/ithaca/blob/master/lib/categories.rb
[jh]: http://twitter.com/bobthecow
[dd]: http://twitter.com/ddfreyne
[jhb]: http://justinhileman.info/
