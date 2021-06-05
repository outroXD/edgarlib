# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require_relative 'company'

module Edgarlib
  module SecGov
    class TickerCik
      @@url_ticker_cik_json = 'https://www.sec.gov/files/company_tickers.json'.freeze
      @ticker_cik_cache = nil

      def initialize
        set_ticker_cik_cache
      end

      public
      def get_company_by_ticker(ticker)
        @ticker_cik_cache.each do |key, value|
          if ticker == value["ticker"]
            return Company.new(value["ticker"], value["cik_str"], value["title"])
          end
        end
        nil
      end

      private
      def set_ticker_cik_cache
        if @ticker_cik_cache.nil?
          response = Net::HTTP.get_response(URI.parse(@@url_ticker_cik_json))
          case response
          when Net::HTTPSuccess
            ticker_cik_hash = JSON.load(response.body)
            @ticker_cik_cache = ticker_cik_hash
          else
            LOGGER.error(response.code)
          end
          @ticker_cik_cache
        end
      end
    end
  end
end