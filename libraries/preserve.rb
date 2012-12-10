def preserve (source_file = nil, destination_file = nil)
  if !node['nginx']['preserve_files'] || destination_file.nil?
    return false
  end

  exists  = File.exists? destination_file

  if exists && node['nginx']['preserve_files'] && !source_file
    return true
  end

  if exists && `diff #{destination_file} #{destination_file} -qN`.empty?
    return false
  end

  return true
end