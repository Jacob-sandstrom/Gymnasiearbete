

class Camera
    attr_accessor :x, :y

    def initialize(window, x = 0, y = 0)
        @window = window
        @x = x
        @y = y

        @x_move = 0
        @y_move = 0

        @speed = 5
        
    end

    def move_up
        @y_move -= @speed
    end

    def move_down
        @y_move += @speed
    end
    
    def move_left
        @x_move -= @speed
    end
    
    def move_right
        @x_move += @speed
    end
    
    def update
        @x += @x_move
        @y += @y_move


        
        @x_move = 0
        @y_move = 0


    end

    def draw

    end
    
end