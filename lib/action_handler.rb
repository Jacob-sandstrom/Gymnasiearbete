require 'yaml'
require_relative 'action_player.rb'
require_relative 'animation_player.rb'

class Action_handler
    attr_accessor :current_action, :allow_move, :x_move, :y_move

    def initialize(file = "../object data/player.yaml")
        actions = YAML.load(File.read(file))

        @action_players = {}
        @animation_players = {}
        actions.keys.each do |key|
            @action_players[key] =  Action_player.new(actions[key])
            @animation_players[key] =  Animation_player.new(actions[key])
        end
        begin
            @current_action = @action_players["idle"]
            @current_animation = @animation_players["idle"]
        rescue
            @current_action = Action_player.new(nil)
            @current_animation = Animation_player.new(nil)
            # print "action no exist"
        end

        @attack_queued = false
        @allow_move = true
        @x_move = 0
        @y_move = 0
    end

    def reset
        @current_action.reset
        @current_animation.reset
    end

    def queue_action
        if current_frame["queue_combo"] == true
            @current_action.queue_attack = true
            @attack_queued = true
        end

    end

    def switch_action(action)
        action_changed = false
        data = @current_action.meta_data
        current_frame = data["frames"][@current_action.current_frame]

        if current_frame["interruptible"] == true
            @current_action = @action_players[action]
            @current_animation = @animation_players[action]
            action_changed = true
        end
        
        if action_changed
            reset
        end
    end

    def switch_to_queued
        if @attack_queued
            data = @current_action.meta_data
            current_frame = data["frames"][@current_action.current_frame]

            if current_frame["execute_combo"] == true && @current_action.queue_attack
                @current_action = @action_players[@current_action["combo"]]
                @attack_queued = false
                reset
            end
            
        end
    end

    def action_done
        if @current_action.current_frame >= @current_action.number_of_frames 
            if @current_action.meta_data["loop"] == true
                reset
            else
                @current_action = @action_players["idle"]
                @current_animation = @animation_players["idle"]
            end
        end


    end

    def update
        switch_to_queued
        @current_action.update
        @current_animation.update
        action_done
        @allow_move = @current_action.meta_data["allow_movement"]
        @x_move = @current_action.meta_data["frames"][@current_action.current_frame]["x_movement"]
        @y_move = @current_action.meta_data["frames"][@current_action.current_frame]["y_movement"]
    end
    
    def draw(x, y)
        @current_animation.draw(x, y)
    end

end

# Action_handler.new