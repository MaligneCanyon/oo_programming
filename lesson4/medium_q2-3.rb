class InvoiceEntry
  # attr_reader :quantity, :product_name
  attr_reader :product_name
  attr_accessor :quantity # could use this to fix the issue (below)

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    # quantity = updated_count if updated_count >= 0 # quantity is a local var here
    self.quantity = updated_count if updated_count >= 0
  end
end

entry = InvoiceEntry.new("rabbits", 10)

entry.update_quantity(12)
p entry # => #<InvoiceEntry:0x00000000ecf518 @quantity=12, @product_name="rabbits">
puts entry.quantity # 12

entry.update_quantity(-2)
p entry
puts entry.quantity # 12

# we have altered the public interface, allowing @quantity to be modified directly;
# circumnavigates the update_quantity method; potentially dangerous
entry.quantity = 7
p entry
puts entry.quantity # 7
