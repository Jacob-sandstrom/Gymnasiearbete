

require 'gosu'
require 'yaml'
require 'wisper'

require_relative 'action_viewer'
require_relative 'data_reader'
require_relative 'hitbox_shower'
# require_relative '../gameobject'


class HitboxCreator < Gosu::Window
    attr_accessor :currently_editing

    def initialize
        width = 1920  
        height = 1080
        super width, height, fullscreen:true


        @filepath = "../../object data/player.yaml"

        
        @a = ActionViewer.new(@filepath)
        @hitbox_shower = Hitbox_shower.new(@a)


        @x_start = 0
        @y_start = 0
        @x_end = 0
        @y_end = 0

        @x = 0
        @y = 0

    end
    
    def needs_cursor?
        true
    end
    
    
    def create_hitbox(type)
        hitbox_data = {"type" => type, "bounds" => [@x_start, @y_start, @x_end - @x_start, @y_end - @y_start], "damage" => 0, "x_knockback" => 0, "y_knockback" => 0}
        @a.current_action.meta_data["frames"][@a.current_action.current_frame]["hitboxes"] << hitbox_data
        # p @a.current_action.meta_data["frames"][@a.current_action.current_frame]["hitboxes"]
    end
    
    def delete_last
        @a.current_action.meta_data["frames"][@a.current_action.current_frame]["hitboxes"].pop  #  .pop removes last elem in array
    end
    
    def save
        # p @a.actions
        # p "\n"
        # p "\n"
        # p "\n"
        # p @a.current_action.meta_data
        # p "\n"
        # p @a.actions.keys
        
        # @a.actions.keys.each do |key|
        #     @a.actions[key] = @a.action_players[key].meta_data
        # end
        # p @a.actions
        File.write(@filepath, @a.actions.to_yaml)
    end

    def update
        
        @a.update
        
        inputs
    end
    
    def draw
        
        if Gosu::button_down? Gosu::MS_LEFT
            draw_rect(@x_start, @y_start, mouse_x - @x_start, mouse_y - @y_start, Gosu::Color.argb(0x5f_00ff00))
        else
            draw_rect(@x_start, @y_start, @x_end - @x_start, @y_end - @y_start, Gosu::Color.argb(0x5f_00ff00))
        end
        @a.draw(@x, @y)
        @hitbox_shower.draw(self, @x, @y)
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end

        if id == Gosu::MS_LEFT
            @x_start = mouse_x
            @y_start = mouse_y
        end

        case id
        when Gosu::KB_LEFT
            @a.backward
        when Gosu::KB_RIGHT
            @a.forward
        when Gosu::KB_E
            @a.next_action
        when Gosu::KB_Q
            @a.prev_action
        when Gosu::KB_1
            create_hitbox("hittable")
        when Gosu::KB_2
            create_hitbox("attack")
        when Gosu::KB_BACKSPACE
            delete_last()
        when Gosu::KB_S 
            save
        end

    end

    def button_up(id)
        case id
        when Gosu::MS_LEFT
            @x_end = mouse_x
            @y_end = mouse_y
        end
    end

    def inputs 

   
    end

end


HitboxCreator.new.show