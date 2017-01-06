
#require 'fileutils'

class MyFile
  attr_accessor :permissions, :thing, :owner, :group, :size, :day, :month, :time, :file

  def initialize path
    res = %x{ls -l "#{path}"}.chomp
    @permissions, @thing, @owner, @group, @size, @day, @month, @time, @file = res.split
  end

end

main_path = '/Volumes/Shared/Training/Public Training/New Courses'
backup_path = '/Volumes/Restored-Share/Shared/Training/Public Training/New Courses'

Dir[File.join(main_path,"**","*.*")] .each do |file|
  puts "file:#{file}"
  f = MyFile.new(file)
  # if f.owner !
  puts f.owner
end

