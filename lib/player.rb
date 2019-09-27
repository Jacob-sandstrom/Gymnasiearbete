require_relative 'gameobject.rb'



class Player < Gameobject

    def initialize(window, x, y)
        super(window, x, y)

    end

    def update
        super
    end

    def draw(camera)
        super(camera)
    end

end