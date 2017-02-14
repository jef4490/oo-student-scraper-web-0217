class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # binding.pry
    self.name = student_hash[:name]
    self.location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student = Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      # binding.pry
      # self.send("#{key.to_s}= ('#{value}')")
      # self.send("#{key.to_s}= ")
      self.send("#{key}=", value)

    end
  end

  def self.all
    @@all
  end
end
