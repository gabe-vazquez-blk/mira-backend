require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require 'dotenv/load'

# <---- Paths ---->
score_path = ".D\\(ib\\).Fz\\(23px\\).smartphone_Fz\\(22px\\).Fw\\(600\\)"
percentile_path = ".Bdstarts\\(s\\).Bdstartw\\(0\\.5px\\).Pstart\\(5px\\).Mstart\\(5px\\).smartphone_Mstart\\(0px\\).smartphone_Pstart\\(0px\\).Bdc\\(\\$c-fuji-grey-c\\).Fz\\(12px\\).smartphone_Fz\\(10px\\).smartphone_Bd\\(n\\).Fw\\(500\\)"

total_score_path = ".Fz\\(36px\\).Fw\\(600\\).D\\(ib\\).Mend\\(5px\\)"
total_percentile_path = ".Bdstarts\\(s\\).Bdstartw\\(0\\.5px\\).Pstart\\(10px\\).Bdc\\(\\$c-fuji-grey-c\\).Fz\\(12px\\).smartphone_Fz\\(10px\\).smartphone_Bd\\(n\\).Fw\\(500\\)"

# <---- IEX DATA ---->
iex_url = "#{ENV['S3_TEST_API_URL']}/ref-data/symbols?filter=symbol&token=#{ENV['S3_TEST_API_KEY']}"
uri = URI(iex_url)
response = Net::HTTP.get(uri)
tickers = JSON.parse(response)
tickers = tickers

# <---- CREATE STOCKS DB----> 
percent_complete = 0
tickers.each do |ticker|
  ticker.each do |symbol, ticker|
    if !ticker.include?("^")
      doc = Nokogiri::HTML(open("https://finance.yahoo.com/quote/#{ticker}/sustainability"))
      if doc.css(score_path).length > 0 then
        scores = []
        doc.css(score_path).children.each do |child| 
          if child.text.length < 2 then
            score = child.text[0].to_i
            scores.push(score)
          else
            score = child.text[0,2].to_i
            scores.push(score)
          end
        end
        percentiles = []
        doc.css(percentile_path).children.each do |child| 
          if child.text[1] === 't' then
            percentile = child.text[0].to_i
            percentiles.push(percentile)
          else
            percentile = child.text[0,2].to_i
            percentiles.push(percentile)
          end
        end
        total_score_text= doc.css(total_score_path).text
        if total_score_text.length < 2 then
          total_score = total_score_text[0].to_i
        else
          total_score = total_score_text[0,2].to_i
        end
        total_percentile_text= doc.css(total_percentile_path).text
        if total_percentile_text.length < 2 then
          total_percentile = total_percentile_text[0].to_i
        else
          total_percentile = total_percentile_text[0,2].to_i
        end
        e_score = scores[0]
        s_score = scores[1]
        g_score = scores[2]
        e_percentile = percentiles[0]
        s_percentile = percentiles[1]
        g_percentile = percentiles[2]
        Stock.create(ticker: ticker, e_score: e_score, e_percentile: e_percentile, s_score: s_score, s_percentile: s_percentile, g_score: g_score, g_percentile: g_percentile, total_score: total_score, total_percentile: total_percentile)
      end
    end
    percent_complete += 0.011349449
    puts "#{(percent_complete).round(2)}%"
  end
end

# puts "E: #{e_score} EP: #{e_percentile} S: #{s_score} SP: #{s_percentile} G: #{g_score} GP: #{g_percentile} T: #{total_score} TP: #{total_percentile}"
