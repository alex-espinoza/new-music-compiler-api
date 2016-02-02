class Api::V1::ApiController < ApplicationController
  include ActionController::Serialization
  
  respond_to :json

  def not_found(error_hash)
    render json: error_hash.deep_merge(error: {status: 404}),
           status: 404
  end

  def unmatched_route
    unmatched_hash = {error: {message: "No route matches: /#{params[:unmatched_route]}", status: 404}}
    
    render json: unmatched_hash,
           status: 404
  end
end
