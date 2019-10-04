require 'sqlite3'
require_relative 'tile_selector_map_gen.rb'


class Db_objects

    def self.seed!
        db = connect
        populate_tables(db)
        generate_map
    end

    def self.connect
        SQLite3::Database.new '../db/symbols.db'
    end

    def self.get_existing_objects(db)
        existing_objects = db.execute("select name from objects")
        return existing_objects
        
    end
    
    def self.populate_tables(db)
        existing_objects = get_existing_objects(db)
        object_names = Dir.glob("../object data/*.yaml")
    
        object_names.each_with_index do |_, i|
            object_names[i].slice!("../object data/")
            object_names[i].slice!(".yaml")
        end
        

        # p object_names
        existing_objects.each do |existing|
            # p existing[0]
            if object_names.include? existing[0]
                object_names.delete(existing[0])
            end

        end

        symbols = File.read("../maps/symbols.txt")
        existing_objects.each do 
            symbols[0] = ""
        end
        
        object_names.each_with_index do |object, i|

            db.execute("insert into objects (symbol, name) values(?,?)", symbols[i], object)
        end
        
    end

    def self.generate_map
        Tile_selector_map_gen.generate_map(30, 17, "objects")
    end


end

Db_objects.seed!