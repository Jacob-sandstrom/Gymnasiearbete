require 'yaml'

class Map_generator

    def self.generate_map(tiles_wide, tiles_high)


        map = []

        tiles_wide.times do 
            column = []
            tiles_high.times do
                column << "_"

            end
            map << column

        end

        File.write("../maps/tilemaps/map.yaml", map)
        
        return map 
    end

end


map = Map_generator.generate_map(30,30)

p map