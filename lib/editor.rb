require 'gosu'
require 'yaml'

d = Dir.glob("*.rb")
d.each do |dir|
    unless dir == "editor.rb"
        require_relative dir
    end
end


class Editor < Gosu::Window
    attr_accessor :currently_editing

    def initialize
        width = 1920  
        height = 1080
        super width, height, fullscreen:true
        
        @tilesize = 32

        @camera = Camera.new(self)

        @tile_map = YAML.load(File.read("../maps/tilemaps/map.yaml")) 
        @object_map = YAML.load(File.read("../maps/objectmaps/map.yaml"))
        @map_writer = Map_writer.new(self, @tilesize, @camera, @tile_map)
        @map_drawer = Map_drawer.new(self, @tilesize)
        @object_generator = Object_generator.new(self, @tilesize)
        @objects = @object_generator.generate(@object_map)
        
        @tile_selector = Tile_selector.new(self, @tilesize, "tiles", 2)
        @object_selector = Tile_selector.new(self, @tilesize, "objects", 1)
        
        @currently_editing = "tiles"
        
        
    end
    
    def needs_cursor?
        true
    end
    
    def reload_objects
        @objects = @object_generator.generate(@object_map)
    end


    def update_writer
        case @currently_editing
        when "tiles"
            @map_writer.update(@camera, @tile_map, @tile_selector.selected_tile)
        when "objects"
            @map_writer.update(@camera, @object_map, @object_selector.selected_tile)
        end
    end

    def update
        @objects.each {|obj| obj.update}
        p @object_map[0]

        
        @tile_selector.update
        @object_selector.update
        @camera.update
        @map_drawer.update()

        update_writer
        
        
        
        Input_handler.handle_inputs(self, @camera, @map_writer, @tile_selector, @object_selector)
    end
    
    def draw
        @objects.each {|obj| obj.draw(@camera)}
        
        if @tile_selector.open
            @tile_selector.draw()
        elsif @object_selector.open
            @object_selector.draw()
        else
            @map_drawer.draw(@camera, @tile_map)
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