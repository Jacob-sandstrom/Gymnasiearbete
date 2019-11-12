require 'yaml'

class Action
    attr_accessor :current_frame, :meta_data, :number_of_frames
    def initialize(meta_data)
        begin
            @meta_data = meta_data
            @spritesheet_path = "../../img/spritesheets/player/"

            begin  
                spritesheet = @spritesheet_path + meta_data["spritesheet"]
                img_width = @meta_data["size"][0]
                img_height = @meta_data["size"][1]
                # p spritesheet
                @animation_frames = Gosu::Image.load_tiles(spritesheet, img_width, img_height, tileable: true)
            rescue 
                # puts "Error: Unable to load animation #{@meta_data["name"]}"
            end
            
            @number_of_frames = @meta_data["frames"].length
            @current_frame = 0
            @frames_delayed = 0
            @x_offset, @y_offset = @meta_data["offset"]
        rescue
            # puts "Error: Unable to initialize #{meta_data["name"]}"
        end
    end
    
    def reset
        @current_frame = 0
        @frames_delayed = 0
    end

    def forward
        unless @current_frame >= @number_of_frames
            @current_frame += 1
        end
    end
    
    def backward
        unless @current_frame <= 0
            @current_frame -= 1
        end
    end

    def update
        
    end
    
    def draw(x, y)
        begin  
            @animation_frames[@current_frame].draw(x + @x_offset, y + @y_offset, 10)      
        rescue
        end
    end


end
