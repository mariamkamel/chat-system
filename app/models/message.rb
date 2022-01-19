class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name  "chat_messages"
  document_type "message"

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :body
      indexes :chat_number, type: :integer
      indexes :token
    end
  end

  def self.search(query, chat_number, token)
    __elasticsearch__.search(
      {
        query: {
            bool:{
                must: [{
                    match: {
                        token: token
                    }
                  },
                  {
                    match: {
                        body: query
                    },
                  },
                  {
                    match: {
                        chat_number: chat_number
                    }
                }],
               
            }
        }
      }
    )
  end

  def as_indexed_json(options = nil)
    self.as_json( only: [ :chat_number, :body, :token ] )
  end
end
