require 'dxopal'
include DXOpal
Image.register(:player, 'images/player.png')

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
    @two = -1   # ジャンプ回数
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
    
    # 空中の処理
    if @two >= 0
      
      # 現在の位置を保存
      @y_temp = self.y
      
      # 移動
      self.y += (self.y - @y_prev) + 1
      
      # 天井
      if self.y < 0
        self.y = 0
      end
      
      # 床
      if self.y + Image[:player].height > GROUND_Y
        self.y = GROUND_Y - Image[:player].height
        @two = 0
      end
      
      # 移動前の位置
      @y_prev = @y_temp
      
    end
    
    # ジャンプボタン
    if Input.key_push?(K_W) && @two < 2
      if @two == -1
        @two = 1
      else
        @two += 1
      end
      @y_prev = self.y
      self.y -= 20
    end
  end
  
  def shot(o)
    if self.y <= @y_prev || self.y > o.y
      next
    else
      @y_prev = o.y - Image[:player].height
      self.y = o.y - Image[:player].height
      @two = 0
    end
  end
end