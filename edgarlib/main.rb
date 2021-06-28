# encoding: utf-8

require 'logger'
require 'singleton'
require_relative 'cli'
require_relative 'secgov'

module Edgarlib
  LOGGER = Logger.new('../outputs/logs/edgarlib.log')

  class Main
    include Singleton

    def run
      args = Edgarlib::CliTools::Args.new
      companies = Edgarlib::SecGov::TickerCik.new.get_companies_by_tickers(args.tickers)
      print "STOP"
    end
  end
end


# ===== main =====
Edgarlib::Main.instance.run