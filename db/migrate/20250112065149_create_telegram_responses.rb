class CreateTelegramResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :telegram_responses do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.boolean :success, null: false
      t.jsonb :raw_response

      t.timestamps
    end
  end
end
