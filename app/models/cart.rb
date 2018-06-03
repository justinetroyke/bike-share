class Cart
  attr_reader :contents

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

  def remove_accessory(accessory_id)
    @contents.delete(accessory_id)
  end

  def decrease_item_count(accessory_id)
    @contents[accessory_id] -= 1
  end
  def accessory_count(id)
    @contents[id]
  end

  def subtotal(accessory)
    @contents[accessory.id.to_s] * accessory.price
  end

  def total_amount
    contents.map do |accessory_id, quantity|
      Accessory.find(accessory_id).price * quantity
    end.sum
  end
end
