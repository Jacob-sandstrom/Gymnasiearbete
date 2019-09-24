require 'sqlite3'


class Data_reader


    def self.read 
        db = connect
        data = access_data(db)

        return data
    end

    def self.connect
        SQLite3::Database.new '../db/Tile_symbols.db'
    end

    def self.access_data(db)
        return db.execute('SeLecT * FrOm tiles')
    end


    

end

