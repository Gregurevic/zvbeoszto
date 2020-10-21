class Schedule < ApplicationRecord

  def schedule
    #sanity
    Schedule.delete_all
    #model
    m = Cbc::Model.new
    #variables
    instructors = Instructor.all.to_a
    i_c = instructors.count
    inst = []

    for i in 0..(ts - 1)
      inst << m.bin_var_array(i_c, names: (0..(i_c - 1)).to_a.map{ |x| "TS#{i}I" + x.to_s })
    end

    #constraints
    ## maximum of five instructors
    for i in 0..(ts - 1)
      m.enforce(inst[i].inject(0, :+) <= 5)
    end


    #objective
    m.minimize(  )

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