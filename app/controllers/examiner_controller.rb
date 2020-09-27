class ExaminerController < ApplicationController
  def index
    @examiners = Examiner.pluck(:course_id, :instructor_id)
    @examiners.each do |e|
      e[0] = Course.find(e[0]).name
      e[1] = Instructor.find(e[1]).name
    end
    @examiners = @examiners.sort_by{|e| e[0]}
    for i in 0..(@examiners.length-1)
      @examiners[i] << (i+1)
    end
    @examiners = @examiners.paginate(page: params[:examiner_page], per_page: 12)
  end
end