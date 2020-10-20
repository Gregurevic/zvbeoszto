class Schedule < ApplicationRecord

  def schedule
    Schedule.delete_all

    model = Cbc::Model.new

    s_c = Student.count
    i_c = Instructor.count
    r_c = s_c + i_c

    for i in 0..(s_c - 1) #per timeslot
      model.bin_var_array(r_c, 0..1, names: (0..(r_c - 1)).to_a.map{ |x| "TS#{i}R" + x.to_s })
    end

    ip_c = Instructor.where(can_be_president: true).count
    is_c = Instructor.where(can_be_secretary: true).count
    session_c = (s_c / 5.to_f).ceil #20

    for i in 0..(session_c - 1)
      model.bin_var_array(ip_c, 0..1, names: (0..(ip_c - 1)).to_a.map{ |x| "TS#{i}P" + x.to_s })
      model.bin_var_array(is_c, 0..1, names: (0..(is_c - 1)).to_a.map{ |x| "TS#{i}S" + x.to_s })
    end

    im_c = Instructor.where(can_be_member: true).count

    model.bin_var_array(ip_c, 0..1, names: (0..(ip_c - 1)).to_a.map{ |x| "PtempP" + x.to_s })
    model.bin_var_array(is_c, 0..1, names: (0..(is_c - 1)).to_a.map{ |x| "StempP" + x.to_s })
    model.bin_var_array(im_c, 0..1, names: (0..(im_c - 1)).to_a.map{ |x| "MtempP" + x.to_s })
    model.bin_var_array(ip_c, 0..1, names: (0..(ip_c - 1)).to_a.map{ |x| "PtempQ" + x.to_s })
    model.bin_var_array(is_c, 0..1, names: (0..(is_c - 1)).to_a.map{ |x| "StempQ" + x.to_s })
    model.bin_var_array(im_c, 0..1, names: (0..(im_c - 1)).to_a.map{ |x| "MtempQ" + x.to_s })

  end

end