class DirectMessage < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  # データが作成されたら非同期でブロードキャスト処理を実行
  after_create_commit { DirectMessageBroadcastJob.perform_later self }
  
end
