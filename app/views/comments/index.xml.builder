xml.instruct!
xml.project do
  xml.title @project.title
  xml.date @project.date
  xml.proj_id @project.proj_id
  xml.user do
    xml.name @project.user.name
    xml.url @project.user.url
  end
  xml.comments do
    @project.comments.each do |comment|
      xml.comment do
        xml.date comment.date
        xml.message comment.message
        xml.user do
          xml.name comment.user.name
          xml.url comment.user.url
          xml.icon comment.user.icon
        end
      end
    end
  end
end