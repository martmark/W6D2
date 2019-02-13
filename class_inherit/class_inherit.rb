class Employee
    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        unless @boss.nil?
            @boss.employees << self
        end
    end

    def bonus(multiplier)
        salary * multiplier  
    end

    protected
    attr_reader :salary, :boss

end


class Manager < Employee
   
    def initialize(name, title, salary, boss)
        super(name, title, salary, boss)
        @employees = []
    end

    def bonus(multiplier)
        sum = 0
        queue = employees.dup
        until queue.empty?
            current = queue.shift
            sum += current.salary
            queue.concat(current.employees) if current.is_a?(Manager)
        end
        sum * multiplier
    end

    attr_accessor :employees
end


ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000