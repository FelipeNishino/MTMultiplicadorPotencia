# Fonte: https://github.com/westonkd/Turing-Machine

=begin
A simple program to exercise the TuringMachine class.
Execution begins at the bottom of the file
=end

require 'json'
require_relative './Cell.rb'
require_relative './TuringMachine.rb'

=begin
   Cell
   Used as a cell by TuringMachine class
   @value: the value in the cell
   @being_read: a boolean value indicating if the head is at the cell
=end

=begin
   TuringMachine
   A class that simulates a Turing machine.
   This class simulates a Turing machine, reading instructions from a
   specified JSON file (See div.json for an example progam of dividing by 2).
   @verbose: boolean value. If set to true the full config history is outputed
      during execution.
   @tape: A hash with the cell position as keys (beginning at 0) and a Cell as
      value. Note that the keys are string representations of integers. This
      allows indexing by "-3" or any negative value for an easy tape implementation.
      Empty cells are denoted with the 'e' character.
   @reading_head: An integer representing the current position of the read/write head.
      This variable may be negative or positive.
   @transition_table: A hash representation of the JSON instructions. Indexing this hash
      by an integer value returns the relevant state info (i.e.
      @transition_table[1] returns the instructions for state 1). Indexing this returned
      value by an integer returns the correct instructions for when the machine reads
      that index on the tape (i.e. @transitino_table[1][0] returns the instructions
      for what the machine should do in state 1 when a 0 is read from the tape).
      See 'div.json' for to see how JSON is formatted.
   @current_state: An integer value indicating the current state of the machine.
   @final_state: An integer value indicating the halt state.
=end

puts "Qual operação você deseja calcular? 1 - Multiplicação, 2 - Potência"
option = gets.chomp()
puts "Digite o input:"
input = gets.chomp()

#BEGIN EXECUTION HERE
#specify initial tape value and instruction file
tm = TuringMachine.new(input, (option == "1" ? "multi.json" : "power.json"))

#output configuration history
tm.verbose = false
tm.option = option

#run the instruction set
tm.run

# multi - 0011
# pot - 10011