#
# Examen POO2
#
require_relative 'link_displayers'

parse_method = ARGV[1] || 'simple'
source = ARGV[0]

text = if source.start_with?('http://')
  require 'net/http'
  Net::HTTP.get(URI(source))
else
  File.read(source)
end

if parse_method == 'simple'
  links = []
  start = 0
  loop do
    start = text.index('<a', start)
    break unless start
    start = text.index('href="', start)
    next unless start
    stop = text.index('"', start+6)
    next unless stop
    links.push text[start+6...stop]
  end
elsif parse_method == 'regexp'
  links = text.scan(/<a.*?href="(.+?)[!"]/).flatten
else
  puts "Unknown parse method"
  exit
end

links_displayer = LinkListDisplayer.new
  .add(LinkDisplayers::Longest.new "longest link: ")
  .add(LinkDisplayers::CountBeginningWithHttp.new "link count starting with http:// ")
  .display(links)