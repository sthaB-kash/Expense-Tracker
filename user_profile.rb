require 'io/console'
require_relative './transactions_history'

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
        [4, "Update Transaction"],
        [5, "Logout"]
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
          update_transaction()
        when 5
          ;
        else
          puts "invalid option" 
          STDIN.getch
      end
    end while(choice != 5)
  end

  def insert_tnx(category)
    puts "", "Enter the following details of a transaction(#{category}):"
    print "Name: "
    name = gets.chomp
    print "Amount: "
    amount = gets.chomp.to_f
    query = "INSERT INTO transactions(uid, tname, amount, date, category) VALUES('%d', '%s', '%f', '%s', '%s');" % [@user['id'], name, amount, Time.now, category]
    begin
      if @con.exec(query)
        puts "Record inserted successfully"
      end
    rescue => exception
      puts exception.message
    end
    
    STDIN.getch
  end

  def list_tnx
    TransactionsHistory.new(@con, @user)
  end

  def update_transaction
    display_user_info()
    print "Enter transaction id:> "
    tid = gets.chomp
    puts "", "Enter the following details of transaction:"
    print "Name: "
    name = gets.chomp
    print "Amount: "
    amount = gets.chomp
    query = "UPDATE transactions set tname = '%s', amount = '%s', updated_at = '%s' WHERE tid='%s' and uid = '%s';" % [name, amount, Time.now, tid, @user['id']]
    begin
      @con.exec(query)
    rescue => exception
      puts exception.message
    else
      puts "Updated Successfully."
    end
    STDIN.getch
  end
end