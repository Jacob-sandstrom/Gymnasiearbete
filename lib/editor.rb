require 'gosu'
require_relative 'gameobject.rb'
require_relative 'cameraman.rb'
require_relative 'camera.rb'




class Editor < Gosu::Window

    def initialize
      width = 1920
      height = 1080
      super width, height, fullscreen:true
        

      @cameraman = Cameraman.new(self)
      @camera = Camera.new(self, @cameraman)
    end


    def update
      @cameraman.update
      @camera.update(@cameraman)
      

    end

    def draw

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