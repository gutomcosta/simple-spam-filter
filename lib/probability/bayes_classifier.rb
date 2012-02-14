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


		def classify(data)
			:spam
		end


	end
end