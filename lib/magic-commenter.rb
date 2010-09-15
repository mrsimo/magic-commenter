module Magic
  module Commenter
    class << self

      def initialize(files)
        for file in files
          puts `ruby -c #{file}`
        end
      end
    end
  end
end
