module Menu
  @items = []

  def self.items
    @items
  end

  def self.item_file_paths(feature_name, extensions = %w[cofee scss rb erb])
    [
      *Dir.glob("**/*#{feature_name}*/**/*.{#{extensions.join(',')}}"),
      *Dir.glob("**/*#{feature_name}*.{#{extensions.join(',')}}")
    ].uniq.sort
  end
  private_class_method :item_file_paths

  MenuItem = Struct.new :title, :description, :demo_path, :codes, keyword_init: true

  @items << MenuItem.new(
    title:       'メニュー画面',
    description: '',
    demo_path:   '/menu',
    codes:       item_file_paths('menu')
  )

  @items << MenuItem.new(
    title:       '関連テーブルを含む登録更新処理',
    description: 'accept_nested_forを用いて、関連テーブルのレコードも併せて更新するサンプルコード',
    demo_path:   '/feature_active_record/parents',
    codes:       item_file_paths('feature_active_record')
  )

  @items << MenuItem.new(
    title:       'CarrierWaveを用いたファイルアップロード',
    description: '',
    demo_path:   '/feature_carrier_wave/users',
    codes:       item_file_paths('feature_carrier_wave')
  )
end
