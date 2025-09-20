class ShortLinks::StatsController < ApplicationController


    def index
      @short_link = ShortLink.find(params[:short_link_id])
      @link_clicks = @short_link.link_clicks.order(created_at: :desc)
      @clicks_per_hour = @short_link.link_clicks.group_by_hour(:created_at).count
    end


end
