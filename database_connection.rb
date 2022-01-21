require 'pg'

class DatabaseConnection

  def initialize
    begin
      @con = PG.connect :dbname => 'expense_tracker', :user => 'bikash'
    rescue => exception
      puts exception.message
    ensure
      if @con
        puts "Connected to database"
        return @con
      else
        puts "fail connect to database"
      end
    end
  end
  
end