require './lib/enigma'

enigma = Enigma.new
file = File.open(ARGV[0], "r")
message = file.read

result = enigma.encrypt(message)
new_file = File.open(ARGV[1], "w")
new_file.write(result[:encryption])
new_file.close
puts "Created '#{ARGV[1]}' with the key #{result[:key]} and date #{result[:date]}"
