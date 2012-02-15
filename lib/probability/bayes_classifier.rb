require_relative '../bag_of_words/dictionary'
require_relative '../probability/simple_probability'

module Probability
	class BayesClassifier
		
		def initialize
			@examples = {}
		end

		def train(classification, data)
			@examples[classification] = [] if @examples[classification].nil?
			@examples[classification] << data
		end
	
		def examples_of(classification)
			return [] if @examples[classification].nil?
			@examples[classification]
		end


		def classify(message)
			probabilities = {}
			@examples.keys.each do |classification|
				probabilities[classification] = conditional_for(message, classification)
			end
			classificate(probabilities)
		end

		def conditional(feature, classification)
			dictionary = BagOfWords::Dictionary.build to_sentence(examples_of(classification))
			simple_probability = Probability::SimpleProbability.new dictionary.words
			simple_probability.prior(feature)
		end

		private

		def classificate(probabilities)
			probabilities.max.first
		end

		def conditional_for(message, classification)
			dictionary 								= BagOfWords::Dictionary.build message
			simple_probability 				= Probability::SimpleProbability.new dictionary.words
			conditional_probabilities = dictionary.words.map { |word| conditional(word,classification)  }
			simple_probability.prior(classification) * conditional_probabilities.reduce {|x,y| x * y}
		end

		def to_sentence(array)
			array.join(' ')
		end


	end
end