class ApplicationController < ActionController::Base
  def hello
    render html: 'Yo Dawg'
  end
end
