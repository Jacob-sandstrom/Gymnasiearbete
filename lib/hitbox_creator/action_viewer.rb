require 'yaml'
require_relative 'action.rb'

class ActionViewer
    attr_accessor :current_action, :allow_move, :x_move, :y_move, :action_players, :action_list, :current_action_index, :actions

    def initialize(file = "../../object data/player.yaml")
        @actions = YAML.load(File.read(file))
        

        @action_list = []

        @action_players = {}
        @actions.keys.each do |key|
            @action_list << key
            @action_players[key] = Action.new(@actions[key])
        end

        @current_action_index = 0
        # p actions[action_list[0]]

        begin
            @current_action = @action_players[@action_list[0]]
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
    
    def next_action
        # p @action_list.length
        unless @current_action_index >= @action_list.length - 1
            @current_action_index += 1
        end
        @current_action = @action_players[@action_list[@current_action_index]]
    end
    def prev_action
        unless @current_action_index <= 0
            @current_action_index -= 1
        end
        @current_action = @action_players[@action_list[@current_action_index]]
    end

    def forward
        @current_action.forward
    end
    
    def backward
        @current_action.backward
    end


    def update
        @current_action.update
    end
    
    def draw(x, y)
        @current_action.draw(x, y)
    end

end
