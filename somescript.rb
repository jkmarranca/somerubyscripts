# Read in the file via command
data_from_file = File.read(ARGV[0].to_s)

# Create 2D array with the values
rows = data_from_file.split("\n")
x = 0
rows.each do |row|
	rows[x] = row.split(",")
	x += 1
end

# Drop the column "Triceps skin fold thickness (mm)" at index 4
x = 0
loop do
	rows[x].delete_at(4)
	x += 1
	break if (x >= rows.count)
end

# Add a new derived column called "Age (days)" which uses the existing column
# "Age (years)" to compute the age in days
rows[0].push("Age (days)")
x = 1
loop do
	rows[x].push(rows[x][7].to_i*365)
	x += 1
	break if (x >= rows.count)
end

# Move the "Class" variable to the the first column position instead of the last
x = 0
loop do
	rows[x].insert(0, rows[x][8])
	rows[x].delete_at(9)
	x += 1
	break if (x >= rows.count)
end

# output the resulting data to STDOUT
x = 0
loop do
	print "\n #{rows[x].join(",")}"
	x += 1
	break if (x >= rows.count)
end