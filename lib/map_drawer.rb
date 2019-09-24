require 'Gosu'
require_relative 'data_reader.rb'



class Map_drawer

    def initialize(window, tilesize)
        @window = window
        @tilesize = tilesize

        data = Data_reader.read
        
        @floortiles = {}
        data.each_with_index do |dat, i|
            @floortiles[dat[0]] = Gosu::Image.new("../img/tiles/#{dat[1]}.png")
        end

    end

    def update

    end

    def draw(camera, map)

        map.each_with_index do |row, i|
            row.each_with_index do |symbol, j|
                if symbol == nil
                    next
                elsif symbol == "_"
                    next
                else
                    img = @floortiles[symbol]
                    img.draw(j*@tilesize - camera.x, i*@tilesize - camera.y, 0)


                end


            end

        end
        
    end

end

# m = Map_drawer.new