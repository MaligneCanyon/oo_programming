class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    # quantity = updated_count if updated_count >= 0 # quantity is a local var here
    self.quantity = updated_count if updated_count >= 0 # must call setter using 'self'
  end

  # private # def attr_writer as private to maintain the public interface
  attr_writer :quantity # could use this to fix the issue (below)
end

entry = InvoiceEntry.new("rabbits", 10)

entry.update_quantity(12)
p entry # => #<InvoiceEntry:0x00000000ecf518 @quantity=12, @product_name="rabbits">
puts entry.quantity # 12

entry.update_quantity(-2)
p entry
puts entry.quantity # 12

entry.update_quantity(10)
p entry
puts entry.quantity # 10

# we have altered the public interface, allowing @quantity to be modified
# directly; circumnavigates the update_quantity method; potentially dangerous
entry.quantity = 7
p entry
puts entry.quantity # 7
