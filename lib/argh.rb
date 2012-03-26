class Argh < Nanoc::Filter
  identifier :argh

  def run(content, params={})
    content.gsub("&#39;", "'")
  end
end

