x = 0
# Read the file in such a way that doesn't require the entire file to be in
# memory at once
File.open(ARGV[0].to_s).each_line do |line|# Read in the file via command
	# remove the new line character at the end
	line.delete!("\n")

	# Create the array
	column = line.split(",")

	# Drop the column "Triceps skin fold thickness (mm)" at index 4
	column.delete_at(4)

	# Add a new derived column called "Age (days)" which uses the existing column
	# "Age (years)" to compute the age in days
	if (x == 0)
		column.push("Age (days)")
	else
		column.push(column[7].to_i*365)
	end

	# Move the "Class" variable to the the first column position instead of the last
	column.insert(0, column[8])
	column.delete_at(9)

	# Give an example bash syntax for how you would call this script and redirect
	# the output to a file called "output.csv"
	if File.file?("output.csv")
		file = File.open("output.csv",  "a")
	else
		file = File.new("output.csv", "w")
	end
	
	if (x == 0)
		file.print "#{column.join(",")}"
		file.close
	else
		file.print "\n #{column.join(",")}"
		file.close
	end

	# Every 100 lines, write update messages to STDERR that inform the user of
	# the script of how many lines have been parsed in total
	x += 1
	if (x % 100) == 0
		puts "#{x} lines have been parsed."
	end
end

#puts line