class HTMLLinksParser
    def self.create method
        (case method
        when 'simple'
            WithSimple
        when 'regexp'
            WithRegexp
        else
            raise "Unknown parse method"
        end).new
    end
    def initialize
        raise "this class should not be instanciated"
    end
    class WithSimple
        def parse text
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
            links
        end
    end
    class WithRegexp
        def parse text
            text.scan(/<a.*?href="(.+?)[!"]/).flatten
        end
    end
end