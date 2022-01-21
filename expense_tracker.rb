require_relative './database_connection';

class ExpenseTracker
  
  attr_accessor :con

  def initialize
    if @con = DatabaseConnection.new
      puts "connection success"
      system("clear")
      start_app()
    else
      puts "Database connection error!"
      readline
    end
  end

  private

  def start_app
    options = [[ 1, 'Signup'], [2, 'Login'], [3, 'Exit']]
    puts "*" * 45, "", "Welcome to Expense Tracker CLI Application".upcase, "", "*" * 45, ""
    puts "Please select an option:>"
    options.each{ |option|
      puts "%d. %s" % [option[0], option[1]]
    }
  end

end


app = ExpenseTracker.new