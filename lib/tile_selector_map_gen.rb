require_relative 'data_reader.rb'

class Tile_selector_map_gen

    def self.generate_map(tiles_wide = 60, tiles_high = 34, name = "tiles")

        data = Data_reader.read(name)

        map = []

        brea_k = false
        tiles_high.times do |i|
            row = []
            tiles_wide.times do |j|
                begin
                    row << data[i * tiles_wide + j][0]
                rescue
                    brea_k = true
                    break
                end

            end
            map << row
            if brea_k
                break
            end

        end

        File.write("../selectormaps/#{name}.yaml", map)
        
        return map 
    end


end

if __FILE__==$0
    Tile_selector_map_gen.generate_map

end