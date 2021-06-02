class TuringMachine
	attr_accessor :verbose, :option

	def initialize(initial_tape_value, transition_filename)
		#Machine Tape
		@tape = set_tape(initial_tape_value)
		
		#Set the default value for keys with no value in the tape hash
		@tape.default = Cell.new({value: "e", being_read: false})
		
		#start the head at 0
		@reading_head = 0
		
		#Load the transition table
		@transition_table = load_transitions(transition_filename)
		
		#set the initial state
		@current_state = 0
		
		#set the final state
		@final_state = @transition_table.length - 1
		
		#Do not output complete config history by default
		@verbose = false
	end

	#print out the tape
	def print_tape
		#Get a list of keys sorted by numeric value
		sorted_keys = @tape.keys.map{|x| x.to_i}.sort.map{|x| x.to_s}

		#use the sorted keys to index the tape
		sorted_keys.each do |key|
			print "#{@tape[key].value}|" unless @tape[key].being_read
			print "#{@tape[key].value}*|" if @tape[key].being_read
		end

		puts ""
	end

	#Run the instruction set
	def run
		while @current_state != @final_state do
			#if the reading head is at a new cell, create the cell
			unless @tape.has_key? @reading_head.to_s
				@tape[@reading_head.to_s] = Cell.new({value: "e", being_read: false})
			end
			
			#set the variable that is being read (for display purposes)
			@tape[@reading_head.to_s].being_read = true
			
			print_tape
			
			#get instructions for the current state
			state = @transition_table[@current_state]
			puts "Current state is #{@current_state}" if @verbose
			
			#read
			read_value = @tape[@reading_head.to_s].value.to_s
			if @option == "1"
				case read_value
				when "0"
					read_value = 0
				when "1"
					read_value = 1
				when "a"
					read_value = 2
				when "b"
					read_value = 3
				when "e"
					read_value = 4
				when "i"
					read_value = 5
				when "n"
					read_value = 6
				when "x"
					read_value = 7
				when "z"
					read_value = 8
				end
			else
				case read_value
				when "0"
					read_value = 0
				when "1"
					read_value = 1
				when "2"
					read_value = 2
				when "3"
					read_value = 3
				when "a"
					read_value = 4
				when "b"
					read_value = 5
				when "e"
					read_value = 6
				when "i"
					read_value = 7
				when "n"
					read_value = 8
				when "x"
					read_value = 9
				when "y"
					read_value = 10
				when "z"
					read_value = 11
				end
			end

			state = state[read_value.to_i]
	
			puts "Just read a(n) #{read_value}" if @verbose
	
			#write
			@tape[@reading_head.to_s].value = state["write"]
	
			puts "Just wrote a(n) #{state["write"]}" if @verbose
	
			#The value is no longer being read
			@tape[@reading_head.to_s].being_read = false
	
			#move
			if state["direction"] == "r"
				move_right
				puts "Just moved right" if @verbose
			else
				move_left
				puts "just moved left" if @verbose
			end
	
			#update state
			@current_state = state["next_state"]
			puts "Just updated state to #{@current_state}" if @verbose
			puts "-------------------------------------------" if @verbose
		end
		print_tape
	end

	private

	#set each Cell of the tape to the respective character in "value"
	def set_tape(value)
		tape = Hash.new
		value.split("").each_with_index do |value, i|
			#TODO use Cell here
			tape[i.to_s] = Cell.new({value: value, being_read: false})
		end
		
		tape
	end

	#read the transition file
	def load_transitions(filename)
		file = File.read(filename)
		JSON.parse(file)
	end

	#move right
	def move_right
		@reading_head += 1
	end

	#move left
	def move_left
		@reading_head -= 1
	end
end