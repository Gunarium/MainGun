require 'dxopal'
include DXOpal

Sound.register(:bgm_boss, 'sounds/boss.WAV')

class Bgm_boss
    #attr_reader :playsound
    def initialize
        #Sound[:gbm].play
        #@playsound =true
    end
    
    def play
        Sound[:bgm_boss].play
        @playsound=false
    end
end
    