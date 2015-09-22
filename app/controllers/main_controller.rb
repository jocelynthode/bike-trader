class MainController < ApplicationController
  def index
     if not TRUE
        render :action => 'sessions/new'
     end
  end

end
