module MocMock
  class ViewHelper
    def self.prettry_json(str)
      nest = 0
      lines = []
      line = ""
      nester = "&nbsp;" * 5

      str.chars.each do |c|
        if %w([ {).include? c
          lines << line + c
          nest += 1
          line = nester * nest
        elsif %w(] } ).include? c
          lines << line if line.gsub(nester, "") != ""
          nest -= 1
          lines << nester * nest + c
          line = nester * nest
        elsif c == ","
          if line.gsub(nester, "") == ""
            lines << ","
          else
            lines << line + ","
          end
          line = nester * nest
        else
          c = " : " if c == ":"
          line += c
        end
      end

      result = lines * "<br>"

      result.gsub("<br>,", ",")
    end
  end
end
