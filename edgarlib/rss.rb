# encoding: utf-8

require 'net/http'
require 'uri'
require_relative 'secgov'
require_relative 'http'

module Edgarlib
  class Rss
  end

  class CompanyRss < Rss
    attr_accessor :cik, :url

    def initialize(company)
      cik = company.cik
      url = Edgarlib::SecGov::CompanySearchUrlBuilder.new(cik=cik)
    end

    def download
    end
  end
end