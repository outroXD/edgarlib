# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require 'singleton'
require 'rexml/document'

module Edgarlib
  class Http
    include Singleton

    private
    def get_response(url)
      response = Net::HTTP.get_response(url)

      case response
      when Net::HTTPSuccess
        return response
      else
        Edgarlib::LOGGER.error(response.code)
      end
      nil
    end

    public
    def get_response_as_json(url)
      response = self.get_response(url)

      if response.nil?
        return nil
      end

      json = nil
      begin
        json = JSON.load(response.body)
      rescue => e
        Edgarlib::LOGGER.error(e.message)
      end
      json
    end

    def get_response_as_xml(url)
      response = self.get_response(url)

      if response.nil?
        return nil
      end

      xml = nil
      begin
        xml = REXML::Document.new(response.body)
      rescue => e
        Edgarlib::LOGGER.error(e.message)
      end
      xml
    end
  end
end