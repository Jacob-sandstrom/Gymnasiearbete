

class Map_writer

    def initialize(window, tilesize, camera, map)
        @window = window
        @camera = camera
        @map = map

        @map_width = @map[0].length
        @map_height = @map.length

    end

    def add_tile_to_map
        
        

    end

    def remove_tile_from_map
        
    end


    def update(camera, map)
        @camera = camera
        @map = map

    end

    def draw

    end


end