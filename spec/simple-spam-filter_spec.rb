require File.dirname(__FILE__) + '/spec_helper'
require_relative '../lib/bag_of_words/dictionary'
require_relative '../lib/spam_filter/detector'

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
			spam_filter.spam!("offer is secret")
			spam_filter.spam!("click secret link")
			spam_filter.spam!("secret sports link")

			spam_filter.ham!("play sports today")
			spam_filter.ham!("went play sports")
			spam_filter.ham!("secret sports event")
			spam_filter.ham!("sports is today")
			spam_filter.ham!("sports cost money")

			spam_filter.vocabulary_size.should be 12
		end

		it "should be possible to know the probability of an word is spam" do 
			
		end
	
	end 

end