# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require 'singleton'
require_relative 'company'
require_relative 'http'

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
          response = Edgarlib::Http.instance.get_response_as_json(@@url_ticker_cik_json)

          if response.nil?
            LOGGER.error(response.code)
          end

          @ticker_cik_cache = response
        end
        @ticker_cik_cache
      end
    end

    class CompanySearchUrlBuilder
      module CompanySearchUrlStatus
        module OwnerStatus
          INCLUDE = 'include'.freeze
        end
        module OutputStatus
          ATOM = 'atom'.freeze
        end
        module ActionStatus
          GET_COMPANY = 'getcompany'.freeze
        end
      end

      @@base_url = 'https://www.sec.gov/cgi-bin/browse-edgar?'

      def initialize(cik,
                     action=CompanySearchUrlStatus::ActionStatus::GET_COMPANY,
                     type=nil,
                     dateb=nil,
                     owner=CompanySearchUrlStatus::OwnerStatus::INCLUDE,
                     start=0,
                     count=100,
                     output=CompanySearchUrlStatus::OutputStatus::ATOM)
        @cik = cik
        @action = action
        @type = type
        @dateb = dateb
        @owner = owner
        @start = start
        @count = count
        @output = output
      end

      public
      def get_url
        url = @@base_url
        url << "action=#{@action}"
        url << "&CIK=#{@cik}"

        if @type.nil?
          url << "&type="
        else
          url << "&type=#{@type}"
        end

        if @dateb.nil?
          url << "&dateb="
        else
          url << "$dateb=#{@dateb}"
        end

        url << "&owner=#{@owner}"
        url << "&start=#{@start}"
        url << "&count=#{@count}"
        url << "&output=#{@output}"
        url
      end
    end
  end
end