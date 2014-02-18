module Jetpants

  # This mixin defines an output function that includes class, and optionally
  # caller file, method and line number if output_file_data is set.
  module Output
    def self.included(base)
      base.class_eval do
        define_method "output" do |str, table=nil|
          str = str.to_s.strip
          str = nil if str && str.length == 0
          str ||= "Completed (no output)"
          output = Time.now.strftime("%H:%M:%S") + " [#{self}] "
          output << "called from #{caller[0]} " if Jetpants.output_caller_info
          output << table.name << ': ' if table
          output << str
          print output + "\n"
          output
        end
      end
    end
  end
end
