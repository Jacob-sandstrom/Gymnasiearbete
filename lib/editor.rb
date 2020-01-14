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
        @map_writer = Map_writer.new(self, @tilesize, @camera, @tile_map)
        @map_drawer = Map_drawer.new(self, @tilesize)
        @object_generator = Object_generator.new(self, @tilesize)
        @player, @objects = @object_generator.generate(@object_map)
        
        @tile_selector = Tile_selector.new(self, @tilesize, "tiles", 2)
        @object_selector = Tile_selector.new(self, 64, "objects", 1)
        
        @currently_editing = "tiles"
        
        Input_handler.subscribe(self)
        get_object_data

        p @player
    end
    
    def needs_cursor?
        true
    end

    def save_map
        File.write("../maps/tilemaps/map.yaml", @tile_map)
        File.write("../maps/objectmaps/map.yaml", @object_map)
    end
    
    def reload_objects
        @player, @objects = @object_generator.generate(@object_map)
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
        # p @object_map[0]
        # p @currently_editing
        # p @object_selector.selected_tile
        
        @tile_selector.update
        @object_selector.update
        @camera.update
        @map_drawer.update()

        update_writer
        
        
        
        # Input_handler.handle_inputs(self, @camera, @map_writer, @tile_selector, @object_selector)
        inputs
    end
    
    def draw
        
        if @tile_selector.open
            @tile_selector.draw()
        elsif @object_selector.open
            @object_selector.draw()
        else
            @objects.each {|obj| obj.draw(@camera)}
            @map_drawer.draw(@camera, @tile_map)
        end
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
            if @currently_editing == "objects"  && (!@tile_selector.open && !@object_selector.open)
                
                @map_writer.add_tile_to_map
                tile_x, tile_y = @map_writer.get_tile_index 
                symbol = @object_map[tile_y][tile_x]
                                    
                
                if symbol != "_"
                    obj = @object_symbol_and_names[symbol]
                    success = false
                    begin
                        object = obj.dup
                        object.x = tile_x*@tilesize
                        object.y = tile_y*@tilesize
                        @objects << object
                        success = true
                    ensure
                        if !success
                            puts "Error: Unable to create object #{obj}"
                        end
                        
                    end
                end

               
            end
        end

    end

    def inputs 

        if !@tile_selector.open && !@object_selector.open     # Tile/object selector not open controls
            #   move @camera
            if Gosu.button_down? Gosu::KB_W 
                @camera.move_up
            end
            if Gosu.button_down? Gosu::KB_S and !Gosu.button_down? Gosu::KB_LEFT_CONTROL
                @camera.move_down
            end
            if Gosu.button_down? Gosu::KB_A
                @camera.move_left
            end
            if Gosu.button_down? Gosu::KB_D
                @camera.move_right
            end

            if self.currently_editing == "tiles"
                #   edit tilemap
                if Gosu.button_down? Gosu::MS_LEFT
                    @map_writer.add_tile_to_map
                end
                if Gosu.button_down? Gosu::MS_RIGHT
                    @map_writer.remove_tile_from_map
                end
            elsif self.currently_editing = "objects"                

                if Gosu.button_down? Gosu::MS_RIGHT
                    @map_writer.remove_tile_from_map
                    # self.hello
                    # broadcast(:hello)
                end
            end


        elsif @tile_selector.open                            # Tile selector open controls
            #   select tile
            if Gosu.button_down? Gosu::MS_LEFT
                @tile_selector.select_tile
            end
            
        elsif @object_selector.open                          # object selector controls
            
            if Gosu.button_down? Gosu::MS_LEFT
                @object_selector.select_tile
            end


        end

        #   save
        if Gosu.button_down? Gosu::KB_LEFT_CONTROL and Gosu.button_down? Gosu::KB_S
            self.save_map
        end

        
        #   open and close @tile_selector
        if Gosu.button_down? Gosu::KB_T 
            @tile_selector.open_tile_selector
            @object_selector.close_tile_selector
            self.currently_editing = "tiles"
        end
        if Gosu.button_down? Gosu::KB_R
            @object_selector.open_tile_selector
            @tile_selector.close_tile_selector
            self.currently_editing = "objects"
        end
        if Gosu.button_down? Gosu::KB_Y
            @tile_selector.close_tile_selector
            @object_selector.close_tile_selector
        end

    end

end

if __FILE__==$0
    Editor.new.show
end