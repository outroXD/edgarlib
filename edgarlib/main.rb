# encoding: utf-8

require 'logger'
require_relative 'cli'
require_relative 'secgov'

module Edgarlib
  LOGGER = Logger.new('../outputs/logs/edgarlib.log')

  class Main
    def self.run
      args = Edgarlib::CliTools::Args.new
      if args.t
        sec_gov = Edgarlib::SecGov::TickerCikJson.new
      end
    end
  end
end


# ===== main =====
Edgarlib::Main.run