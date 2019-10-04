
class Object_generator

    def initialize(window, tilesize, type = "objects", scale = 1)
        @window = window
        @tilesize = tilesize
        @scale = scale
        @filetype = ".yaml"

        data = Data_reader.read(type)
        
        #   make array a dictionary
        @object_symbol_and_names = {}
        data.each_with_index do |dat, i|
            @object_symbol_and_names[dat[0]] = dat[1]
        end

    end

    def generate(map)
        @objects = []

        map.each_with_index do |row, i| 
            row.each_with_index do |symbol, j|
                if symbol == nil
                    next
                elsif symbol == "_"
                    next
                else
                    obj = @object_symbol_and_names[symbol]
                    p obj
                    @success = false
                    begin
                        @objects << Object.const_get(obj).new(@window, j*@tilesize, i*@tilesize)
                        @success = true
                    rescue
                        @objects << Gameobject.new(@window, j*@tilesize, i*@tilesize, obj)
                        @success = true
                    ensure
                        if !@success
                            puts "Error: Unable to create object #{obj}"
                        end
                    end
                
                end
            end
        end
        return @objects

    end

    def update
    end

    def draw()
        
        
    end

end
