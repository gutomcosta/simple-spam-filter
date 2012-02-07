require_relative '../../lib/probability/probability_model'

def sample_space_for_a_dice
	# it's possible values when we rolling a dice
	["1","2","3","4","5","6"]
end

def sample_space_for_weather
	["sunny", "sunny", "rain", "cloudy", "cloudy","snow","rain", "sunny"]
	
end

module Probability
	describe "Probability Model" do 

		it "should allow to define possible worlds " do
			probability_model = ProbabilityModel.new sample_space_for_a_dice
			probability_model.possible_worlds.should_not be_nil
		end

		context "about the 'Uncondicional or Prior' probability for a dice with [1,2,3,4,5,6] possibilities" do 
			let(:probability_model) { ProbabilityModel.new sample_space_for_a_dice }
		
			it "should 0,166 to the probability P(1)" do
				probability_model.prior("1").should be_within(0.02).of(0.166)
			end

			it "should return 0 to the probabilty p(7)" do 
				probability_model.prior("7").should be_within(0.020).of(0)
			end
		end

		context 'about the "Uncondicional or Prior" probabilty for a weather possibilities ["sunny", "sunny", "rain", "cloudy", "cloudy","snow","rain", "sunny"]' do
			let(:probability_model) { ProbabilityModel.new sample_space_for_weather }
			
			it "should be 0.37 to the probabilty P(sunny)" do
				probability_model.prior("sunny").should be_within(0.02).of(0.37)
			end

			it "should be 0.12 to the probabilty P(snow)" do 
				probability_model.prior("snow").should be_within(0.02).of(0.12)
			end
		end

		context 'about the complementary events, it is P(not Event) = 1 - P(event)' do 
			let(:probability_model) { ProbabilityModel.new sample_space_for_weather }

			it "should be 0.62 to the probability P(not sunny)" do 
				probability_model.complementary("sunny").should be_within(0.02).of(0.62)
			end

			it "should raise an error for a complementary probability that doesn't exists" do 
				expect {
					probability_model.complementary("invalid event")
				}.to raise_error
			end

		end
	end
end