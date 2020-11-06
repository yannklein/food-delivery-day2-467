class Order
  def initialize(attributes = {})
    @id = attributes[:id]
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @delivered = false
  end

  def delivered!
    @delivered = true
  end
end
