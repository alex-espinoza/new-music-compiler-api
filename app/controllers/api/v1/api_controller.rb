class API::V1::ApiController < ApplicationController
  include ActionController::Serialization
  
  respond_to :json
end
