class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          route_manager_action
        else
          route_delivery_guy_action
        end
      end
      print `clear`
    end
  end

  private

  def route_manager_action
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    manager_action(choice)
  end

  def route_delivery_guy_action
    print_delivery_guy_menu
    choice = gets.chomp.to_i
    print `clear`
    delivery_guy_action(choice)
  end

  def print_manager_menu
    puts "--------------------"
    puts "---- 🍕 MENU 🚚 ----"
    puts "--------------------"
    puts "\n-- Meal menu 🍽"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "\n-- Customer menu 🙋‍♀️"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "\n-- Order menu 🚚"
    puts "5. List all undelivered orders"
    puts "6. Add new order"
    puts "7. Log out"
    puts "\n8. Exit"
    print "> "
  end

  def print_delivery_guy_menu
    puts "--------------------"
    puts "---- 🍕 MENU 🚚 ----"
    puts "--------------------"
    puts "\n-- Meal menu 🍽"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "\n-- Customer menu 🙋‍♀️"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "\n-- Order menu 🚚"
    puts "5. List undelivered orders"
    puts "6. Mark an order as delivered"
    puts "7. Log out"
    puts "\n8. Exit"
    print "> "
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.list_undelivered
    when 6 then @orders_controller.add
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def delivery_guy_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then puts "TODO"
    when 6 then puts "TODO"
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
