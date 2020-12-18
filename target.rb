require 'dxopal'
include DXOpal
Image.register(:Target,'images/apple.png')

class Target < Sprite
    def initialize(x,y)
        @x=x
        @y=y
        super(@x,@y,Image[:Target])
        @count=0
        @now_time=$time
    end
    
    def kousinn(x,y)
        @player_x=x
        @player_y=y
    end
    
    def update
    
        if $player_x>@x
            ddx=$player_x-@x
            @tamahoukou=true
        else
            ddx = @x-$player_x
            @tamahoukou=false
        end  
    
        ddy = $player_y-@y
        @dx = Math.cos(Math.atan(ddy/ddx)).to_f
        @dy = Math.sin(Math.atan(ddy/ddx)).to_f  
        if @tamahoukou == true
            self.x+=@dx*3
        else
            self.x-=@dx*3
        end  
        self.y+=@dy*3
        if self.x<0 or self.x>Window.width or  self.y<0 or self.y>Window.height
            self.vanish
        end  
    end
    
    def shot
        @count+=1
        if @count==1
            @now_time=$time
        elsif @count>=2 and ($time-@now_time)>=120
            self.vanish
            $ssss+=1
        end   
    end    
        
end    