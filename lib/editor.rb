require_relative 'gameobject.rb'




class Editor

    def initialize
        
    end

    def update

    end

    def draw

    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end