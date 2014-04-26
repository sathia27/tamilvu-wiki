class WordDetail < ActiveRecord::Base
  belongs_to :word
  belongs_to :pos
end