class AddUserRefToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums, :user, foreign_key: true
  end
end
