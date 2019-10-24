Rails.application.routes.draw do
  get 'staticpages/home'
  get 'staticpages/about'
  root 'application#hello'
end
