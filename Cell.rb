class Cell
   attr_accessor :value
   attr_accessor :being_read

   def initialize(settings_hash)
      @value = settings_hash[:value]
      @being_read = settings_hash[:being_read]
   end
end