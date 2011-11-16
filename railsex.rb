# Method shuffles given string
def string_shuffle(s)
	s.split('').shuffle.join
end
# string_shuffle("foobar")

# Function
class String
	def shuffle
		self.split('').shuffle.join
	end	
end
# "foobar".shuffle

person1 = {:first =>"chris", :last =>"webb"}