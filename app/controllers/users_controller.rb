class UsersController < ApplicationController
  def set_background
    current_user.update_attribute(:bg_color,params[:bg_color])
    render :nothing => true
  end
end
