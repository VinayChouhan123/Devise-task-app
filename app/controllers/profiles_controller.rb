class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
    @posts = Post.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    if current_user.profile.present?
       flash.now[:alert] = "You have already created profile!!"
       render :new 
    else
      @profile = current_user.build_profile(profile_params)
        if @profile.save
          redirect_to @profile
        end
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    redirect_to profiles_path
  end

  private

    def profile_params
      params.require(:profile).permit(:image, :username, :gender, :bio)
    end
end
