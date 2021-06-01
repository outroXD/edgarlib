# encoding: utf-8

require 'logger'
require_relative 'cli'

module Edgarlib
  LOGGER = Logger.new('../outputs/logs/edgarlib.log')

  class Main
    def self.run
      args = Edgarlib::CliTools::Args.new
      print "STOP"
    end
  end
end


# ===== main =====
Edgarlib::Main.run