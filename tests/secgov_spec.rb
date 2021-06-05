# encoding: utf-8

require 'rspec'
require_relative '../edgarlib/secgov'

describe "secgov" do
  it 'tickerを指定して取得したデータから、cik/ticker/titleを取得・確認するケース' do
    cik = 320193
    ticker = "AAPL"
    title = "Apple Inc."
    company = Edgarlib::SecGov::TickerCik.new.get_company_by_ticker(ticker)

    expect(cik).to eq company.cik
    expect(ticker).to eq company.ticker
    expect(title).to eq company.title
  end
end