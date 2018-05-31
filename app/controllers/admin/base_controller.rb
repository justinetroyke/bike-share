class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    unless current_admin?
      @hide_nav = true
      render file: "/public/403", status: 403
    else
      @hide_nav = false
    end
  end

end