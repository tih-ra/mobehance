xml.instruct!
xml.favorites do
  @favorites.each do |favorite|
    xml.favorite do
      xml.id favorite.id
      xml.title favorite.db_project.title
      xml.url favorite.db_project.url
      xml.cover_src favorite.db_project.cover_src
    end
  end
end