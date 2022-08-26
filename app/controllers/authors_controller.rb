class AuthorsController < ApplicationController
  before_action :authenticate_author!

  layout 'users/authors'
end
