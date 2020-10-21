class Schedule < ApplicationRecord

  def schedule
    #sanity
    Schedule.delete_all
    #model
    m = Cbc::Model.new
    #variables
    instructors = Instructor.all.pluck(:can_be_president, :can_be_secretary, :can_be_member, :presence).map{ |a, b, c, d| { president: a, secretary: b, member: c, presence: d } }
    instructors.each do |i|
      temp = i[:presence].split('')
      i[:presence] = []
      temp.each do |ip|
        i[:presence] << (ip == 'x') ? true : false
      end
    end
    ts = Student.count
    i_c = instructors.count
    inst = Array.new(ts){Array.new(i_c)}

    for i in 0..(ts - 1)
      for j in 0..(i_c - 1)
        inst[i][j] = m.bin_var(name: "TS#{i}I#{j}")
      end
    end

    #constraints
    ## maximum of five instructors
    for i in 0..(ts - 1)
      m.enforce(inst[i].inject(0, :+) <= 5)
    end


    #objective
    temp = 0
    for i in 0..(ts - 1)
      for j in 0..(i_c - 1)
        if !instructors[j][:presence][i]
          temp += 1000 * inst[i][j]
        end
      end
    end

    m.minimize( temp )

    #solving
    problem = m.to_problem
    problem.solve
    
    byebug
    #proven solvable
    if problem.proven_infeasible?
      return false
    end

    #write
    #Schedule.create(problem.value_of(#{var}))

    #return
    return problem.objective_value
  end

end