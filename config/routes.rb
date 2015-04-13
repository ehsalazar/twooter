Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get 'twoots/recent', to: 'twoots#recent'
  get 'twoots/search/:keyword', to: 'twoots#search'
  post 'twoots', to: 'twoots#create'
  get 'hashtags/popular', to: 'hashtags#popular'

  root to: 'static#index'

end
