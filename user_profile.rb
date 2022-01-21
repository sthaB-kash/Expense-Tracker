require 'io/console'

class UserProfile
  attr_accessor :con, :user
  def initialize(con, user)
    @con = con
    @user = user
    user_menu()
  end

  private

  def display_user_info()
    system("clear")
    puts "", "*" * 50, "", "expense tracker cli application".upcase, "      (#{user["name"].upcase})", "", "*" * 50, ""
    puts "Income: \nExpense: \nBalance: ", "", "*" * 50, ""
  end

  def user_menu
    begin
      display_user_info()
      [
        [1, "Add New Transaction(Income)"], 
        [2, "Add New Transaction(Expense)"], 
        [3, "View Transaction History"],
        [4, "Logout"]
      ].each do |option|
        puts "%s. %s" % [option[0], option[1]]
      end
      print "\nSelect an option:> "
      choice = gets.chomp.to_i
      case choice
        when 1
          insert_tnx('income')
        when 2
          insert_tnx('expense')
        when 3
          list_tnx()
        when 4
          ;
        else
          puts "invalid option" 
          STDIN.getch
      end
    end while(choice != 4)
  end

  def insert_tnx(category)
    puts "", "Enter the following details of a transaction(#{category}):"
    print "Name: "
    name = gets.chomp
    print "Amount: "
    amount = gets.chomp.to_f
    query = "INSERT INTO %ss(uid, tnx_name, tnx_amount) VALUES('%d', '%s', '%s');" % [category,user['id'], name, amount]
    puts query, "remaining task"
    STDIN.getch
  end

  def list_tnx
    puts "here comes a list of transactions"
    STDIN.getch
  end
end