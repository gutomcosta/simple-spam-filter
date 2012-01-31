require_relative '../../lib/bag_of_words/ngram_model'


module BagOfWords
	describe "NGram Model" do 

		context "about unigram transformations" do 
			
			it "should return frequency 1 for words that appears one time" do 
				ngram = NgramModel.new("Computer science rocks")
				ngram.frequency(:unigram, "computer").should be 1
			end

			it "should return frequency 2 for words that appears two times" do 
				ngram = NgramModel.new("I want to buy a car and i want a beatiful car")
				ngram.frequency(:unigram, "car").should be 2
			end

			it "should return frequency 3 from words that appears three times" do 
				ngram = NgramModel.new("I want to buy a car, to buy a notebook, to buy a guitar")
				ngram.frequency(:unigram, "buy").should be 3
			end

			it "should not consider pontuations in the senteces" do 
				ngram = NgramModel.new("I want to buy a car. A beatiful car!")
				ngram.frequency(:unigram, "car").should be 2
				ngram.frequency(:unigram, ".").should be 0
			end

			it "should return a size of an unigram model" do 
				ngram = NgramModel.new("I want to buy a car. A beatiful car!")
				ngram.size_of(:unigram).should be 7
			end

		end
	end
end

