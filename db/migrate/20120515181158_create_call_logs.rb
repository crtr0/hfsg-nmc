class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.string :callerName
      t.string :momsAge
      t.string :howHeard
      t.string :wic
      t.string :ethnicity
      t.string :babyAge
      t.string :whereDelivered
      t.string :howLongBF
      t.string :infoHelping
      t.string :referral
      t.string :callBack

      t.timestamps
    end
  end
end
