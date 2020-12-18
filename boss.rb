require 'dxopal'
include DXOpal
require_remote "rizin.rb"
require_remote "target.rb"

Image.register(:Tama,'images/player.png')


class Boss < Sprite
    attr_reader :attack 
    attr_accessor :x ,:y
    def initialize
        @x_list = [300 , 500 , 700]
        @y_list = [100 ,300 ,500]
        
        $x_re=300
        $y_re=100
        @x = @x_list.sample
        @y = @y_list.sample
        @attack = false
        image = Image[:Tama]
        @i = nil
        $idou = true
        
        
        super(@x , @y ,image)
        @action = Action.new
        
    end
    
    
    def update
        if $cloud
            $cloud = $rizin.fall
            if $cloud == false
                @attack = false
                $idou = true
            end
            
        elsif $nerau
            if $time % rand(10..20) == 0
                $target << Target.new($x_re,$y_re)
            end
            Sprite.check($target,$scaffolds)
            Sprite.update($target)
            Sprite.draw($target)
              
            if $ssss >= 10
                $ssss = 0
                $nerau = false
                @attack = false
                $idou = true
                $target.clear
                    
            end    
        end
        @x = $x_re
        @y = $y_re
        @attack = @action.act(rand(0..1),@attack)
    end
end

class Action 
    #attr_accessor :x ,:y
    X_list = [300 , 500 , 700]
    Y_list = [100 ,300 ,500]
    def initialize
        @count = 0   
    end     
    def act(i,attack)
        
        if attack == false and $idou == true
            if @count >=4 and $time % 60 == 0 
                @count += 1
                if @count == 6
                    $idou = false
                    @count = 0
                end
                
                
           
            elsif $time % 60 == 0 
                $x_re = X_list.sample
                $y_re = Y_list.sample
                @count+=1
            end
           
        elsif attack == false
            if i == 0
                $rizin = Rizin.new($player_x)
                $cloud = true
                attack = true
            
            elsif i== 1
                $nerau = true
                attack = true
                
            end
        end
        
        return attack
    end

end