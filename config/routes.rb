Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get "/sources/:id/entries", to: "entries#index", as: "source_entries_path"

      get "*unmatched_route", to: "api#unmatched_route", as: "unmatched_route_path"
    end
  end
end
