class LinkListDisplayer
    def initialize
        @displayers = []
    end
    def add displayer
        @displayers.push displayer
        self
    end
    def display(array)
        @displayers.each{|displayer| displayer.display(array)}
    end
end

module LinkDisplayers
    class LinkDisplayer
        def initialize display_title
            @display_title = display_title
        end
        def display array
            #could also have been defined in the sub classes (but not today)
            puts "#{@display_title}#{result(array)}"
        end
    end
    #displayers
    class Longest < LinkDisplayer
        def result array
            array.sort_by {|text| text.size}.last
        end
    end
    class CountBeginningWithHttp < LinkDisplayer
        def result array
            array.select {|text| text.start_with? 'http://'}.size
        end
    end
    #example
    class Count < LinkDisplayer
        def result array
            array.size
        end
    end
end