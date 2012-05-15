class AddTwilioFields < ActiveRecord::Migration
  def up
  	add_column :call_logs, :from_number, :string
  	add_column :call_logs, :from_city, :string
  	add_column :call_logs, :from_state, :string
  end

  def down
  end
end
