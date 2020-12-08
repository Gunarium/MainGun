require 'dxopal'
include DXOpal
require_remote "player.rb"
require_remote "item.rb"
require_remote "items.rb"
require_remote "Tama.rb"
time=0
GROUND_Y = 800

Image.register(:scaffold, 'images/ashiba.png')
Image.register(:scaffold_long, 'images/ashiba_long.png')

Window.load_resources do
  
  # Windowサイズ設定
  Window.width  = 1540
  Window.height = 880
  
  player = Player.new
  tama=[]
  
  # Itemsクラスのオブジェクトを作る
  items = Items.new
  
  # 足場を配置
  scaffold_img = Image[:scaffold]
  scaffold_long_img = Image[:scaffold_long]
  
  scaffolds = []
  scaffolds << Sprite.new(0, 500, scaffold_img)
  scaffolds << Sprite.new(1240, 500, scaffold_img)
  scaffolds << Sprite.new(Window.width/2 - 250, 300, scaffold_long_img)
 
  Window.loop do
  
    player.update
    if time%15==0
      tama << Tama.new(player.x,player.y)
    end  
    Sprite.update(tama)
    
    # アイテムの作成・移動・削除
    items.update
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    
    Sprite.update(scaffolds)
    Sprite.draw(scaffolds)
    
    # 当たり判定
    Sprite.check(player, scaffolds)
    
    player.draw
    Sprite.draw(tama)
    # アイテムの描画
    items.draw
    time+=1
  end
end