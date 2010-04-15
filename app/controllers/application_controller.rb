class ApplicationController < ActionController::Base
  include Behance
  protect_from_forgery
end
