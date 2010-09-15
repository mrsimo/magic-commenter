# -*- encoding: utf-8 -*-
require 'stringio'
require 'open3'

module Magic
  class Commenter

    include Open3

    def initialize(files)
      for file in files
        errors = []
        puts ". checking #{file}"
        unless File.readlines(file).first.include?("encoding: utf-8")
          stdin, stdout, stderr = popen3("ruby -c #{file}")
          errors = stderr.read

          if errors.include?("invalid multibyte char")
            puts ">> Fixing #{file}"
            add_magic_comment(file)
          end
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
