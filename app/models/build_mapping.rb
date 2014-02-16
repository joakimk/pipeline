class BuildMapping
  pattr_initialize :from, :to
  attr_reader :from, :to

  def self.build_list(data)
    data.split("\r\n").map { |mapping_line|
      from, to = mapping_line.split('=')
      BuildMapping.new(from, to)
    }
  end

  def apply(build)
    if build.name == from
      build.name = to
    end
  end
end
