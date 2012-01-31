require File.dirname(__FILE__) + '/spec_helper'
require_relative '../lib/bag_of_words/dictionary'

describe "simple-spam-filter" do

	context "about bag of words technique" do
		let(:sentence) { "hello i will say hello"}

		it "should build a dictionary" do 
			dictionary = BagOfWords::Dictionary.build(sentence)
			dictionary.size.should be 4
		end 

	end 

end