class Api::V1::EntriesController < Api::V1::ApiController
  before_filter :load_source

  def index
    render json: @source.entries, 
           each_serializer: EntrySerializer, 
           status: 200
  end

  private

  def load_source
    @source = Source.find_by(id: params[:id]) || not_found
  end

  def not_found
    error_hash = {error: {message: "Source ID not found."}}
    super(error_hash)
  end
end
