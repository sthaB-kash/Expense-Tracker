class Signup
  
  attr_accessor :name, :username, :pw

  def initialize(con)
    system("clear")
    puts  "", "Signup", "*" * 50, ""
    print "Enter your name: "
    @name = gets.chomp
    print "Enter your username: "
    @username = gets.chomp
    print "Enter your password: "
    @pw = gets.chomp 
    create_user(con) 
  end

  private

  def create_user(con)
    query = "INSERT INTO users(name, uname, pw) VALUES('%s', '%s', '%s');" % [@name, @username, @pw]
    if con.exec(query)
      puts "User Created Successfully."
    else
      puts "Something went wrong!"
    end
    readline()
  end


end