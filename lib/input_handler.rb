



class Input_handler

    def self.handle_inputs(window, camera, map_writer)

        if Gosu.button_down? Gosu::KB_W 
            camera.move_up
        end
        if Gosu.button_down? Gosu::KB_S
            camera.move_down
        end
        if Gosu.button_down? Gosu::KB_A
            camera.move_left
        end
        if Gosu.button_down? Gosu::KB_D
            camera.move_right
        end

        if Gosu.button_down? Gosu::MS_LEFT
            map_writer.add_tile_to_map
        end
        if Gosu.button_down? Gosu::MS_RIGHT
            map_writer.remove_tile_from_map
        end


    end

end
