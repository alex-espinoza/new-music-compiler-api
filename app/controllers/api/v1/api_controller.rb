class API::V1::ApiController < ApplicationController
  include ActionController::Serialization
  
  respond_to :json

  def not_found(error_hash)
    render json: error_hash.deep_merge(error: {status: 404}),
           status: 404
  end
end
