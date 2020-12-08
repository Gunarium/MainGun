require 'dxopal'
include DXOpal
Image.register(:player, 'images/player.png')
GROUND_Y = 400
# プレイヤーを表すクラスを定義
class Player < Sprite
  attr_reader :x, :y
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image_left = Image[:player]
    image_left.set_color_key([255, 255, 255])
    #image_right = Image[:player_right]
    #image_right.set_color_key([255, 255, 255])
    super(x, y, image_left)
    @y_prev = 0
    @y_temp = 0
    @two = 0
  end
  
  # 移動処理(xからself.xになった)
  def update
    if Input.key_down?(K_A) && self.x > 0
      #image = image_left
      self.x -= 8
    elsif Input.key_down?(K_D) && self.x < (Window.width - Image[:player].width)
      #image = image_right
      self.x += 8
    end
    
    # ジャンプ
    if @two != 0
      # 現在の位置
      @y_temp = self.y
      
      # 落下
      self.y += (self.y - @y_prev) + 1
      
      # 落下後の位置
      @y_prev = @y_temp
      
      if self.y >= GROUND_Y - Image[:player].height
        @two = 0
        self.y = GROUND_Y - Image[:player].height
      end
    end
    if Input.key_push?(K_W) && @two != 2 
      @two += 1
      @y_prev = self.y
      self.y -= 20
    end
  end
end