class StockSerializer < ActiveModel::Serializer
  attributes :id, :ticker, :e_score, :e_percentile, :s_score, :s_percentile, :g_score, :g_percentile, :total_score, :total_percentile
end
