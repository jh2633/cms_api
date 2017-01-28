module JobHelper

  def check_category(category)
    Category.find_or_create_by(title: category)
  end

  def not_active
    "This job is no longer active"
  end

  def check_keyword(keywords)
    keywords_array = []
    keywords.split(" ").each do |word|
    keywords_array << Keyword.find_or_create_by(word: word)
    end
    keywords_array
  end

end
