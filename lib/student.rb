require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      )"
      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.create(student)
    # binding.pry
    self.create_table
    new_student = Student.new(student[:name], student[:grade])
    new_student.save
    new_student
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?,?)"
    new_student = DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    new_student
  end

  # def self.save(name, type, db)
  #   saved_pokemon = db.execute("INSERT INTO Pokemon (name, type) VALUES (?, ?)", name, type)
  #
  #   # binding.pry
  # end

end
