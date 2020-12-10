class DirectMessage < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  # データが作成されたら非同期でブロードキャスト処理を実行
  # after_create_commitメソッドは、ActiveRecordのcreateまたはcreate!メソッドが呼び出されてデータベースへのコミットが正常終了した後に、
  # {}で指定したブロックが後処理として呼び出される
  # DirectMessageBroadcastJobは、perform_laterメソッドを通じて呼び出すことができる
  after_create_commit { DirectMessageBroadcastJob.perform_later self }
  
end
