class Cart

  def initialize(data = nil)
    if data
      @contents = data['contents']
      @contents.default = 0
    else
      @contents = Hash.new(0)
    end
  end

  def total_count
    @contents.values.sum if @contents
  end

  def add_accessory(accessory_id)
    @contents[accessory_id] += 1
  end

  def accessory_count(id)
    @contents[id]
  end
end
