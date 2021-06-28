# encoding: utf-8

require 'net/http'
require 'open-uri'
require 'uri'
require 'json'
require 'singleton'
require 'nokogiri'
require 'rexml/document'

module Edgarlib
  class Http
    include Singleton

    private
    def get_response_body(url)
      URI.open(url) do |response|
        case response.status[1]  # get Http status code.
        when "OK"
          body = response.read
          return body
        else
          Edgarlib::LOGGER.error(response.status[0])
        end
      end
      nil
    end

    public
    def get_response_as_json(url)
      response_body = get_response_body(url)

      if response_body.nil?
        # TODO その後の処理不可のため例外投げる
        return nil
      end

      begin
        json = JSON.load(response_body)
      rescue => e
        Edgarlib::LOGGER.error(e.message)
      end
      json
    end

    def get_response_as_xml(url, parser="nokogiri")
      response_body = get_response_body(url)

      if response_body.nil?
        # TODO その後の処理不可のため例外投げる
        return nil
      end

      begin
        if parser == "nokogiri"
          xml = Nokogiri::HTML(response_body)
        else
          xml = REXML::Document.new(response_body)
        end
      rescue => e
        Edgarlib::LOGGER.error(e.message)
      end
      xml
    end
  end
end