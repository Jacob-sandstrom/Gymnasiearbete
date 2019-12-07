require_relative 'gameobject.rb'



class Player < Gameobject

    def initialize(window, x, y)
        super(window, x, y)

    end

    def walk(dir)
        case dir
        when "up"
            @animation_handler.switch_action(walk_up)
        when "down"
            @animation_handler.switch_action(walk_down)
        when "left"
            @animation_handler.switch_action(walk_left)
        when "right"
            @animation_handler.switch_action(walk_right)
        end
    end
    
    def attack(dir)
        case dir
        when "up"
            @animation_handler.switch_action(attack_up)
        when "down"
            @animation_handler.switch_action(attack_down)
        when "left"
            @animation_handler.switch_action(attack_left)
        when "right"
            @animation_handler.switch_action(attack_right)
        end

    end


    def update
        super
    end

    def draw(camera)
        super(camera)
    end

end