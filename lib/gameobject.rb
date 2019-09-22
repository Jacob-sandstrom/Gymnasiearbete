



class Gameobject

    def initialize(window, camera, x, y)
        @window = window
        @x = x
        @y = y



    end

    def update

    end

    def draw

    end
    
end


class Dynamic_gameobject < Gameobject

    def initialize(window, camera, x, y)
        super(window, camera, x, y)


        @x_move = 0
        @y_move = 0

    end

    def update

    end

    def draw

    end

end