require 'dxopal'
include DXOpal

require_remote "player.rb"
require_remote "Tama.rb"
require_remote "bullet.rb"
require_remote "enemy.rb"
require_remote "bgm.rb"
require_remote "enemy2.rb"
#require_remote "bullet2.rb"
require_remote "enemies.rb"


time=0

GROUND_Y = 700

Image.register(:scaffold, 'images/ashiba.png')
Image.register(:scaffold_long, 'images/ashiba_long.png')
Image.register(:floor, 'images/floor.png')
Image.register(:title, 'images/title.PNG')

GAME_INFO = {
  scene: :title,  # 現在のシーン(起動直後は:title)
}

Window.load_resources do
  
  # Windowサイズ設定
  Window.width  = 1000
  Window.height = 750
  
  player = Player.new
  #enemy = Enemy.new
  tama=[]
  
  enemy = Enemies.new
  
  bullet = []
  
  # 足場を配置
  scaffolds = []
  scaffolds << Sprite.new(0, (GROUND_Y*2/3).to_i, Image[:scaffold])
  scaffolds << Sprite.new(Window.width - Image[:scaffold].width, (GROUND_Y*2/3).to_i, Image[:scaffold])
  scaffolds << Sprite.new(Window.width/2 - 250, (GROUND_Y/3).to_i, Image[:scaffold_long])
  scaffolds << Sprite.new(0, GROUND_Y, Image[:floor])
  
  #BGM
  bgm = Bgm.new
  
  Window.loop do
    
    # シーンごとの処理
    case GAME_INFO[:scene]
    when :title
      
      # タイトル画面
      Window.draw(0, 0, Image[:title])
      
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        GAME_INFO[:scene] = :playing
      end
    
    when :playing
    
      if time % (60*(60+13)) == 0
        bgm.play
      end
      # ステージを描画
      Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
      Sprite.draw(scaffolds)
      
      # player
      Sprite.check(player, scaffolds)
      player.update
      
      enemy.update
      
      if (time%15==0 && Input.mouse_down?(M_LBUTTON)) || Input.mouse_push?(M_LBUTTON)
        tama << Tama.new(player.x,player.y)
      end  
      Sprite.update(tama)
      
      player.draw
      Sprite.draw(tama)
      
      #敵1
      for i in 0..2
        if enemy.enemies[i].enemy_appear == true
          if time % rand(10..20) == 0
            bullet << Bullet.new(enemy.enemies[i].x , enemy.enemies[i].y)
          end
        end
      end
  
      
      
      Sprite.check(tama , enemy.enemies)
      Sprite.check(tama,scaffolds)
        
      enemy.draw
      
      Sprite.update(bullet)
      Sprite.draw(bullet)
      time+=1
    end
  end
end