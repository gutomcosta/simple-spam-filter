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
			classificate the_probabilities_for(message)
		end

		def probability(message, classification)
			probabilities = the_probabilities_for(message)
			probabilities[classification]
		end

		def conditional(feature, classification)
			dictionary 				 	= BagOfWords::Dictionary.build to_sentence(examples_of(classification))
			simple_probability 	= Probability::SimpleProbability.new dictionary.words
			simple_probability.prior(feature)
		end

		private

		def the_probabilities_for(message)
			probabilities = {}
			@examples.keys.each do |classification|
				probabilities[classification] = conditional_for(message, classification)
			end
			probabilities
		end

		def classificate(probabilities)
			max = probabilities.max { |a,b| a.last <=> b.last } 
			max.first
		end

		def conditional_for(message, classification)
			message_dictionary 				= BagOfWords::Dictionary.build message
			conditional_probabilities = message_dictionary.words.map { |word| conditional(word,classification)  }
			prior(classification) * conditional_probabilities.reduce {|x,y| x * y}
		end

		def all_classification
			values = @examples.map {|key,value| value}
			values.flatten
		end

		def to_sentence(array)
			array.join(' ')
		end

		def prior(classification)
			examples_of(classification).size.to_f / all_classification.size.to_f
		end


	end
end