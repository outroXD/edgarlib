# encoding: utf-8

require 'singleton'
require_relative 'secgov'

module Edgarlib
  class Company
    attr_accessor :ticker, :cik, :title, :company_rss

    def initialize(ticker, cik, title, company_rss)
      @ticker = ticker
      @cik = cik
      @title = title
      @company_rss = company_rss
    end
  end

  class CompanyBuilder
    include Singleton

    public
    def builds(tickers, ticker_cik_json)
      companies ||= []
      ticker_cik_json.each do |key, value|
        tickers.each do |ticker|
          if ticker == value["ticker"]
            companies.append(Company.new(ticker=value["ticker"],
                                         cik=value["cik_str"],
                                         title=value["title"],
                                         company_rss=create_company_rss(value["cik_str"])))
          end
        end
      end
      companies
    end

    private
    def create_company_rss(cik)
      url = Edgarlib::SecGov::CompanySearchUrlBuilder.new(cik=cik).to_s
      company_rss = Edgarlib::Http.instance.get_response_as_xml(url)
      company_rss
    end
  end
end
