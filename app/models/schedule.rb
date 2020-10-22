class Schedule < ApplicationRecord

  def schedule
    #sanity
    Schedule.delete_all

    #model
    m = Cbc::Model.new

    #variables
    ## students
    students = Student.all.pluck(:name, :instructor_id, :course_id).map{ |a, b, c| { name: a, instructor_id: b, course_id: c } }
    ts = s_c = students.count
    stud = Array.new(ts){Array.new(s_c)}
    for i in 0..(ts - 1)
      for j in 0..(s_c - 1)
        stud[i][j] = m.bin_var(name: "TS#{i}S#{j}")
      end
    end

    ## instructors
    instructors = Instructor.all.pluck(:id, :name, :can_be_president, :can_be_secretary, :can_be_member, :presence).map{ |a, b, c, d, e, f| { id: a, name: b, can_be_president: c, can_be_secretary: d, can_be_member: e, presence: f } }
    instructors.each do |i|
      temp = i[:presence].split('')
      i[:presence] = []
      temp.each do |ip|
        i[:presence] << (ip == 'x') ? true : false
      end
      i[:courses] = Examiner.where(instructor_id: i[:id]).pluck(:course_id)
    end
    i_c = instructors.count
    inst = Array.new(ts){Array.new(i_c)}
    for i in 0..(ts - 1)
      for j in 0..(i_c - 1)
        inst[i][j] = m.bin_var(name: "TS#{i}I#{j}")
      end
    end

    #constraints
    ## maximum of five instructors
    ## exactly one president in every slot
    ## exactly one secretary in every slot
    ## exactly one member in every slot
    for i in 0..(ts - 1)
      tempP = 0
      tempS = 0
      tempM = 0
      for j in 0..(i_c - 1)
        tempS += instructors[j][:can_be_president] ? inst[i][j] : 0
        tempS += instructors[j][:can_be_secretary] ? inst[i][j] : 0
        tempM += instructors[j][:can_be_member] ? inst[i][j] : 0
      end
      m.enforce(tempP == 1)
      m.enforce(tempS == 1)
      m.enforce(tempM == 1)
      m.enforce(inst[i].inject(0, :+) <= 5)
    end

    ## exactly one student in every slot
    for i in 0..(ts - 1)
      m.enforce(stud[i].inject(0, :+) == 1)
    end
    
    ## student's supervisor must be present
    for i in 0..(ts - 1)
      for j in 0..(s_c - 1)
        m.enforce(inst[i][instructors.index{ |ins| ins[:id] == students[j][:instructor_id] }] - stud[i][j] >= 0)
      end
    end
    
    ## an examiner must be present
    for i in 0..(ts - 1)
      for j in 0..(s_c - 1)
        idxs = instructors.each_index.select{ |ins| instructors[ins][:courses].include? students[j][:course_id] }
        temp = 0
        idxs.each do |idx|
          temp += inst[i][idx]
        end
        m.enforce(temp - stud[i][j] >= 0)
      end
    end
    
    #objective
    not_present_count = 0
    for i in 0..(ts - 1)
      for j in 0..(i_c - 1)
        if !instructors[j][:presence][i]
          not_present_count += 1000 * inst[i][j]
        end
      end
    end

    m.minimize( not_present_count )

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