module Nanoc::Helpers::Blogging
  extend Nanoc::Memoization
  memoize :articles
end
