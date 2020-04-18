module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - cms01"
    else
      'cms01'
    end
  end
end
