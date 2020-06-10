require "spec"
require "../src/rinku"

def generate_result(link_text, href = nil, escape = false)
  href ||= link_text
  %{<a href="#{href}">#{link_text}</a>}
end
