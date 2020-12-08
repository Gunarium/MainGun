require_remote "item.rb"
require 'dxopal'
include DXOpal

# アイテム群を管理するクラスを追加
class Items
  # 同時に出現するアイテムの個数
  N = 5

  def initialize
    @items = []
  end

  def update
    # 各スプライトのupdateメソッドを呼ぶ
    Sprite.update(@items)
    # vanishしたスプライトを配列から取り除く
    Sprite.clean(@items)

    # 消えた分を補充する(常にアイテムがN個あるようにする)
    (N - @items.size).times do
      @items.push(Item.new)
    end
  end

  def draw
    # 各スプライトのdrawメソッドを呼ぶ
    Sprite.draw(@items)
  end
end
# クラスここまで
