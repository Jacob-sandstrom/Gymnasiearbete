

class Map_writer

    def initialize(window, tilesize, camera, map, scale = 1)
        @window = window
        @tilesize = tilesize
        @camera = camera
        @map = map
        @scale = scale

        @map_width = @map[0].length * @tilesize * @scale
        @map_height = @map.length * @tilesize * @scale

        @selected_tile = "_"
    end

    def mouse_inside_map_bounds
        if @camera != nil
            @window.mouse_x + @camera.x > 0 && @window.mouse_x + @camera.x < @map_width && @window.mouse_y + @camera.y < @map_height && @window.mouse_y + @camera.y > 0
        else
            @window.mouse_x > 0 && @window.mouse_x < @map_width && @window.mouse_y < @map_height && @window.mouse_y > 0
        end
    end

    def get_tile_index
        if @camera != nil
            tile_index_x = 0
            mouse_location_x = @window.mouse_x + @camera.x
            while mouse_location_x > @tilesize * @scale
                tile_index_x += 1
                mouse_location_x -= @tilesize * @scale
            end
            tile_index_y = 0
            mouse_location_y = @window.mouse_y + @camera.y
            while mouse_location_y > @tilesize * @scale
                tile_index_y += 1
                mouse_location_y -= @tilesize * @scale
            end
        else
            tile_index_x = 0
            mouse_location_x = @window.mouse_x
            while mouse_location_x > @tilesize * @scale
                tile_index_x += 1
                mouse_location_x -= @tilesize * @scale
            end
            tile_index_y = 0
            mouse_location_y = @window.mouse_y
            while mouse_location_y > @tilesize * @scale
                tile_index_y += 1
                mouse_location_y -= @tilesize * @scale
            end
        end

        return tile_index_x, tile_index_y
    end

    def add_tile_to_map
        if mouse_inside_map_bounds
            tile_x, tile_y = get_tile_index 
            @map[tile_y][tile_x] = @selected_tile 
        end
    end
    
    def remove_tile_from_map
        if mouse_inside_map_bounds
            tile_x, tile_y = get_tile_index 
            @map[tile_y][tile_x] = "_"
        end
    end


    def update(camera, map, selected_tile)
        @camera = camera
        @map = map
        @selected_tile = selected_tile

    end

    def draw

    end


end