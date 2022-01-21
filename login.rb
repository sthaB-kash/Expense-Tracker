require_relative './user_profile'

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
    query = "SELECT * FROM users WHERE uname = '%s';" % [@username]
    begin
      user = con.exec(query) 
      if user[0]['pw'] == pw
        UserProfile.new(con, user[0])
      else
        puts "Username or password invalid!"
        sleep(2)
      end
    rescue => exception
      puts "user not found or something went wrong!"
      puts exception.message
      sleep(2)
    end
  end 
end