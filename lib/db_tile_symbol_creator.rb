require 'sqlite3'
require_relative 'tile_selector_map_gen.rb'


class Db_tiles

    def self.seed!
        db = connect
        populate_tables(db)
        generate_map
    end

    def self.connect
        SQLite3::Database.new '../db/symbols.db'
    end

    def self.get_existing_tiles(db)
        existing_tiles = db.execute("select name from tiles")
        return existing_tiles
        
    end
    
    def self.populate_tables(db)
        existing_tiles = get_existing_tiles(db)
        tile_names = Dir.glob("../img/tiles/*.png")
    
        tile_names.each_with_index do |_, i|
            tile_names[i].slice!("../img/tiles/")
            tile_names[i].slice!(".png")
        end
        

        # p tile_names
        existing_tiles.each do |existing|
            # p existing[0]
            if tile_names.include? existing[0]
                tile_names.delete(existing[0])
            end

        end

        symbols = File.read("../maps/symbols.txt")
        existing_tiles.each do 
            symbols[0] = ""
        end
        
        tile_names.each_with_index do |tile, i|

            db.execute("insert into tiles (symbol, name) values(?,?)", symbols[i], tile)
        end
        
    end

    def self.generate_map
        Tile_selector_map_gen.generate_map(30, 17)
    end


end


Db_tiles.seed!