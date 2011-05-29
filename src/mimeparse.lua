--

module (...)

-- Parses a mime-type into its component parts.
function parse_mime_type()
end

-- Media-ranges are mime-types with wild-cards and a 'q' quality parameter.
function parse_media_range()
end

-- Determines the quality ('q') of a mime-type when compared against a list
-- of media-ranges.
function quality()
end

-- Just like quality() except the second parameter must be pre-parsed.
function quality_parsed()
end

-- Just like quality_parsed() but also returns the fitness score.
function fitness_and_quality_parsed()
end

-- Choose the mime-type with the highest fitness score and quality ('q')
-- from a list of candidates.
function best_match()
end

