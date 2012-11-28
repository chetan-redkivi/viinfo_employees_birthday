class DropTableViinfoFbConnctions < ActiveRecord::Migration
  def up
    drop_table :virtue_info_fb_connections
  end

  def down
  end
end
