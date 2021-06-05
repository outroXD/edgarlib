# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'
require 'singleton'
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

      def initialize(cik, action=nil, type=nil, dateb=nil, owner=nil, start=nil, count=nil, output=nil)
        @cik = cik

        if action.nil?
          @action = CompanySearchUrlStatus::ActionStatus::GET_COMPANY
        else
          @action = action
        end

        @type = type
        @dateb = dateb

        if owner.nil?
          @owner = CompanySearchUrlStatus::OwnerStatus::INCLUDE
        else
          @owner = owner
        end

        if start.nil?
          @start = 0
        else
          @start = start
        end

        if count.nil?
          @count = 100
        else
          @count = count
        end

        if output.nil?
          @output = CompanySearchUrlStatus::OutputStatus::ATOM
        else
          @output = output
        end
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
          utl << "$dateb=#{@dateb}"
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