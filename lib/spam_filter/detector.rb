require_relative '../bag_of_words/dictionary'

module	SpamFilter
	class Detector 
		attr_reader :spams, :hams

		def initialize
			@spams = []
			@hams  = []
		end

		def spam!(text)
			@spams << text
		end

		def ham!(text)
			@hams << text
		end

		def vocabulary_size
			complete_dictionary.size
		end

		def spam_probability
			basic_probability_of @spams
		end

		def ham_probability
			basic_probability_of @hams
		end

		def spam_probability_of(word)
			dictionary = spam_dictionary
			frequency = dictionary.frequency(word)
			frequency.to_f / dictionary.words.count 			
		end

		private	

		def complete_dictionary
			BagOfWords::Dictionary.build sentence
		end

		def spam_dictionary
			BagOfWords::Dictionary.build to_sentence(@spams)
		end
			

		def basic_probability_of(data)
			data.size.to_f / size
		end

		def sentence
			spam_sentence = to_sentence(@spams)
			ham_sentence  = to_sentence(@hams)
			spam_sentence.concat(" #{ham_sentence}")
		end

		def size
			(@spams.size.to_f + @hams.size.to_f)
		end

		def to_sentence(array)
			array.join(' ')
		end

	end
end