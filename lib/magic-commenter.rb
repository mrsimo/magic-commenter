# -*- encoding: utf-8 -*-
require 'stringio'
require 'open3'

module Magic
  class Commenter

    include Open3

    def initialize(files)
      for file in files
        errors = []
        popen3("ruby -c #{file}") do |stdin, stdout, stderr|
          errors = stderr.read.split("\n")
        end

        if errors.any?{|error| error.include?("invalid multibyte char")}
          puts ">> Fixing #{file}"
          add_magic_comment(file)
        end
      end
    end

    def add_magic_comment(file)
      contents = "# -*- encoding: utf-8 -*-\n" + File.read(file)
      File.open(file,"w") do |f|
        f.write contents
        f.close
      end
    end

  end
end
