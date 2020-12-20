require 'dxopal'
include DXOpal

require_remote "player.rb"

Image.register(:lightning, 'images/thunder1.png')


class Rizin 
    def initialize(x)
        @x = x
        @lightning_width=100
        $riz = nil
        @riz_ini_time = $time
        @riz_dr_fl = false
        $riz_appear=false
    end
    
    def fall
        
        Window.draw_box_fill(@x-@lightning_width, 0, @x+@lightning_width, 50, [255, 255, 255])
        cloud = true
        
        if @riz_dr_fl
            $riz.draw
        end
            
        if $time - @riz_ini_time == 60*3
            $riz = Lightning.new(@x)
            $riz_appear=true
            $riz.draw
            @riz_dr_fl = true
            
        elsif $time - @riz_ini_time == 60*4
            $riz.lit_van
            @riz_ini_time = 0
            cloud = false
        end
        
        return cloud
    end
end

class Lightning < Sprite
    def initialize(x)
        image = Image[:lightning]
        @x = x - Image[:lightning].width/2
        @y = 0
        super(@x, y, image)
    end
    
    def lit_van
        self.vanish
        $riz_appear=false
    end
end
'''
require_remote "rizin.rb"
$rizin = nil
      if $time % 360 == 0 
        $rizin = Rizin.new(player.x)
        cloud = true
      end
Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
      if cloud
        cloud = $rizin.fall
      end
      Sprite.draw(scaffolds)
'''