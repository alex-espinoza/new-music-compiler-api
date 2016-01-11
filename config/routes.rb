Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get "/sources/:id/entries", to: "entries#index", as: "source_entries_path"
    end
  end
end
