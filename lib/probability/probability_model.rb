module Probability
	class ProbabilityModel
		attr_reader :possible_worlds

		def initialize(possible_worlds)
			@possible_worlds = possible_worlds
		end

		def prior(event)
			return 0 unless (self.possible_worlds.include?(event))
			(1.0 / @possible_worlds.count.to_f)
		end

	end
end