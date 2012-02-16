require_relative '../../lib/probability/bayes_classifier'


def train_the_bayes(bayes_classifier)
	bayes_classifier.train :spam, "offer is secret"
	bayes_classifier.train :spam, "click secret link"
	bayes_classifier.train :spam, "secret sports link"
	
	bayes_classifier.train :ham, "play sports today"
	bayes_classifier.train :ham, "went play sports"
	bayes_classifier.train :ham, "secret sports event"
	bayes_classifier.train :ham, "sports is today"
	bayes_classifier.train :ham, "sports cost money"
end

module Probability
	describe "Bayes Classifier" do 
		let(:bayes_classifier) {BayesClassifier.new}

		context "about training data" do 
			it "should be possible to train the classifier" do 
				bayes_classifier.train :spam, 'offer is secret'
				bayes_classifier.train :spam, 'click secret link'
			end

			it "should be possible to get the data by classification" do 
				bayes_classifier.train :spam, 'offer is secret'
				bayes_classifier.train :ham, 'play sports today'
				
				bayes_classifier.examples_of(:spam).should include("offer is secret")
				bayes_classifier.examples_of(:ham).should include("play sports today")
			end

		end

		context "about the conditional probability" do 
			it "should be 0.333 for 'secret' word be spam" do 
				train_the_bayes(bayes_classifier)
				bayes_classifier.conditional("secret",:spam).should be_within(0.02).of(0.333)
			end
		end 

		it "should classify a sentence  'the secret of universe' as spam" do 
			train_the_bayes(bayes_classifier)			
			bayes_classifier.classify('the secret of universe').should be :spam
		end

		it "should classify the sentence 'sports is today' as ham" do 
			train_the_bayes(bayes_classifier)
			bayes_classifier.classify('sports is today').should be :ham
		end

	end

end