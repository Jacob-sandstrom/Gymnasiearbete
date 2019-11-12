require 'yaml'
require_relative 'action.rb'

class ActionViewer
    attr_accessor :current_action, :allow_move, :x_move, :y_move

    def initialize(file = "../../object data/player.yaml")
        actions = YAML.load(File.read(file))
        

        action_list = []

        @action_players = {}
        actions.keys.each do |key|
            action_list << key
            @action_players[key] =  Action.new(actions[key])
        end

        # p actions[action_list[0]]

        begin
            @current_action = @action_players[action_list[0]]
        rescue
            @current_action = Action.new(nil)
            # print "action no exist"
        end

        @attack_queued = false
        @allow_move = true
        @x_move = 0
        @y_move = 0
    end

    def reset
        @current_action.reset
    end

    def update
        @current_action.update
        action_done
    end
    
    def draw(x, y)
        @current_action.draw(x, y)
    end

end
