require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:apple, 'images/apple.png')
# アイテムを表すクラスを追加
class Item < Sprite
  def initialize
    image = Image[:apple]
    x = rand(Window.width - image.width)  # x座標をランダムに決める
    y = 0
    super(x, y, image)
    @speed_y = rand(9) + 4  # 落ちる速さをランダムに決める
  end

  def update
    self.y += @speed_y
    if self.y > Window.height
      self.vanish
    end
  end
end