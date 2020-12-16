require 'dxopal'
include DXOpal
Image.register(:Tama,'images/small.png')

class Bullet < Sprite
  
  def initialize(x,y)
    @now_x=x
    @now_y=y
    @image = Image[:Tama]
    @image.set_color_key([0, 0, 0])
    super(@now_x,@now_y,@image)
    @vec = rand(4)
  end
  
  def update
    
    if @vec == 0
      @y -= 10
      
      if @y < 0
        self.vanish
      end
      
    end
    
    if @vec == 1
      @y += 10
      
      if @y > 750
        self.vanish
      end
    end
    
    if @vec == 2
      @x -= 10
      
      if @x < 0
        self.vanish
      end
    end
    
    if @vec == 3
      @x += 10
      
      if @x > 1000
        self.vanish
      end
    end
    
    
    
  end
  
  def shot
    self.vanish
  end
end  