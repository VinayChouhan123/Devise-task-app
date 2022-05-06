class RelationshipsController < ApplicationController

	def create
		other_user = User.find(params[:user_id])
		@rel = Relationship.new(follower_id: current_user.id, 
								followed_id: other_user.id)
		@rel.save
		redirect_to profile_path(Profile.find_by(user_id: other_user.id))
	end

	def destroy
		@rel = Relationship.find(params[:id])
		@rel.destroy
		redirect_to profile_path(Profile.find(params[:format]))
	end

end
