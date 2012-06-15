
class ExploreController < ApplicationController

  def index
    @lecturers            = User.is_lecturer.all
    @lecturers_decorator  = UserDecorator.decorate(@lecturers)
  end

end
