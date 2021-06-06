# encoding: utf-8

require 'rspec'
require_relative '../edgarlib/secgov'
require_relative '../edgarlib/http'

describe "http" do
  it '正常 http通信経由でXMLを取得するケース' do
    cik = 320193
    url = Edgarlib::SecGov::CompanySearchUrlBuilder.new(cik=cik).get_url
    xml = Edgarlib::Http.instance.get_response_as_xml(url)
  end
end
