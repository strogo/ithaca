class HTMLFilter < Nanoc3::Filter
  identifier :as_html

  def run(content, params={})
    content.gsub(' />', '>')
  end
end
