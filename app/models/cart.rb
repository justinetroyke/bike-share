class Cart
  attr_reader :contents

  def initialize(data = Hash.new(0))
    @contents = data
  end

  def total_count
    @contents.values.sum if @contents
  end

  def add_accessory(accessory)
    accessory_id = accessory.id.to_s
    if @contents && @contents[accessory_id]
      @contents[accessory_id] += 1
    end
  end

  def accessory_count(id)
    @contents[id]
  end
end
