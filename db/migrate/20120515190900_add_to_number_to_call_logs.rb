class AddToNumberToCallLogs < ActiveRecord::Migration
  def change
    add_column :call_logs, :to_number, :string
  end
end
