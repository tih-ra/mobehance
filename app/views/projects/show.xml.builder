xml.instruct!
xml.project do
  xml.title @project.title
  xml.date @project.date
  xml.user do
    xml.name @project.user.name
    xml.url @project.user.url
  end
  xml.categories do
    @project.categories.each do |category|
      xml.category do
        xml.name category.name
        xml.url category.url
      end
    end
  end
  xml.items do
    @project.items.each do |item|
      xml.item do
        xml.src item.src
        xml.type item.type
        xml.description item.description
      end
    end
  end
end