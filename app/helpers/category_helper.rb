module CategoryHelper

  def check_category(category)
    Category.find_or_create_by(title: category)
  end



end
