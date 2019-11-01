class ApiController < ApplicationController
  abstract!

  protect_from_forgery with: :null_session
end
