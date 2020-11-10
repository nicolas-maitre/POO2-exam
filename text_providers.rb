class TextProvider
    def self.create method
        (case method
        when :file
            FromFile
        when :http
            FromHTTP
        when :db
            FromDB
        end).new
    end
    def initialize
        raise "this class should not be instanciated"
    end
    class FromFile
        def text source
            File.read(source)
        end
    end
    class FromHTTP
        def text source
            require 'net/http'
            Net::HTTP.get(URI(source))
        end
    end
    class FromDB
        def text source
            raise "DB text source is not implemented yet"
        end
    end
end