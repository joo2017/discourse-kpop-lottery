class KpopLotteryController < ApplicationController
  requires_plugin 'discourse-kpop-lottery'

  before_action :ensure_logged_in, :ensure_staff

  def start
    topic_id = params[:topic_id]
    duration = SiteSetting.kpop_lottery_duration

    PluginStore.set('kpop_lottery', "lottery_#{topic_id}", {
      start_time: Time.now,
      end_time: Time.now + duration.days,
      status: 'active'
    })

    render json: success_json
  end

  def draw
    topic_id = params[:topic_id]
    lottery_data = PluginStore.get('kpop_lottery', "lottery_#{topic_id}")

    raise Discourse::InvalidParameters.new('No active lottery for this topic') if lottery_data.nil? || lottery_data[:status] != 'active'
    raise Discourse::InvalidParameters.new('Lottery has not ended yet') if Time.now < lottery_data[:end_time].to_time

    topic = Topic.find_by(id: topic_id)
    raise Discourse::NotFound.new('Topic not found') if topic.nil?

    eligible_posts = topic.posts.where('post_number > 1 AND created_at BETWEEN ? AND ?', lottery_data[:start_time], lottery_data[:end_time])

    if eligible_posts.count < SiteSetting.kpop_lottery_min_posts
      render json: failed_json, status: 400
      return
    end

    winner = eligible_posts.sample
    
    PluginStore.set('kpop_lottery', "lottery_#{topic_id}", lottery_data.merge(status: 'completed', winner_id: winner.user_id))

    render json: { success: true, winner: winner.user.username }
  end

  private

  def ensure_staff
    raise Discourse::InvalidAccess.new unless current_user.staff?
  end
end
