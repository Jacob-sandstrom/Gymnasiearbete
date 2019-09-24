


class Tile_selector
    attr_accessor :open, :selected_tile

    def initialize(window, tilesize)
        @window = window
        @tilesize = tilesize
        @open = false
        @selected_tile = "_"

        @map = YAML.load(File.read("../selectormaps/tiles.yaml")) 
        @data = Data_reader.read

        @tile_drawer = Map_drawer.new(@window, @tilesize)
        @tile_index_locator = Map_writer.new(@window, @tilesize, nil, @map)
    end

    def open_tile_selector
        @open = true
    end

    def close_tile_selector
        @open = false
    end

    def select_tile
        if @tile_index_locator.mouse_inside_map_bounds
            tile_x, tile_y = @tile_index_locator.get_tile_index
            @selected_tile = @map[tile_y][tile_x] 
        end
    end

    def update

    end

    def draw

        if @open

            @tile_drawer.draw(nil, @map)

        end

    end

end

