
require 'gosu'
require 'yaml'
require 'wisper'

d = Dir.glob("*.rb")
d.each do |dir|
    unless dir == "editor.rb"
        require_relative dir
    end
end


class Game < Gosu::Window
    attr_accessor :currently_editing

    def initialize
        width = 1920  
        height = 1080
        super width, height, fullscreen:true
        
        @tilesize = 32

        @camera = Camera.new(self)

        @tile_map = YAML.load(File.read("../maps/tilemaps/map.yaml")) 
        @object_map = YAML.load(File.read("../maps/objectmaps/map.yaml"))
        @map_drawer = Map_drawer.new(self, @tilesize)

        @object_generator = Object_generator.new(self, @tilesize)
        @player, @objects = @object_generator.generate(@object_map)

    end

    
    
    def update
        handle_inputs
        
        @player.update
        
        @objects.each {|obj| obj.update}
        @camera.update
        
    end
    
    def draw
        
        @objects.each {|obj| obj.draw(@camera)}
        
        @player.draw(@camera)
    end
    

    def handle_inputs
        
        if Gosu.button_down? Gosu::KB_W
            @player.facing_dir = "up"
        end
        if Gosu.button_down? Gosu::KB_A
            @player.facing_dir = "left"
        end
        if Gosu.button_down? Gosu::KB_S
            @player.facing_dir = "down"
        end
        if Gosu.button_down? Gosu::KB_D
            @player.facing_dir = "right"
        end
        
        if Gosu.button_down? Gosu::KB_W or Gosu.button_down? Gosu::KB_A or Gosu.button_down? Gosu::KB_S or Gosu.button_down? Gosu::KB_D
            @player.walk()
        end
        if Gosu.button_down? Gosu::KB_SPACE
            @player.attack()
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

if __FILE__==$0
    Game.new.show
end