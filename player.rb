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
    image_left.set_color_key([0, 0, 255])
    super(x, y, image_left)
    @y_prev = 0
    @y_temp = 0
    @two = -1   # ジャンプ回数
    @now_time = 0
  end
  
  # 移動処理(xからself.xになった)
  def update
    if Input.key_down?(K_A) && self.x > 0
      self.x -= 6
    elsif Input.key_down?(K_D) && self.x < (Window.width - Image[:player].width)
      self.x += 6
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
      self.y -= 16
    end
  end
  
  def shot(o)
    if self.y <= @y_prev || self.y + Image[:player].height - 30 > o.y || Input.key_down?(K_S)
      next
    else
      @y_prev = o.y - Image[:player].height
      self.y = o.y - Image[:player].height
      @two = 0
    end
  end
  
  def hit
    #$hearts.pop()
    
    if $time-@now_time > 60
      $hearts.pop()
      @now_time = $time
    end
    
  end
end