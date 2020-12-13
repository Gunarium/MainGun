require 'dxopal'
include DXOpal
require_remote "enemy.rb"
require_remote "enemy2.rb"

class Enemies < Sprite
    attr_reader :enemies
    def initialize
        @enemies = []
        @enemies << Enemy.new(200 , 300 )
        @enemies << Enemy2.new(800 , 300)
        @enemies << Enemy.new(300 , 10 )
        
    end
    
    def update
        
        Sprite.update(@enemies)
        
        #Sprite.clean(@enemies)
        
        
    end
    
    def draw
        Sprite.draw(@enemies)
    end
end