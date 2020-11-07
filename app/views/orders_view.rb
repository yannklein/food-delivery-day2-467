class OrdersView
  def display_orders(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.meal.name} | Customer: #{order.customer.name} by #{order.employee.username}"
    end
  end

  def ask_for_index
    puts "Id?"
    gets.chomp.to_i - 1
  end
end
