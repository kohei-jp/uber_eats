module Api
  module V1
    class ApiController < ApplicationController
      protect_from_forgery # CSRF対策
    end
  end
end