require 'csv'
require_relative 'meal_repository'
require_relative 'customer_repository'

class OrderRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @orders = []
    load_csv
  end


  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:meal] = MealRepository.find(row[:meal])
      row[:customer] = CustomerRepository.find(row[:customer])
      @orders << Order.new(row)
    end
  end

end
