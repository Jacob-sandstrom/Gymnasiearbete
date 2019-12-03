
require 'gosu'
require 'yaml'
require 'wisper'

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
        @map_drawer = Map_drawer.new(self, @tilesize)
    end


    def update

    end

    def draw

    end



end

