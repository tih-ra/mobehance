class FavoritesController < ApplicationController
  #before_filter :login_required
  
  def index
     @favorites = DbFavorite.order("created_at desc").where("behance_user = ?", params[:behance_user])
     respond_to do |format|
       format.xml do

       end
     end
   end
   
  def create
    project = DbProject.find_by_url(params[:favorites][:proj_url])
    project.db_favorites.find_or_create_by_behance_user(:behance_user=>params[:favorites][:behance_user])
    render :nothing=>true
  end
  
  def destroy
    favorite = DbFavorite.find(params[:id])
    favorite.destroy if favorite.behance_user == params[:behance_user]
    render :nothing=>true
  end
end
