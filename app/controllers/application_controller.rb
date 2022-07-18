class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin then
      admin_path
    when Customer then
      root_path
    end
  end
end
