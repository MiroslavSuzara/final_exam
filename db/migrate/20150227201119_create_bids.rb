class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :bid
      t.references :auction, index: true

      t.timestamps null: false
    end
    add_foreign_key :bids, :auctions
  end
end
