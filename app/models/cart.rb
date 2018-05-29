class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    contents.values.sum
  end

  def add_item(item)
    item_id = item.id.to_s
    if @contents[item_id]
      @contents[item_id] += 1
    else
      @contents[item_id] = 1
    end
  end

  def item_count(id)
    @contents[id]
  end
end
