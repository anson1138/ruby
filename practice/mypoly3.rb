class Base
  def initialize
    @base_pay = 1000
  end
end

class Employee < Base
  def calculate_pay
    amount = @base_pay + 100
    return amount
  end
end

class Manager < Base
  def calculate_pay
    amount = @base_pay + 1000
    return amount
  end
end

def get_pay(employee_type)
  amount = employee_type.calculate_pay
  puts amount
end

def main
  amount = get_pay(Employee.new)
  amount = get_pay(Manager.new)
end

main
