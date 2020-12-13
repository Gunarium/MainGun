require 'dxopal'
include DXOpal

Image.register(:apple, 'images/apple.png')
Sound.register(:explosion, 'sounds/explosion.wav')
# アイテムを表すクラスを追加
class Enemy3 < Sprite
  attr_reader :x, :y ,:enemy_appear , :van
  def initialize(x , y)
    image = Image[:apple]
    @x = x
    @y = y - Image[:apple].height
    @vec = true #right=>True
    @enemy_appear = true
    @van = false
    @hit = 0
    super(@x, @y, image)
  end

  def update
    if @vec == true
      @x += 5
      if @x > 1000 - Image[:apple].width
        @vec = false
      end
    
    elsif @vec == false
      @x -= 5
      if @x < 0
        @vec = true
      end
      
    end
  end
  
  def hit
    if @hit < 5
      @hit += 1
    else
      self.vanish
      @enemy_appear = false
      @van = true
      Sound[:explosion].play
    end
  end
end