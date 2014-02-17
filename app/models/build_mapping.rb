class BuildMapping
  attr_initialize :from, :to
  attr_reader :from, :to

  def self.build_list(data)
    data.to_s.split("\r\n").map { |mapping_line|
      from, to = mapping_line.split('=')
      BuildMapping.new(from, to)
    }
  end
end
