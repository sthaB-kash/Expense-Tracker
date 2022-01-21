require_relative './database_connection';
require_relative './signup'
require_relative './login'
require 'io/console'

class ExpenseTracker
  
  attr_accessor :con

  def initialize
    if @con = DatabaseConnection.new.con
      puts "connection success"
      system("clear")
      start_app()
    else
      puts "Database connection error!"
      readline()
    end
  end

  private

  def start_app()
    begin
      options = [[ 1, 'Signup'], [2, 'Login'], [3, 'Exit']]
      puts "*" * 45, "", "Welcome to Expense Tracker CLI Application".upcase, "", "*" * 45, ""
      puts "Please select an option:>"

      options.each{ |option|
        puts "%d. %s" % [option[0], option[1]]
      }
      
      print "\nEnter Option:> "
      input = gets.chomp.to_i

      case(input)
        when 1
          Signup.new(@con)
        when 2
          Login.new(@con)
        when 3
          @con.close()
          puts "Thank you"
          # sleep(2)
          puts STDIN.getch
        else
          puts "please select a valid option"
          STDIN.getch
      end

      system("clear")

    end while(input != 3)
  end

end


app = ExpenseTracker.new