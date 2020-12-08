require 'dxopal'
include DXOpal
require_remote "player.rb"
require_remote "item.rb"
require_remote "items.rb"
GROUND_Y = 400
Image.register(:player, 'images/player.png')
Window.load_resources do
  player = Player.new
  # Itemsクラスのオブジェクトを作る
  items = Items.new
  Window.loop do
    player.update
    # アイテムの作成・移動・削除
    items.update
    Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    player.draw
    # アイテムの描画
    items.draw
  end
end