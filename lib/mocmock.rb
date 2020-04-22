require_relative "./mocmock/version"
require 'fileutils'

module MocMock
  class Error < StandardError; end

  def self.init(dir)
    FileUtils.mkdir_p(dir)
    FileUtils.cp_r("inventory", dir)
  end
end
