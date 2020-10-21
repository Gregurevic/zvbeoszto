class Schedule < ApplicationRecord

  def schedule
    #sanity
    Schedule.delete_all
    #model
    m = Cbc::Model.new
    #variables
    instructors = Instructor.all.pluck(:can_be_president, :can_be_secretary, :can_be_member, :presence).map{ |a, b, c, d| { president: a, secretary: b, member: c, presence: d } }
    instructors.each do |i|
      i[:presence] = i[:presence].split('')
      i[:presence].each do |ip|
        ip = (ip == 'x') ? true : false
      end
    end
    byebug
    i_c = instructors.count
    inst = []

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
        if !instructors[i].presence[j] && inst[i][j] == 1
          temp += 1000
        end
      end
    end

    m.minimize( temp )

    #solving
    problem = m.to_problem
    problem.solve

    #proven solvable
    if problem.proven_infeasible?
      return false
    end

    #write
    #Schedule.create(problem.value_of(#{var}))

    #return
    return problem.objective_value
    byebug
  end

end