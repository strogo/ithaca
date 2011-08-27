include Nanoc3::Helpers::Blogging
require 'fileutils'

def blog_route(item)
  if not item.identifier.match(/\d{4}-\d{2}-\d{2}-/)
    raise "Ill-formed blog date."
  end
  year, name = item.identifier[0..11], item.identifier[12..-1]
  year.gsub('-', '/') + name.chop + '.html'
end
