#
# Examen POO2
#
require_relative 'text_providers'
require_relative 'html_links_parsers'
require_relative 'link_displayers'

parse_method = ARGV[1] || 'simple'
source = ARGV[0]
source_method = if source.start_with?('http://')
  :url
else
  :file
end
#EXAM: source using a parametric factory DP
text_provider = TextProvider.create source_method
text = text_provider.text source

#EXAM: parsing using a parametric factory DP
link_parser = HTMLLinksParser.create(parse_method)
links = link_parser.parse text

#EXAM: display using the chain of responsability DP
LinkListDisplayer.new
  .add(LinkDisplayers::Longest.new "longest link: ")
  .add(LinkDisplayers::CountBeginningWithHttp.new "link count starting with http:// ")
  .display(links)