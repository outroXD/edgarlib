# encoding: utf-8

module Edgarlib
  class Company
    attr_accessor :ticker, :cik, :title

    def initialize(ticker, cik, title)
      @ticker = ticker
      @cik = cik
      @title = title
    end
  end
end
