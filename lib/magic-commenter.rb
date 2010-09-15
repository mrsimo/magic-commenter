# -*- encoding: utf-8 -*-
require 'stringio'
require 'open3'

module Magic
  class Commenter

    include Open3

    def initialize(files)
      files.sort!

      threads = []

      2.times do |i|
        threads << Thread.new do
          while(file = files.shift)
            puts "Thread-#{i}: checking #{file}"
            firstline = File.readlines(file).first
            if firstline && !firstline.include?("encoding: utf-8")
              stdin, stdout, stderr = popen3("ruby -c #{file}")
              errors = stderr.read

              if errors && errors.include?("invalid multibyte char")
                puts ">> Fixing #{file}"
                contents = "# -*- encoding: utf-8 -*-\n" + File.read(file)
                File.open(file,"w") do |f|
                  f.write contents
                  f.close
                end
              end
            end
          end
        end
      end

      threads.each(&:join)
    end

  end
end
