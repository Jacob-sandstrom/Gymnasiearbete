require 'yaml'

class Animation_player
    attr_accessor :current_frame, :meta_data
    def initialize(meta_data)
        begin
            @meta_data = meta_data

            @spritesheet_path = "../img/spritesheets/player/"

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

    def update
        begin
            if @frames_delayed < @meta_data["frames"][@current_frame]["display_time"]
                @frames_delayed += 1
            else
                @current_frame += 1
                @frames_delayed = 0
            end
        rescue
        end
    end
    
    def draw(x, y)
        begin               
            @animation_frames[@current_frame].draw(x + @x_offset, y + @y_offset, 10)      
        rescue
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

    data = YAML.load(File.read("../animations/player animations/player_animations.yaml"))
    meta_data = data["attack_down_first"]
    sprite = meta_data["spritesheet"]
    
    p data.keys
    
    Animation_player.new(100, -100, 10, meta_data).show
end
