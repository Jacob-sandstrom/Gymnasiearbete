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

if __FILE__==$0
    puts "Type CONFIRM to generate new map"
    input = gets.chomp

    if input == "confirm"
        map = Map_generator.generate_map(240,135)
    end
end

