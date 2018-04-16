x = 0
item_id = Array.new
File.open(ARGV[0].to_s).each_line do |line|
	line.delete!("\n")
	column = line.split(",")
	column.delete_at(4)

	if (x == 0)
		column.push("Age (days)")
	else
		column.push(column[7].to_i*365)
	end

	column.insert(1, column[8])
	column.delete_at(9)

	if (x == 0)
		item_id = column
	end

	if File.file?("output.csv")
		file = File.open("output.csv",  "a")
	else
		file = File.new("output.csv", "w")
	end

	if (x == 0)
		header = ["transaction_id", "item_id", "item_volume"]
		file.print "#{header.join(",")}"
	else
		file.print "\n"
		i = 1
		loop do
			file.print "#{column[0]},#{item_id[i]},#{column[i].to_i}"
			if (i < column.count-1)
				file.print "\n"
			end
			i += 1
			break if (i >= column.count)
		end
		# file.print "\n #{column.join(",")}"
	end
	file.close

	x += 1
	if (x % 100) == 0
		puts "#{x} lines have been parsed."
	end
end