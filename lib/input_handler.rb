



class Input_handler

    def self.handle_inputs(window, camera, map_writer, tile_selector, object_selector)

        if !tile_selector.open || !object_selector.open    # Tile/object selector not open controls
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

            #   edit map
            if Gosu.button_down? Gosu::MS_LEFT
                map_writer.add_tile_to_map
            end
            if Gosu.button_down? Gosu::MS_RIGHT
                map_writer.remove_tile_from_map
            end
        else                    # Tile selector open controls
            #   select tile
            if Gosu.button_down? Gosu::MS_LEFT
                tile_selector.select_tile
            end
        end

        #   save
        if Gosu.button_down? Gosu::KB_LEFT_CONTROL and Gosu.button_down? Gosu::KB_S
            map_writer.save_map
        end

        
        #   open and close tile_selector
        if Gosu.button_down? Gosu::KB_T 
            tile_selector.open_tile_selector
            object_selector.close_tile_selector
        end
        if Gosu.button_down? Gosu::KB_R
            object_selector.open_tile_selector
            tile_selector.close_tile_selector
        end
        if Gosu.button_down? Gosu::KB_Y
            tile_selector.close_tile_selector
            object_selector.close_tile_selector
        end

    end

end
