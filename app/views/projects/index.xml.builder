xml.instruct!
xml.projects do
  xml.logged_in @logged_in.to_s
  @projects.each do |project|
    xml.project do
      xml.title project.title
      xml.cover project.cover
      xml.date project.date
      xml.url project.url
      xml.user do
        xml.name project.user.name
        xml.url project.user.url
      end
      xml.categories do
        project.categories.each do |category|
          xml.category do
            xml.name category.name
            xml.url category.url
          end
        end
      end
    end
  end
end