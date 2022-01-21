
class Login

  attr_accessor :username, :pw

  def initialize(con)
    system("clear")
    puts "", "login".upcase, "*" * 40, ""
    print "Enter your username: "
    @username = gets.chomp
    print "Enter your password: "
    @pw = gets.chomp
    check_credentials(con)
  end

  private 

  def check_credentials(con)
    query = "SELECT uname, pw FROM users WHERE uname = '%s';" % [@username]
    begin
      if con.exec(query)[0]['pw'] == pw
        puts "logged in"
      else
        puts "Username or password invalid!"
      end
    rescue => exception
      puts "user not found or something went wrong!"
    end
    readline()
  end 

end