require 'Gosu'




class Map_drawer

    def initialize(window, tilesize, type = "tiles", scale = 1)
        @window = window
        @tilesize = tilesize
        @scale = scale

        data = Data_reader.read(type)
        
        @floortiles = {}
        data.each_with_index do |dat, i|
            @floortiles[dat[0]] = Gosu::Image.new("../img/#{type}/#{dat[1]}.png")
        end

    end

    def update()
    end

    def draw(camera, map)
        if camera != nil                        # location drawn depends on camera
            map.each_with_index do |row, i| 
                row.each_with_index do |symbol, j|
                    if symbol == nil
                        next
                    elsif symbol == "_"
                        next
                    else
                        img = @floortiles[symbol]
                        img.draw(j*@tilesize * @scale - camera.x, i*@tilesize * @scale - camera.y, 0, scale_x = @scale, scale_y = @scale)


                    end
                end
            end
        else                                    # location drawn is absolute on screen
            map.each_with_index do |row, i| 
                row.each_with_index do |symbol, j|
                    if symbol == nil
                        next
                    elsif symbol == "_"
                        next
                    else
                        img = @floortiles[symbol]
                        img.draw(j*@tilesize * @scale, i*@tilesize * @scale, 0, scale_x = @scale, scale_y = @scale)


                    end
                end
            end
        end
        
        
    end

end

# m = Map_drawer.new