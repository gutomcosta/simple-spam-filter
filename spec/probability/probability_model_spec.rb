require_relative '../../lib/probability/probability_model'

def possible_words_for_a_dice
	# it's possible values when we rolling a dice
	["1","2","3","4","5","6"]
end

module Probability
	describe "Probability Model" do 

		it "should allow to define possible worlds " do
			probability_model = ProbabilityModel.new possible_words_for_a_dice
			probability_model.possible_worlds.should_not be_nil
		end

		context "about the 'Uncondicional or Prior' probability a dice with [1,2,3,4,5,6] possibilities" do 
			let(:probability_model) { ProbabilityModel.new possible_words_for_a_dice }
		
			it "should 0,166 to the probability P(1)" do
				probability_model.prior("1").should be_within(0.02).of(0.166)
			end

			it "should return 0 to the probabilty p(7)" do 
				probability_model.prior("7").should be_within(0.020).of(0)
			end
		end
	end
end