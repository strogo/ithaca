class RedCarpet2 < Nanoc3::Filter
  identifier :redcarpet2

  def run(content, params={})
    require 'redcarpet'

    options = params[:options] || []
    smart = options.delete(:smart)

    if smart
      html =
        Redcarpet::Markdown.new(::Redcarpet::Render::HTML, *options).render(content)
      Redcarpet::Render::SmartyPants.render(html)
    else
      Redcarpet::Markdown.new(::Redcarpet::Render::HTML, *options).render(content)
    end
  end
end
