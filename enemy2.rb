require 'dxopal'
include DXOpal

Image.register(:apple, 'images/apple.png')
Sound.register(:explosion, 'sounds/explosion.wav')
# アイテムを表すクラスを追加
class Enemy2 < Sprite
  attr_reader :x, :y ,:enemy_appear
  def initialize(x , y)
    image = Image[:apple]
    @x = x 
    @y = y
    @vec = true #right=>True
    @enemy_appear = true
    super(@x, @y, image)
  end

  def update
    if @vec == true
      @y += 4
      if @y > 400
        @vec = false
      end
    
    elsif @vec == false
      @y -= 4
      if @y < 200
        @vec = true
      end
      
    end
  end
  
  def hit
    self.vanish
    @enemy_appear = false
    Sound[:explosion].play
  end
end