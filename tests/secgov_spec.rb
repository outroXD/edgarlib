# encoding: utf-8

require 'rspec'
require_relative '../edgarlib/secgov'

describe "secgov" do
  it '正常 tickerを指定して取得したデータから、cik/ticker/titleを取得・確認するケース' do
    cik = 320193
    ticker = "AAPL"
    title = "Apple Inc."
    companies = Edgarlib::SecGov::TickerCik.new.get_companies_by_tickers([ticker])

    expect(cik).to eq companies[0].cik
    expect(ticker).to eq companies[0].ticker
    expect(title).to eq companies[0].title
  end

  it '正常 tickerとして存在しない値を渡してcik/ticker/titleの取得を試みたケース' do
    ticker = "DUMMY"
    company = Edgarlib::SecGov::TickerCik.new.get_companies_by_tickers([ticker])

    expect([]).to eq company
  end

  it '正常 企業検索URL生成処理 cikのみを指定したパターン' do
    cik = 320193
    url = Edgarlib::SecGov::CompanySearchUrlBuilder.new(cik=cik).get_url

    expect_url = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=320193&type=&dateb=&owner=include&start=0&count=100&output=atom"
    expect(expect_url).to eq url
  end
end