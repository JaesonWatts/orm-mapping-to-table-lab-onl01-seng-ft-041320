class Student

  attr_accessor :name, :grade
  attr_reader :id
  
  # def intialize(name, grade, id=nil)
  #   @name = name
  #   @grade = grade
  #   @id = id
  # end
   def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT"
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)  
  end
  
  def save
   if @id
      sql = "UPDATE students SET name = ? WHERE id = ?"
      DB.execute(sql, self.name, self.id)
    else
      sql = "INSERT INTO students (name) VALUES (?)"
      DB.execute(sql, self.name)
      @id = DB.execute("SELECT last_insert_rowid() FROM students")[0][0]
    end
  end
  
  
end
