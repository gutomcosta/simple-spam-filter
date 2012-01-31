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


	end
end