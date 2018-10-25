# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

User.delete_all

Dir.glob(Rails.root.join('db', 'seeds', '*.csv')).each do |csv_path|
  klass = File.basename(csv_path, '.csv').classify.constantize
  CSV.foreach(csv_path, headers: true) do |row|
    klass.create row.to_hash
  end
end
