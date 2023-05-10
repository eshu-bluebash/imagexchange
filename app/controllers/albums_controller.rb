class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @q = Album.ransack(params[:q])
    @albums = @q.result(distinct: true).where(publish: true)
    return unless params[:tag]

    @albums = Album.tagged_with(params[:tag])
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to myalbums_path, status: :see_other
  end

  # def delete_cover
  #   @album = Album.find(params[:id])
  #   @album.cover_image.purge
  #   redirect_to @album
  # end

  def del_img
    @album = Album.find(params[:id])
    image = @album.images.find(params[:image_id])
    image.purge
    redirect_to @album
  end

  def myalbums
    @albums = current_user.albums
  end

  private

  def album_params
    params.require(:album).permit(:title, :publish, :description, :cover_image, :tag_list, :tag, { tag_ids: [] },:tag_ids, images: [])
  end
end
