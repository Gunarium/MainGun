require 'dxopal'
include DXOpal

Sound.register(:bgm, 'sounds/boss.wav')

class Bgm_boss
    #attr_reader :playsound
    def initialize
        #Sound[:gbm].play
        #@playsound =true
    end
    
    def play
        Sound[:bgm].play
        @playsound=false
    end
end
    