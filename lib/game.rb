
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
        @objects = @object_generator.generate(@object_map)

        @player = Player.new(self, 400, 400)
    end


    def handle_inputs

    end


    def update
        handle_inputs
            
        @player.update
        
        @objects.each {|obj| obj.update}
        @camera.update
        
    end
    
    def draw

        @player.draw(@camera)

        @objects.each {|obj| obj.draw(@camera)}

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