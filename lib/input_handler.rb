require 'wisper'



class Input_handler
    include Wisper::Publisher

    def self.handle_inputs(window, camera, map_writer, tile_selector, object_selector)

        if !tile_selector.open && !object_selector.open     # Tile/object selector not open controls
            #   move camera
            if Gosu.button_down? Gosu::KB_W 
                camera.move_up
            end
            if Gosu.button_down? Gosu::KB_S and !Gosu.button_down? Gosu::KB_LEFT_CONTROL
                camera.move_down
            end
            if Gosu.button_down? Gosu::KB_A
                camera.move_left
            end
            if Gosu.button_down? Gosu::KB_D
                camera.move_right
            end

            if window.currently_editing == "tiles"
                #   edit tilemap
                if Gosu.button_down? Gosu::MS_LEFT
                    map_writer.add_tile_to_map
                end
                if Gosu.button_down? Gosu::MS_RIGHT
                    map_writer.remove_tile_from_map
                end
            elsif window.currently_editing = "objects"                
                if Gosu.button_down? Gosu::MS_LEFT
                    map_writer.add_tile_to_map
                    window.reload_objects
                end
                if Gosu.button_down? Gosu::MS_RIGHT
                    map_writer.remove_tile_from_map
                    # window.hello
                    # broadcast(:hello)
                end
            end


        elsif tile_selector.open                            # Tile selector open controls
            #   select tile
            if Gosu.button_down? Gosu::MS_LEFT
                tile_selector.select_tile
            end
            
        elsif object_selector.open                          # object selector controls
            
            if Gosu.button_down? Gosu::MS_LEFT
                object_selector.select_tile
            end


        end

        #   save
        if Gosu.button_down? Gosu::KB_LEFT_CONTROL and Gosu.button_down? Gosu::KB_S
            window.save_map
        end

        
        #   open and close tile_selector
        if Gosu.button_down? Gosu::KB_T 
            tile_selector.open_tile_selector
            object_selector.close_tile_selector
            window.currently_editing = "tiles"
        end
        if Gosu.button_down? Gosu::KB_R
            object_selector.open_tile_selector
            tile_selector.close_tile_selector
            window.currently_editing = "objects"
        end
        if Gosu.button_down? Gosu::KB_Y
            tile_selector.close_tile_selector
            object_selector.close_tile_selector
        end

    end

end
