

class Data_reader



    def self.connect
        SQLite3::Database.new '../db/Tile_symbols.db'
    end

    def self.access_data


    end


    

end