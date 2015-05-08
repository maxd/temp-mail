require 'net/http'
require 'json'
require 'digest'

module Temp
  module Mail
    class Client
      def available_domains
        response = Net::HTTP.get_response(URI('http://api.temp-mail.ru/request/domains/format/json/'))
        JSON.parse(response.body, symbolize_names: true)
      end

      def incoming_emails(email)
        hash = Digest::MD5.hexdigest(email)
        response = Net::HTTP.get_response(URI("http://api.temp-mail.ru/request/mail/id/#{hash}/format/json/"))

        if response.is_a?(Net::HTTPNotFound)
          []
        else
          JSON.parse(response.body, symbolize_names: true)
        end
      end
    end
  end
end