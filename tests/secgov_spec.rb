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

  it 'tickerとして存在しない値を渡してcik/ticker/titleの取得を試みたケース' do
    ticker = "DUMMY"
    company = Edgarlib::SecGov::TickerCik.new.get_company_by_ticker(ticker)

    expect(nil).to eq company
  end
end