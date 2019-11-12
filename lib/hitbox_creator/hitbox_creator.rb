

require 'gosu'
require 'yaml'
require 'wisper'

require_relative 'action_viewer'
require_relative 'data_reader'
# require_relative '../gameobject'


class HitboxCreator < Gosu::Window
    attr_accessor :currently_editing

    def initialize
        width = 1920  
        height = 1080
        super width, height, fullscreen:true
        
        # get_object_data
        @a = ActionViewer.new


        @x_start = 0
        @y_start = 0
        @x_end = 0
        @y_end = 0

    end
    
    def needs_cursor?
        true
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
        @a.draw(1000, 500)
    end

    def get_object_data
        data = Data_reader.read("objects")
        #   make array into dictionary
        @object_symbol_and_names = {}
        data.each_with_index do |dat, i|
            
            begin
                @object_symbol_and_names[dat[0]] = Object.const_get(dat[1]).new(@window, 0, 0)
            rescue
                @object_symbol_and_names[dat[0]] = Gameobject.new(@window, 0, 0, dat[1])
            ensure

            end
        end
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