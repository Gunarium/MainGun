require 'dxopal'
include DXOpal
Image.register(:Tama,'images/player.png')

class Tama<Sprite
  
  def initialize(x,y)
    @now_x=x
    @now_y=y
    @image = Image[:Tama]
    super(@now_x,@now_y,@image)
    if Input.mouse_pos_x>@now_x
        ddx=Input.mouse_pos_x-@now_x
        @tamahoukou=true
    else
        ddx = @now_x-Input.mouse_pos_x
        @tamahoukou=false
    end  
    
    ddy = Input.mouse_pos_y-@now_y
    @dx = Math.cos(Math.atan(ddy/ddx)).to_f
    @dy = Math.sin(Math.atan(ddy/ddx)).to_f  
  end
 
  
  def update
    if @tamahoukou == true
      self.x+=@dx*50
    else
      self.x-=@dx*50
    end  
    self.y+=@dy*50
    if self.x<0 or self.x>Window.width or  self.y<0 or self.y>Window.height
      self.vanish
    end  
  end  
  
  def shot
    self.vanish
  end
  
 
    
end  



