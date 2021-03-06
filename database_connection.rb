require 'pg'

class DatabaseConnection
  attr_accessor :con
  def initialize
    begin
      @con = PG.connect :dbname => 'expense_tracker', :user => 'bikash'
    rescue => exception
      puts exception.message
    ensure
      if @con
        puts "Connected to database"
      else
        puts "fail to connect to the database"
      end
    end
  end
end