# encoding: utf-8

require 'singleton'

module Edgarlib
  class Company
    attr_accessor :ticker, :cik, :title

    def initialize(ticker, cik, title)
      @ticker = ticker
      @cik = cik
      @title = title
    end
  end

  class CompanyBuilder
    include Singleton

    def builds(tickers, ticker_cik_json)
      companies ||= []
      ticker_cik_json.each do |key, value|
        tickers.each do |ticker|
          if ticker == value["ticker"]
            companies.append(Company.new(ticker=value["ticker"],
                                         cik=value["cik_str"],
                                         title=value["title"]))
          end
        end
      end
      companies
    end
  end
end
