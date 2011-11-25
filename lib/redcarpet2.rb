class RedCarpet2 < Nanoc3::Filter
  identifier :redcarpet2

  def run(content, params={})
    require 'redcarpet'

    options = params[:options] || []
    smart = options.delete(:smart)
    markdown = Redcarpet::Markdown.new(::Redcarpet::Render::HTML, *options)

    if smart
      # This should be temporary for 2.0.0b5
      # See https://github.com/tanoku/redcarpet/issues/57
      html = markdown.render(content)
      html.gsub!("&#39;", "'")
      Redcarpet::Render::SmartyPants.render(html)
    else
      markdown.render(content)
    end
  end
end
