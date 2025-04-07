class TweetsController < ApplicationController
  def index
    #Using a Cursor pagination
    tweets = Tweet.order(created_at: :desc)
    tweets = params[:user_id].present? ? tweets.by_user(params[:user_id]) : tweets
    
    
    if params[:before_time].present?
      cursor_time = Time.zone.parse(params[:before_time])
      if cursor_time.nil?
        render json: { error: 'Invalid timestamp format' }, status: :bad_request and return
      end
      tweets = tweets.before_time(cursor_time)
    end
  
    tweets = tweets.limit(10)

    render json: {
      tweets: tweets,
      next_cursor: tweets.last&.created_at
    }
  end
end
