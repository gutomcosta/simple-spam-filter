module BagOfWords
	class NgramModel
		attr_reader :unigram

		def initialize(text)
			@original_text = text
			@unigram = transform	
		end

		def frequency(type, word)
			@unigram[word]
		end

		def size_of(type)
			@unigram.size
		end

		def words
			@original_text.downcase.scan(/[a-z]+/)
		end


		private
		def transform
			unigram = Hash.new(0) 
			lenght_of_text = words.size
			lenght_of_text.times do |i|
				word = words[i]
				unigram[word] += 1				
			end
			unigram
		end
	end
end