require_relative '../views/orders_view'
require_relative '../views/customers_view'
require_relative '../views/meals_view'
require_relative '../views/sessions_view'
require_relative '../models/order'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @sessions_view = SessionsView.new
    @customers_view = CustomersView.new
  end

  def list_undelivered
    # get the undelivered orders from OrderRepo (array of all the undelievered orders =instances)
    orders = @order_repository.undelivered_orders
    # display the list of orders in the View
    @orders_view.display_orders(orders)
  end

  def add
    # get the meals from MealRepository
    meals = @meal_repository.all
    # display it to the user (MealsView)
    @meals_view.display(meals)
    # ask for index
    index = @orders_view.ask_for_index
    # store the selected meal in a variable
    meal = meals[index]
    p meal

    # get the customers from customerRepository
    customers = @customer_repository.all
    # display it to the user (customersView)
    @customers_view.display(customers)
    # ask for index
    index = @orders_view.ask_for_index
    # store the selected customer in a variable
    customer = customers[index]
    p customer

    # get the employees from employeeRepository
    employees = @employee_repository.all_delivery_guys
    # display it to the user (employeesView)
    @sessions_view.display(employees)
    # ask for index
    index = @orders_view.ask_for_index
    # store the selected employee in a variable
    employee = employees[index]
    p employee

    # create an order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # save it it (OrderRepo)
    @order_repository.create(order)
    # show the list of orders
    list_undelivered
  end
end
