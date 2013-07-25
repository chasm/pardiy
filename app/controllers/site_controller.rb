class SiteController < ApplicationController
  before_action :is_authenticated, only: [ :index ]
  
  # GET / - dashboard
  def index
  end
  
  # GET /privacy - privacy policy (not protected)
  def privacy
  end
  
  # GET /terms - terms of use (not protected)
  def terms
  end
end
