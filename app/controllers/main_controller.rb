class MainController < ApplicationController
  skip_before_action :authenticate_user!
  def index
     if not TRUE
        render :action => 'sessions/new'
     end
  end

end
