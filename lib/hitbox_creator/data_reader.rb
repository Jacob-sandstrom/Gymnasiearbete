require 'sqlite3'


class Data_reader


    def self.read(name = "tiles")
        db = connect
        data = access_data(db, name)

        return data
    end

    def self.connect
        SQLite3::Database.new '../../db/symbols.db'
    end

    def self.access_data(db, name)
        return db.execute("SeLecT * FrOm #{name}")
    end


    

end

