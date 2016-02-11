module ApplicationHelper
	# taken from S/) http://stackoverflow.com/questions/5661466/test-if-string-is-a-number-in-ruby-on-rails
	def is_number? string
	  true if Float(string) rescue false
	end
end
