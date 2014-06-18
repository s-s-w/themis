# project_lines_of_code

total_lines_of_code = 0

file_count = 0
lines_of_code = 0

puts

file_paths = []
file_paths << "app/Gemfile"
Dir["app/assets/javascripts/**"].each { |path| file_paths << path unless path.include? 'foundation' }
Dir["app/controllers/**/**"].each { |path| file_paths << path }
Dir["app/helpers/**"].each { |path| file_paths << path }
Dir["app/mailers/**"].each { |path| file_paths << path }
Dir["app/models/**/**"].each { |path| file_paths << path }
Dir["app/views/**/**"].each { |path| file_paths << path }
file_paths << "config/routes.rb"
file_paths << "db/seeds.rb"
Dir["db/migrate/**"].sort.each { |path| file_paths << path }
Dir["lib/**/**"].sort.each { |path| file_paths << path }
Dir["test/**/**"].sort.each { |path| file_paths << path }

# Calculate Total Lines Of Code first
for path in file_paths
  if File.file?(path) and not path.include?('.svn') and not path.include?('~')
    File.open(path, 'r') do |file|
      total_lines_of_code += file.readlines.size
    end
  end
end

# Line Entries
for path in file_paths
  if File.file?(path) and not path.include?('.svn') and not path.include?('~')
    File.open(path, 'r') do |file|
      file_count += 1
      lines = file.readlines
      lines_of_code += lines.size
      puts "#{sprintf("%5d", lines_of_code)} #{sprintf("%5.1f", lines_of_code.to_f / total_lines_of_code.to_f * 100.0)}%  #{sprintf("%4d", lines.size)}  #{sprintf("%4.2f", lines.size.to_f / total_lines_of_code.to_f * 100.0)}%  #{sprintf("%5.1f", lines.size.to_f / 50)}  #{path}"
    end
  end
end

puts '-----        -----         -----  ------------'
puts " cum         #{sprintf("%5d", lines_of_code)}         #{sprintf("%5.1f", lines_of_code / 50)}  #{file_count}"
puts '             lines         pages  files'
puts
