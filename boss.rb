require 'dxopal'
include DXOpal
Image.register(:Tama,'images/player.png')

class Boss < Sprite
    
    def initialize
        
        @x_list = [300 , 500 , 700]
        @y_list = [100 ,300 ,500]
    
        @x = @x_list.sample
        @y = @y_list.sample
        image = Image[:Tama]
        
        super(@x , @y ,image)
        
    end
    
    def update
        if $time % 60 == 0
            @x = @x_list.sample
            @y = @y_list.sample
        end
        
    end
    
end