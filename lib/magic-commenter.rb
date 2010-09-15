module Magic
  class Commenter

    def initialize(files)
      for file in files
        result = `ruby -c #{file}`.strip
        if result != "Syntax OK"
          if result.include?("invalid multibyte char")
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
