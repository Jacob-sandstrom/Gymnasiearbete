require 'yaml'

class Map_generator

    def self.generate_map(tiles_wide, tiles_high)


        map = []

        tiles_high.times do
            column = []
            tiles_wide.times do 
            column << "_"

            end
            map << column

        end

        File.write("../maps/tilemaps/map.yaml", map)
        
        return map 
    end

end


map = Map_generator.generate_map(240,135)

