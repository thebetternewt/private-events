class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    event = Event.find(params[:event_id])
    invitee = User.find(params[:invitation][:invitee_id])
    current_user.invite(invitee, event)
    flash[:success] = "Successfully invited #{invitee.username} to #{event.name}!"
    redirect_to current_user
  end

end
