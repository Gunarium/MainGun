require 'dxopal'
include DXOpal

Image.register(:enemy, 'images/pen1.png')
Sound.register(:explosion, 'sounds/explosion.wav')
# アイテムを表すクラスを追加
class Enemy < Sprite
  attr_reader :x, :y ,:enemy_appear , :van, :vec
  def initialize(x,y)
    image = Image[:enemy]
    image.set_color_key([0, 0, 255])
    @x = x  # x座標をランダムに決める
    @y = y - Image[:enemy].height
    @vec = true #right=>True
    @enemy_appear = true
    @van = false
    @hit = 0
    super(@x, @y, image)
  end

  def update
    if @vec == true
      @x += 4
      if @x > 300 - Image[:enemy].width
        @vec = false
      end
    
    elsif @vec == false
      @x -= 4
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