require 'dxopal'
include DXOpal

Image.register(:apple, 'images/apple.png')
Sound.register(:explosion, 'sounds/explosion.wav')
# アイテムを表すクラスを追加
class Enemy < Sprite
  attr_reader :x, :y ,:enemy_appear
  def initialize
    image = Image[:apple]
    @x = 200  # x座標をランダムに決める
    @y = 400
    @vec = true #right=>True
    @enemy_appear = true
    super(@x, @y, image)
  end

  def update
    if @vec == true
      @x += 4
      if @x > 300
        @vec = false
      end
    
    elsif @vec == false
      @x -= 4
      if @x < 100
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