module Menu
  @items = []

  def self.items
    @items
  end

  MenuItem = Struct.new :title, :description, :demo_path, :codes, keyword_init: true

  @items << MenuItem.new(
    title:       'メニュー画面',
    demo_path:   '/menu',
    codes:       Dir.glob('**/*menu*/**/*.*').sort
  )

  @items << MenuItem.new(
    title:       '関連テーブルを含む登録更新処理',
    description: 'accept_nested_forを用いて、関連テーブルのレコードも併せて更新するサンプルコード',
    demo_path:   '/feature_active_record/parents',
    codes:       Dir.glob('**/*feature_active_record*/**/*.*').sort
  )

  @items << MenuItem.new(
    title:       'CarrierWaveを用いたファイルアップロード',
    demo_path:   '/feature_carrier_wave/users',
    codes:       Dir.glob('**/*feature_carrier_wave*/**/*.{coffee,scss,rb,erb}').sort
  )
end
