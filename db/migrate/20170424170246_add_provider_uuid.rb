class AddProviderUuid < ActiveRecord::Migration[5.0]
  def self.up
    User.update_all("uid=email")
  end

  def self.down
  end
end
