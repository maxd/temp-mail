require 'net/http'
require 'json'
require 'digest'
require 'pry'

module Temp
  module Mail
    class Client
      def available_domains
        response = Net::HTTP.get_response(URI('https://api.temp-mail.org/request/domains/format/json/'))
        JSON.parse(response.body, symbolize_names: true)
      end

      def incoming_emails(email)
        hash = Digest::MD5.hexdigest(email)
        response = Net::HTTP.get_response(URI("https://api.temp-mail.org/request/mail/id/#{hash}/format/json/"))

        if response.is_a?(Net::HTTPNotFound)
          []
        else
          JSON.parse(response.body, symbolize_names: true)
        end
      end
    end
  end
end