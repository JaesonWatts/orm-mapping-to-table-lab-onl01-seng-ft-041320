class Student

  attr_accessor :name, :grade
  attr_reader :id
  
  def intialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  def self.create_table
    sql = ""
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
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
