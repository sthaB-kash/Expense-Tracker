class TransactionsHistory
  attr_accessor :con, :user

  def initialize(con, user)
    @con, @user  = con, user
    display_menu()
  end

  private 
  
  def display_menu
    system("clear")
    [[1, 'All Transactions'], [2, 'Incomes only'], [3, 'Expenses only']].each do |menu| 
      puts "%s. %s" % [menu[0], menu[1]]
    end
    print "Select an options:> "
    option = gets.chomp.to_i
    case option
      when 1
        list_transactions("all")
      when 2 
        list_transactions("income")
      when 3 
        list_transactions("expense")
      else
        puts "invalid option"
    end
    readline
  end

  def list_transactions(type)
    query0 = type == "all" ? ";" : "and category = '#{type}';"
    query = "SELECT * FROM users INNER JOIN transactions ON users.id = transactions.uid WHERE transactions.uid = '#{@user['id']}' #{query0} "
    begin
      list = @con.exec(query)
      if list 
        list.each do |tnx| 
          puts tnx
        end
      end
    rescue => exception
      puts exception.message
    end
  end

end
