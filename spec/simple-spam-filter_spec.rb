require File.dirname(__FILE__) + '/spec_helper'
require_relative '../lib/bag_of_words/dictionary'
require_relative '../lib/spam_filter/detector'


def build_vocabulary_to(detector)
	detector.spam!("offer is secret")
	detector.spam!("click secret link")
	detector.spam!("secret sports link")

	detector.ham!("play sports today")
	detector.ham!("went play sports")
	detector.ham!("secret sports event")
	detector.ham!("sports is today")
	detector.ham!("sports cost money")
end

describe "simple-spam-filter" do

	context " about the classification" do
		let(:spam_filter) { SpamFilter::Detector.new }

		it "should allow classify a word as SPAM" do 
			spam_filter.spam!("offer is secret")
			spam_filter.spams.count.should be 1
		end

		it "should classify a word as HAM " do 
			spam_filter.ham!("play sports today")
			spam_filter.hams.count.should be 1
		end
	end

	context "about bag of words technique" do
		let(:sentence) { "hello i will say hello"}

		it "should build a dictionary" do 
			dictionary = BagOfWords::Dictionary.build(sentence)
			dictionary.size.should be 4
		end 
	end
	
	context "about the spam filter" do 
		let(:spam_filter) { SpamFilter::Detector.new }

		it "should be possible to know whats the size of vacabulary" do 
			build_vocabulary_to spam_filter
			spam_filter.vocabulary_size.should be 12
		end

		it "should be possible to know the probability of an word be spam" do 
			build_vocabulary_to spam_filter
			spam_filter.spam_probability.should == 0.375			
		end

		it "should be possible to know the probablity of an word be ham " do 
			build_vocabulary_to spam_filter
			spam_filter.ham_probability.should == 0.625
		end

		it "should be possible to know the probability of 'secret' word be spam" do 
			build_vocabulary_to spam_filter
			spam_filter.spam_probability_of('secret').should be_within(0.02).of(0.333)
		end

		it "should be possible to know the probability of 'secret' word be ham" do 
			build_vocabulary_to spam_filter
			spam_filter.ham_probability_of('secret').should be_within(0.02).of(0.066)
		end

		# it "should be possible to know the probability of P(spam|'secret is secret')" do
		# 	build_vocabulary_to spam_filter
		# 	message = "Secret is Secret"

		# 	Probabilities.calculate :probability => :spam, 	 :given => message
		# 	Probabilities.calculate :probability => message, :given => :spam
		# 	Probabilities.calculate :probability => message, :not => :spam

		# end



	
	end 

end