require 'ostruct'

module Requests
  module JsonHelpers
    def rubify
      JSON.parse(response.body)
    end
  end
end
