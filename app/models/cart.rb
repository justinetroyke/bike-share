class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    contents.values.sum
  end

  def add_accessory(accessory)
    accessory_id = accessory.id.to_s
    if @contents[accessory_id]
      @contents[accessory_id] += 1
    else
      @contents[accessory_id] = 1
    end
  end

  def accessory_count(id)
    @contents[id]
  end
end
