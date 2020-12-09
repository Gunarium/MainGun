require 'dxopal'
include DXOpal
Image.register(:Tama,'images/player.png')

class Bullet < Sprite
  
  def initialize(x,y)
    @now_x=x
    @now_y=y
    @image = Image[:Tama]
    super(@now_x,@now_y,@image)
  end
  
  def update
      @y -= 10
      
      if @y < 0
        self.vanish
      end
  end
  
end  