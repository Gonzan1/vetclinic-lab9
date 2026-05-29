class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  # Le decimos a Pundit que se salte la vigilancia solo en el Home
  skip_authorization
  end
end
