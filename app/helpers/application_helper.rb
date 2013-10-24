module ApplicationHelper
  def markdown(text)
    # If using Redcarpet gem
    #options = { :autolink => true, :fenced_code_blocks => true }
    #syntax_highlighter(Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(text)).html_safe
    
    # Otherwise with github-mardown gem
    syntax_highlight(GitHub::Markdown.render_gfm(text)).html_safe
  end
  
  def syntax_highlight(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
end