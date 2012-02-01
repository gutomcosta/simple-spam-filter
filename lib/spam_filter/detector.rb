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
			dictionary = BagOfWords::Dictionary.build sentence
			dictionary.size
		end

		private	

		def sentence
			spam_sentence = to_sentence(@spams)
			ham_sentence  = to_sentence(@hams)
			spam_sentence.concat(" #{ham_sentence}")

		end

		def to_sentence(array)
			array.join(' ')
		end

	end
end