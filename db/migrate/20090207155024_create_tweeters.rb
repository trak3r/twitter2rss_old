class CreateTweeters < ActiveRecord::Migration
  def self.up
    create_table :tweeters do |t|
      t.string :screen_name
      t.timestamp :last_polled_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tweeters
  end
end
