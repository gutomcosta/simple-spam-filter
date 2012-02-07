module Probability
	class SimpleProbability
		attr_reader :possible_worlds

		def initialize(possible_worlds)
			@possible_worlds = possible_worlds
		end

		def prior(event)
			return 0 unless is_there_event?(event)
			(number_of_occurrences_for(event) / @possible_worlds.count.to_f)
		end

		def complementary(event)
			raise "Event #{event} doesn't exists" if not is_there_event?(event)
			1 - prior(event)
		end

		private	

		def number_of_occurrences_for(event)
			@possible_worlds.count {|e| e == event}
		end

		def is_there_event?(event)
			self.possible_worlds.include?(event)
		end

	end
end