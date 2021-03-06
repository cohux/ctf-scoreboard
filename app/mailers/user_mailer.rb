# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invite_user(user_invite)
    @invite = user_invite
    @team = @invite.team
    mail(to: @invite.email, subject: "#{@game.title}: Invite to join team #{@team.team_name}")
  end

  def user_request(user_request)
    @team = user_request.team
    @captain = @team.team_captain
    @user = user_request.user
    mail(to: @captain.email, subject: "#{@game.title}: Request from #{@user.full_name} to join #{@team.team_name}")
  end

  def competition_reminder(user)
    @user = user
    mail(to: @user.email, subject: "#{@game.title}: Competition Reminder")
  end

  # Assumes user is on a team
  def ranking(user, rank = nil)
    @user = user
    @team = @user.team
    @div = @team.division
    @rank = rank || @team.find_rank

    if @game.enable_completion_certificates
      attachments['Competition Certificate.pdf'] = @user.generate_certificate(@rank).read
    end

    mail(to: @user.email, subject: "#{@game.title}: Congratulations!")
  end

  def open_source(user)
    @user = user
    mail(to: @user.email, subject: "#{@game.title}: Challenges Released")
  end

  def message_notification(user, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: "#{@game.title} New Message: #{message.title}")
  end
end
