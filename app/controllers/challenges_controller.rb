# frozen_string_literal: true

class ChallengesController < ApplicationController
  include ChallengesHelper

  before_action :enforce_access
  before_action :load_game, :load_message_count
  before_action :find_challenge
  before_action :find_solved_by, only: %i[show update]
  before_action :valid_captcha, :find_and_log_flag, :on_team?, only: [:update]

  def show
    @solvable = @challenge.can_be_solved_by(current_user.team)
    # TODO: Solved Challenge is currently missing, causing the flag accepted banner to never show up
    # TODO: Add test for this
    @solved_video_url = @solved_challenge.flag.video_url if @solved_challenge
    flash.now[:notice] = I18n.t('flag.accepted') if @solved_challenge
  end

  def update
    if @flag_found
      @solved_challenge = @flag_found.save_solved_challenge(current_user)
      @solved_video_url = @flag_found.video_url
      flash.now[:notice] = I18n.t('flag.accepted')
    else
      flash.now[:alert] = wrong_flag_messages.sample
    end
    @solvable = @challenge.can_be_solved_by(current_user.team)

    render :show
  end

  private

  def valid_captcha
    return if verify_recaptcha

    flash.now[:alert] = I18n.t('devise.registrations.recaptcha_failed')
    render :show
  end

  def find_challenge
    find_challenge_by_params
    deny_if_not_admin unless @challenge.open?
  end

  def find_solved_by
    @solved_by = @challenge.solved_challenges.includes(team: :division).order(created_at: :asc)
  end

  def find_and_log_flag
    flag = params[:challenge]&.[](:submitted_flag) # Safe navigation on a hash
    return if flag.nil?

    SubmittedFlag.create(user: current_user, challenge: @challenge, text: flag) unless current_user.admin?
    @flag_found = @challenge.find_flag(flag)
  end

  def on_team?
    return true if current_user.on_a_team? || current_user.admin?

    redirect_back fallback_location: user_root_path, alert: I18n.t('challenges.must_be_on_team')
  end

  def find_challenge_by_params
    @challenge = @game.challenges.find(params[:id])
    if @challenge.is_a?(PentestChallenge)
      @challenge = @challenge.defense_flags.find_by(team: params[:team_id])
      @defense_team = @challenge.team
    end
  end
end
