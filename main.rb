require 'dxopal'
include DXOpal
require_remote "player.rb"
require_remote "Tama.rb"
require_remote "bullet.rb"
require_remote "enemy.rb"

time=0

GROUND_Y = 800

Image.register(:scaffold, 'images/ashiba.png')
Image.register(:scaffold_long, 'images/ashiba_long.png')
Image.register(:floor, 'images/floor.png')

Window.load_resources do
  
  # Windowサイズ設定
  Window.width  = 1540
  Window.height = 880
  
  player = Player.new
  enemy = Enemy.new
  tama=[]
  bullet = []
  
  
  
  # 足場を配置
  scaffolds = []
  scaffolds << Sprite.new(0, 500, Image[:scaffold])
  scaffolds << Sprite.new(1240, 500, Image[:scaffold])
  scaffolds << Sprite.new(Window.width/2 - 250, 300, Image[:scaffold_long])
  scaffolds << Sprite.new(0, 800, Image[:floor])
 
  Window.loop do
  
    enemy.update
    
    if time%15==0
      tama << Tama.new(player.x,player.y)
    end  
    Sprite.update(tama)
    
    if time % 20 == 0
      bullet << Bullet.new(enemy.x , enemy.y)
    end
    
    Sprite.update(bullet)
    
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    
    Sprite.draw(scaffolds)
    Sprite.check(player, scaffolds)
    
    player.update
    player.draw
    
    Sprite.draw(tama)
    enemy.draw
    Sprite.draw(bullet)
    time+=1
  end
end