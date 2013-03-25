class Admin::AdminController < ApplicationController
  # filters shared by all administrative controllers will go here
  check_authorization
end