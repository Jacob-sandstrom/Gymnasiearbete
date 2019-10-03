require 'gosu'
require 'yaml'

require_relative 'gameobject.rb'
require_relative 'camera.rb'
require_relative 'map_drawer.rb'
require_relative 'map_writer.rb'
require_relative 'input_handler.rb'
require_relative 'tile_selector.rb'
require_relative 'data_reader.rb'





class Editor < Gosu::Window

    def initialize
        width = 1920  
        height = 1080
        super width, height, fullscreen:true
        
        @tilesize = 32

        @camera = Camera.new(self)

        @map = YAML.load(File.read("../maps/tilemaps/map.yaml")) 
        @map_writer = Map_writer.new(self, @tilesize, @camera, @map)
        @map_drawer = Map_drawer.new(self, @tilesize)

        @tile_selector = Tile_selector.new(self, @tilesize, "tiles", 2)
        @object_selector = Tile_selector.new(self, @tilesize, "objects", 1)

        @gameobject = Gameobject.new(self, 200,200)
    end

    def needs_cursor?
        true
    end


    def update
        @gameobject.update
        
        @tile_selector.update
        @object_selector.update
        @camera.update
        @map_drawer.update()
        @map_writer.update(@camera, @map, @tile_selector.selected_tile)
        

        
        Input_handler.handle_inputs(self, @camera, @map_writer, @tile_selector, @object_selector)
    end
    
    def draw
        @gameobject.draw(@camera)
        
        if @tile_selector.open
            @tile_selector.draw()
        elsif @object_selector.open
            @object_selector.draw()
        else
            @map_drawer.draw(@camera, @map)
        end
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