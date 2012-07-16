class ApplicationController < ActionController::Base
  require 'will_paginate/array'
  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include MessagesHelper
  include LocationsHelper
  include ImagesHelper
end
