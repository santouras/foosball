# frozen_string_literal: true
class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def query
    result_hash = Schema.execute(params[:query], variables: params[:variables])
    render json: result_hash
  end
end
