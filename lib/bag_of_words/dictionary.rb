require_relative '../bag_of_words/ngram_model'
module BagOfWords
	class Dictionary
		def initialize(ngram)
			@ngram = ngram 
		end

		def self.build(text)
			ngram = NgramModel.new(text)
			Dictionary.new(ngram)
		end

		def size
			@ngram.size_of(:unigram)
		end

		def words
			@ngram.words		
		end

		def frequency(word)
			@ngram.frequency(:unigram, word)
		end


	end
end