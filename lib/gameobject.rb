require_relative 'action_handler'



class Gameobject
    attr_accessor :x, :y

    def initialize(window, x, y, data_name = "player")
        @window = window
        @x = x
        @y = y

        @x_move = 0
        @y_move = 0

        @action_handler = Action_handler.new("../object data/#{data_name}.yaml")

    end

    def action_move
        @x_move += @action_handler.x_move
        @y_move += @action_handler.y_move
    end
    

    def update
        @action_handler.update

    end

    def draw(camera)
        @action_handler.draw(@x - camera.x, @y - camera.y)

    end
    
end


class Dynamic_gameobject < Gameobject

    def initialize(window, x, y)
        super(window, x, y)


        @x_move = 0
        @y_move = 0

    end

    def update

    end

    def draw

    end

end