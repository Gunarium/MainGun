require 'dxopal'
include DXOpal

require_remote "player.rb"
require_remote "Tama.rb"
require_remote "bullet.rb"
require_remote "enemy.rb"
require_remote "enemy2.rb"
require_remote "enemy3.rb"
require_remote "enemy4.rb"
require_remote "enemies.rb"
require_remote "boss.rb"

Image.register(:Tama,'images/small.png')
Image.register(:apple, 'images/apple.png')
Image.register(:Heart,'images/player.png')

Image.register(:scaffold, 'images/ashiba.png')
Image.register(:scaffold_long, 'images/ashiba_long.png')
Image.register(:floor, 'images/floor.png')

Image.register(:title, 'images/title.PNG')
Image.register(:instraction, 'images/instraction.PNG')
Image.register(:game_over, 'images/game_over.PNG')
Image.register(:clear, 'images/clear.PNG')

# 音楽
Sound.register(:bgm, 'sounds/Devil_Disaster.wav')
Sound.register(:bgm_boss, 'sounds/boss.WAV')
Sound.register(:opening, 'sounds/opening.WAV')
Sound.register(:bang, 'sounds/bang.wav')
Sound.register(:dead, 'sounds/dead.wav')


$time=0
sound_time = 0

GROUND_Y = 700

GAME_INFO = {
  scene: :title,  # 現在のシーン(起動直後は:title)
}

Window.load_resources do
  
  # Windowサイズ設定
  Window.width  = 1000
  Window.height = 750
  
  player = Player.new
  player.collision = 40, 0, 80, 80
  #enemy = Enemy.new
  tama=[]
  $hearts=[]
  
  enemy = Enemies.new
  
  bullet = []
  
  # 足場を配置
  scaffolds = []
  scaffolds << Sprite.new(0, (GROUND_Y*2/3).to_i, Image[:scaffold])
  scaffolds << Sprite.new(Window.width - Image[:scaffold].width, (GROUND_Y*2/3).to_i, Image[:scaffold])
  scaffolds << Sprite.new(Window.width/2 - 250, (GROUND_Y/3).to_i, Image[:scaffold_long])
  scaffolds << Sprite.new(0, GROUND_Y, Image[:floor])
  
  sound_start = false
  boss = nil
  
  Window.loop do
    
    # シーンごとの処理
    case GAME_INFO[:scene]
    when :title
      
      # タイトル画面
      Window.draw(20, 15, Image[:title])
      
      if not sound_start
        sound_start = true
        sound_time = $time
      end
      
      if ($time - sound_time) % (60*(60+13)) == 0
        Sound[:opening].play
      end
      
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        Sound[:opening].stop
        GAME_INFO[:scene] = :instraction
        sound_start = false
      end
      
      $time += 1
      
    when :instraction
      
      # 操作説明画面
      Window.draw(20, 15, Image[:instraction])
      
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        enemy = Enemies.new
        for i in 0..5
          life = Image[:Heart]
          life.set_color_key([0, 0, 255])
          $hearts << Sprite.new(Window.width-(i*Image[:Heart].width),Window.height-Image[:Heart].height , life)
        end
        player.x = Window.width / 2
        player.y = GROUND_Y - Image[:player].height
        GAME_INFO[:scene] = :playing
      end
    
    when :playing
    
      # ステージを描画
      Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
      Sprite.draw(scaffolds)
      
      # BGM
      if not sound_start
        #Sound[:bgm].play
        sound_start = true
        sound_time = $time
      end
      
      if ($time - sound_time) % (60*(60+13)) == 0
        Sound[:bgm].play
      end
      
      # player
      Sprite.check(player, scaffolds)
      player.update
      
      # 向き
      if Input.mouse_pos_x >= player.x + 80
        player.scale_x = -1
      else
        player.scale_x = 1
      end
      
      enemy.update
      
      # 射撃
      if ($time%15==0 && Input.mouse_down?(M_LBUTTON)) || Input.mouse_push?(M_LBUTTON)
        tama << Tama.new(player.x,player.y)
        Sound[:bang].play
      end  
      Sprite.update(tama)
      
      player.draw
      Sprite.draw(tama)
      
      #敵1
      for i in 0..4
        if enemy.enemies[i].enemy_appear == true
          if $time % rand(100..200) == 0
            bullet << Bullet.new(enemy.enemies[i].x , enemy.enemies[i].y + Image[:apple].height - Image[:Tama].height)
          end
        end
      end
  
      
      Sprite.check(tama,scaffolds)
      Sprite.check(tama , enemy.enemies)
      Sprite.check(bullet , player)
      Sprite.check(enemy.enemies , player)
      enemy.draw
      
      # ゲームオーバー
      if $hearts.size  == 0
        Sound[:bgm].stop
        GAME_INFO[:scene] = :game_over
        sound_start = false
      end
      
      wave = enemy.wave
      #Sprite.update($hearts)
      Sprite.draw($hearts)
      
      Sprite.update(bullet)
      Sprite.draw(bullet)
      $time+=1
      
      # ボスへ
      if wave
        Sprite.clean(enemy.enemies)
        Sound[:bgm].stop
        GAME_INFO[:scene] = :boss_scene
        sound_start = false
      end
      
    when :boss_scene
      if not sound_start
        #boss設定
        boss = Boss.new
        sound_time = $time
        sound_start = true
      end
      
      # BGM
      if ($time - sound_time) % (60*(60+13)) == 0
        Sound[:bgm_boss].play
        sound_start = true
      end
      
      # ステージを描画
      Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [0, 0, 0])
      Sprite.draw(scaffolds)
      
      # player
      Sprite.check(player, scaffolds)
      player.update
      if Input.mouse_pos_x >= player.x + 80
        player.scale_x = -1
      else
        player.scale_x = 1
      end
      
      # 射撃
      if ($time%15==0 && Input.mouse_down?(M_LBUTTON)) || Input.mouse_push?(M_LBUTTON)
        tama << Tama.new(player.x,player.y)
        Sound[:bang].play
      end  
      Sprite.update(tama)
      
      player.draw
      
      Sprite.draw($hearts)
      
      boss.update
      #Sprite.check(player, boss.laser)
      #Sprite.draw(boss.laser)
      boss.draw
      
      Sprite.check(tama,scaffolds)
      Sprite.draw(tama)
      $time+=1
      
    when :game_over
      
      Window.draw(20, 15, Image[:game_over])
      
      if not sound_start
        sound_start = true
        sound_time = $time
      end
      
      if ($time - sound_time) % (60*(60+13)) == 0
        Sound[:dead].play
      end
      
      # スペースキーが押されたらシーンを変える
      if Input.key_push?(K_SPACE)
        GAME_INFO[:scene] = :instraction
        Sound[:dead].stop
        sound_start = false
      end
      
      $time += 1
    end
  end
end