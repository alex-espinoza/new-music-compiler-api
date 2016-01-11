class API::V1::EntriesController < API::V1::ApiController
  before_filter :load_source

  def index
    if @source
      render json: @source.entries, 
             each_serializer: EntrySerializer, 
             status: 200
    else
      error_hash = {error: {message: "Invalid source id."}}
      not_found(error_hash)
    end
  end

  private

  def load_source
    @source = Source.find_by(id: params[:id])
  end
end
