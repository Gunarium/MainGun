require 'dxopal'
include DXOpal
require_remote "enemy.rb"
require_remote "enemy2.rb"
require_remote "enemy3.rb"
require_remote "enemy4.rb"

Image.register(:scaffold, 'images/ashiba.png')
Image.register(:scaffold_long, 'images/ashiba_long.png')

class Enemies < Sprite
    attr_reader :enemies , :wave
    def initialize
        @enemies = []
        @enemies << Enemy.new(Image[:scaffold].width / 2 , (1400/3).to_i )
        @enemies << Enemy2.new(850 , (1400/3).to_i)
        #@enemies << Enemy.new( Image[:scaffold_long].width / 2, (700 /3).to_i )
        @enemies << Enemy3.new(0 , 700 )
        @enemies << Enemy3.new(700 , 700 )
        @enemies << Enemy4.new(500 , (700 / 3).to_i )
        
    end
    
    def update
        
        Sprite.update(@enemies)
        
        #Sprite.clean(@enemies)
        count = 0
        for i in 0..4
            if @enemies[i].van == true
                count += 1
            end
        end
        
        if count == 5
            @wave = true
            count = 0
            
        end
        
        
    end
    
    def draw
        Sprite.draw(@enemies)
    end
end