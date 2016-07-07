module SnippetsHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def markdown(content)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      disable_indented_code_blocks: true,
      no_intra_emphasis: true,
      lax_spacing: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      autolink:           true,
      superscript:        true,
      fenced_code_blocks: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

end
