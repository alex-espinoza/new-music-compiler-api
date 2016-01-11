class EntrySerializer < ActiveModel::Serializer
  attributes :title, :description, :embed_data, :url, :image_url, :published_at, :source_id
end
