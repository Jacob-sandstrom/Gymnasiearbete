require 'gosu'
require 'yaml'

require_relative 'gameobject.rb'
require_relative 'camera.rb'
require_relative 'map_drawer.rb'
require_relative 'map_writer.rb'
require_relative 'input_handler.rb'





class Editor < Gosu::Window

    def initialize
      width = 1920
      height = 1080
      super width, height, fullscreen:true
        

      @camera = Camera.new(self)

      @map = YAML.load(File.read("../maps/tilemaps/map.yaml")) 
      @map_writer = Map_writer.new(self, 32, @camera, @map)
      @map_drawer = Map_drawer.new(self, 32)
    end

    def needs_cursor?
        true
    end


    def update
        @camera.update
        @map_writer.update(@camera, @map)
        
        Input_handler.handle_inputs(self, @camera, @map_writer)
    end

    def draw

        @map_drawer.draw(@camera, @map)
    end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
          close
        else
          super
        end
    end

end


Editor.new.show