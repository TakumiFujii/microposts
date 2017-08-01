class CreateRelationships < ActiveRecord::Migration[5.0]
  #フォローの機能
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true    #user_idになる
      t.references :follow, foreign_key: { to_table: :users }  #follow_idになる
      #結局どっちもユーザーやから同じやけどな！名前被らんように変えてるだけ！

      t.timestamps
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
