class ApplicationController < ActionController::Base
  abstract!

  include ErrorResponses

  protect_from_forgery with: :exception
end
