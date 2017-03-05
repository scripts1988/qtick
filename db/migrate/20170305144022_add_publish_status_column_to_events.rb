class AddPublishStatusColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :publish_status, :boolean, :default => false
  end
end
