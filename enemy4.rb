require 'dxopal'
include DXOpal

Image.register(:apple, 'images/apple.png')
Sound.register(:explosion, 'sounds/explosion.wav')
# アイテムを表すクラスを追加
class Enemy4 < Sprite
  attr_reader :x, :y ,:enemy_appear
  def initialize(x,y)
    image = Image[:apple]
    @x = x  # x座標をランダムに決める
    @y = y - Image[:apple].height
    @vec = true #right=>True
    @enemy_appear = true
    @hit = 0
    super(@x, @y, image)
  end

  def update
    if @vec == true
      @x += 4
      if @x > 780 - Image[:apple].width
        @vec = false
      end
    
    elsif @vec == false
      @x -= 4
      if @x < 230
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
      Sound[:explosion].play
    end
  end
end