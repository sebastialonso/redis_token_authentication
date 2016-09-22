class IndexController < ApplicationController
  def index
    Rails.logger.info $redis.get('foo')
    render json: { message: 'up and running'}
  end
end