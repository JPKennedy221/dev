alias StudentPerformanceAnalytics.Repo
alias StudentPerformanceAnalytics.Accounts.Teacher
alias StudentPerformanceAnalytics.Classes.Class
alias StudentPerformanceAnalytics.Students.Student
alias StudentPerformanceAnalytics.Units.Unit
alias StudentPerformanceAnalytics.Standards.Standard
alias StudentPerformanceAnalytics.Assessments.{AssessmentType, Assessment}

# Clear existing data
Repo.delete_all(Assessment)
Repo.delete_all(Student)
Repo.delete_all(Class)
Repo.delete_all(Standard)
Repo.delete_all(Unit)
Repo.delete_all(Teacher)
Repo.delete_all(AssessmentType)

# Seed Teachers
teacher1 = %Teacher{
  name: "Alice Johnson",
  email: "alice@example.com",
  password_hash: Bcrypt.hash_pwd_salt("password123")
} |> Repo.insert!()

teacher2 = %Teacher{
  name: "Bob Smith",
  email: "bob@example.com",
  password_hash: Bcrypt.hash_pwd_salt("password123")
} |> Repo.insert!()

# Seed Classes
class1 = %Class{
  name: "Math 101",
  year: 2024,
  teacher_id: teacher1.id
} |> Repo.insert!()

class2 = %Class{
  name: "Science 101",
  year: 2024,
  teacher_id: teacher2.id
} |> Repo.insert!()

# Seed Students
student1 = %Student{
  name: "John Doe",
  is_active: true,
  class_id: class1.id
} |> Repo.insert!()

student2 = %Student{
  name: "Jane Smith",
  is_active: true,
  class_id: class1.id
} |> Repo.insert!()

student3 = %Student{
  name: "Mike Brown",
  is_active: true,
  class_id: class2.id
} |> Repo.insert!()

# Seed Units
unit1 = %Unit{
  title: "Algebra Basics"
} |> Repo.insert!()

unit2 = %Unit{
  title: "Biology Introduction"
} |> Repo.insert!()

# Seed Standards
standard1 = %Standard{
  description: "Understand basic algebraic concepts",
  unit_id: unit1.id
} |> Repo.insert!()

standard2 = %Standard{
  description: "Solve linear equations",
  unit_id: unit1.id
} |> Repo.insert!()

standard3 = %Standard{
  description: "Understand cell structure",
  unit_id: unit2.id
} |> Repo.insert!()

# Seed Assessment Types
pre_test = %AssessmentType{name: "Pre-Test"} |> Repo.insert!()
progress_check = %AssessmentType{name: "Progress Check"} |> Repo.insert!()
unit_test = %AssessmentType{name: "Unit Test"} |> Repo.insert!()

# Seed Assessments
%Assessment{
  student_id: student1.id,
  class_id: class1.id,
  unit_id: unit1.id,
  assessment_type_id: pre_test.id,
  question_number: 1,
  score: 2
} |> Repo.insert!()

%Assessment{
  student_id: student1.id,
  class_id: class1.id,
  unit_id: unit1.id,
  assessment_type_id: progress_check.id,
  question_number: 2,
  score: 3
} |> Repo.insert!()

%Assessment{
  student_id: student2.id,
  class_id: class1.id,
  unit_id: unit1.id,
  assessment_type_id: unit_test.id,
  question_number: 1,
  score: 1
} |> Repo.insert!()

%Assessment{
  student_id: student3.id,
  class_id: class2.id,
  unit_id: unit2.id,
  assessment_type_id: progress_check.id,
  question_number: 3,
  score: 2
} |> Repo.insert!()

IO.puts("Seed data inserted successfully!")
