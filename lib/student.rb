class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    
    new_student = Student.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
    
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    
    sql = "SELECT * FROM students"
    row = DB[:conn].execute(sql)
    
    row.map do |student|
      new_student = Student.new
      new_student.id = student[0]
      new_student.name = student[1]
      new_student.grade = student[2]
    end
    
    binding.pry

    
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    
    sql = "SELECT * FROM students WHERE name = ?"
    row = DB[:conn].execute(sql, name).flatten
    new_student = Student.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
    
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  
  
  
  
  
  
  
  
  
  
end
