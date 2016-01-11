class API::V1::EntriesController < API::V1::ApiController
  def index
    source = load_source
    render json: source.entries, each_serializer: EntrySerializer
  end

  private

  def load_source
    source = Source.find(params[:id])
  end
end
