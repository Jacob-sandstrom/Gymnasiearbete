require_relative 'gameobject.rb'



class Player < Gameobject

    def initialize(window, x, y)
        super(window, x, y)
        

    end

    def walk
        case @facing_dir
        when "up"
            @action_handler.switch_action("walk_up")
        when "down"
            @action_handler.switch_action("walk_down")
        when "left"
            @action_handler.switch_action("walk_left")
        when "right"
            @action_handler.switch_action("walk_right")
        end
    end
    
    def attack
        case @facing_dir
        when "up"
            @action_handler.switch_action("attack_up_first")
        when "down"
            @action_handler.switch_action("attack_down_first")
        when "left"
            @action_handler.switch_action("attack_left_first")
        when "right"
            @action_handler.switch_action("attack_right_first")
        end

    end


    def update
        super
    end

    def draw(camera)
        super(camera)
    end

end
