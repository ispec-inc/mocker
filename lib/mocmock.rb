require_relative "./mocmock/version"
require 'fileutils'

module MocMock
  class Error < StandardError; end
  INVENTORY= "inventory"

  def self.init(dir)
    FileUtils.mkdir_p(dir)

    Dir.glob("#{INVENTORY}/**/*").each do |f|
      nf = f.sub(INVENTORY, "")
      File.ftype(f) == "file" ?
        FileUtils.cp(f, "#{dir}/#{nf}") :
        FileUtils.mkdir_p("#{dir}/#{nf}")
    end
  end
end
