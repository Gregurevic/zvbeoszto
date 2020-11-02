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

    ## workloads
    ## workload boundary constraints
    a = instructors.count{ |i| i[:can_be_president] }
    b = instructors.count{ |i| i[:can_be_secretary] }
    c = instructors.count{ |i| i[:can_be_member] }
    w_p_p = Array.new(a)
    w_p_n = Array.new(a)
    w_s_p = Array.new(b)
    w_s_n = Array.new(b)
    w_m_p = Array.new(c)
    w_m_n = Array.new(c)
    for i in 0..(a - 1)
      w_p_p[i] = m.cont_var(0..Cbc::INF, name: "w_p_p_#{i}")
      w_p_n[i] = m.cont_var(0..Cbc::INF, name: "w_p_n_#{i}")
      m.enforce(w_p_p[i] + w_p_n[i] >= 15)
      m.enforce(w_p_p[i] + w_p_n[i] <= 35)
    end
    for i in 0..(b - 1)
      w_s_p[i] = m.cont_var(0..Cbc::INF, name: "w_s_p_#{i}")
      w_s_n[i] = m.cont_var(0..Cbc::INF, name: "w_s_n_#{i}")
      m.enforce(w_s_p[i] + w_s_n[i] >= 5)
      m.enforce(w_s_p[i] + w_s_n[i] <= 15)
    end
    for i in 0..(c - 1)
      w_m_p[i] = m.cont_var(0..Cbc::INF, name: "w_m_p_#{i}")
      w_m_n[i] = m.cont_var(0..Cbc::INF, name: "w_m_n_#{i}")
      m.enforce(w_m_p[i] + w_m_n[i] >= 7)
    end

    #constraints
    ## maximum of five instructors
    ## exactly one president in every timeslot
    ## exactly one secretary in every timeslot
    ## exactly one or two members in every timeslot
    ## the president has to be available
    ## the secretary has to be available
    for i in 0..(ts - 1)
      tempP = 0
      tempS = 0
      tempM = 0
      for j in 0..(i_c - 1)
        if instructors[j][:can_be_president]
          m.enforce((instructors[j][:presence][i] ? 1 : 0) - inst[i][j] >= 0)
          tempP += inst[i][j]
        end
        if instructors[j][:can_be_secretary]
          m.enforce((instructors[j][:presence][i] ? 1 : 0) - inst[i][j] >= 0)
          tempS += inst[i][j]
        end
        if instructors[j][:can_be_member]
          tempM += inst[i][j]
        end
      end
      m.enforce(tempP == 1)
      m.enforce(tempS == 1)
      m.enforce(tempM >= 1)
      m.enforce(tempM <= 2)
      m.enforce(inst[i].inject(0, :+) <= 5)
    end

    ## exactly one student in every timeslot 
    ## student's supervisor must be present   
    ## an examiner must be present
    for i in 0..(ts - 1)
      for j in 0..(s_c - 1)
        idxs = instructors.each_index.select{ |ins| instructors[ins][:courses].include? students[j][:course_id] }
        temp = 0
        idxs.each do |idx|
          temp += inst[i][idx]
        end
        m.enforce(temp - stud[i][j] >= 0)
        m.enforce(inst[i][instructors.index{ |ins| ins[:id] == students[j][:instructor_id] }] - stud[i][j] >= 0)
      end
      m.enforce(stud[i].inject(0, :+) == 1)
    end

    ## every student must be present
    for j in 0..(s_c - 1)
      m.enforce(stud.map{|e| e[j]}.reduce(:+) == 1)
    end

    ## the president mustn't change
    ## the secretary mustn't change
    for i in (0..(ts - 1)).step(5)
      for j in 0..(i_c - 1)
        if instructors[j][:can_be_president] || instructors[j][:can_be_secretary]
          m.enforce(inst[ i ][j] == inst[i+1][j])
          m.enforce(inst[i+1][j] == inst[i+2][j])
          m.enforce(inst[i+2][j] == inst[i+3][j])
          m.enforce(inst[i+3][j] == inst[i+4][j])
        end
      end
    end

    ## workloads of presidents
    ## workloads of secretaries
    ## workloads of members
    opt_p = ts / instructors.count{ |i| i[:can_be_president] }
    opt_s = ts / instructors.count{ |i| i[:can_be_secretary] }
    opt_m = ts / instructors.count{ |i| i[:can_be_member] }
    idx_p = 0
    idx_s = 0
    idx_m = 0
    for j in 0..(i_c - 1)
      sum_p = 0
      sum_s = 0
      sum_m = 0
      if instructors[j][:can_be_president]
        for i in 0..(ts - 1)
          sum_p += inst[i][j]
        end
        m.enforce(w_p_p[idx_p] - w_p_n[idx_p] == sum_p - opt_p)
        idx_p += 1
      end
      if instructors[j][:can_be_secretary]
        for i in 0..(ts - 1)
          sum_s += inst[i][j]
        end
        m.enforce(w_s_p[idx_s] - w_s_n[idx_s] == sum_s - opt_s)
        idx_s += 1
      end
      if instructors[j][:can_be_member]
        for i in 0..(ts - 1)
          sum_m += inst[i][j]
        end
        m.enforce(w_m_p[idx_m] - w_m_n[idx_m] == sum_m - opt_m)
        idx_m += 1
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

    m.minimize(not_present_count + w_p_p.inject(0, :+) + w_p_n.inject(0, :+) + w_s_p.inject(0, :+) + w_s_n.inject(0, :+) + w_m_p.inject(0, :+) + w_m_n.inject(0, :+))

    #solving
    problem = m.to_problem
    problem.solve

    byebug

    #proven solvable
    if problem.proven_infeasible?
      return false
    end

    #write
    for i in 0..(ts - 1)
      si = stud[i].index{ |s| problem.value_of(s) == 1 }
      student = students[si][:name]
      supervisor = instructors.find{ |ins| ins[:id] == students[si][:instructor_id] }[:name]
      course = Course.where(id: students[si][:course_id]).pluck(:name)[0]
      idxs = instructors.each_index.select{ |ins| problem.value_of(inst[i][ins]) == 1 }
      president = ""
      secretary = ""
      member = ""
      examiner = ""
      idxs.each do|idx|
        if instructors[idx][:can_be_president]
          president = instructors[idx][:name]
        end
        if instructors[idx][:can_be_secretary]
          secretary = instructors[idx][:name]
        end
        if instructors[idx][:can_be_member]
          member = instructors[idx][:name]
        end
        if instructors[idx][:courses].include? students[si][:course_id]
          examiner = instructors[idx][:name]
        end
      end
      Schedule.create(student: student, supervisor: supervisor, president: president, secretary: secretary, member: member, examiner: examiner, course: course)
    end

    #return
    return problem.objective_value
  end
end
