require 'dxopal'
include DXOpal

require_remote "player.rb"

Image.register(:lightning, 'images/thunder1.png')
Sound.register(:Raimei, 'sounds/Raimei.wav')

class Rizin 
    def initialize(x)
        @x = x
        @lightning_width=100
        $riz1 = nil
        $riz2 = nil
        @riz_ini_time = $time
        @riz_dr_fl1 = false
        @riz_dr_fl2 = false
        $riz_appear=false
        @cloud2 = false
        @x1 = nil
    end
    
    def fall(player)
        
        Window.draw_box_fill(@x-@lightning_width, 0, @x+@lightning_width, 50, [255, 255, 255])
        cloud = true
        
        if @cloud2
            Window.draw_box_fill(@x1-@lightning_width, 0, @x1+@lightning_width, 50, [255, 255, 255])
        end
        if @riz_dr_fl1
            $riz1.draw
        end
        if @riz_dr_fl2
            $riz2.draw
        end
            
        if $time - @riz_ini_time == 60*1.5
            $riz1 = Lightning.new(@x)
            $riz_appear=true
            $riz1.draw
            @riz_dr_fl1 = true
            @cloud2 = true
            @x1 = player.x
        
        elsif $time - @riz_ini_time == 60*2
            $riz1.lit_van
            @riz_dr_fl1 = false
        elsif $time - @riz_ini_time == 60*3
            $riz2 = Lightning.new(@x1)
            $riz2.draw
            @riz_dr_fl2 = true
        elsif $time - @riz_ini_time == 60*4
            $riz2.lit_van
            @riz_ini_time = 0
            cloud = false
            $riz_appear=false
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
        Sound[:Raimei].play
    end
    
    def lit_van
        self.vanish
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