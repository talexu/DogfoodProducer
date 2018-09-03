class FactoryController < ApplicationController
  before_action :prepare

  def index
    @times = (params[:times] || 1).to_i
  end

  def admin; end

  def reset
    Rails.application.config.redis.set('dogfood_progress', -1)
    render_status(true)
  end

  def start
    Rails.application.config.redis.set('dogfood_progress', 0)
    render_status(true)
  end

  def increase
    (params[:times] || 1).to_i.times do
      Rails.application.config.redis.incr('dogfood_progress') if @prog >= 0
    end
    render_status
  end

  def status
    render_status
  end

  private

  def render_status(reload = false)
    load_progress if reload
    render(
      json: {
        progress: [[@prog, 100 * @multiplying].min, 0].max / @multiplying
      }
    )
  end

  def prepare
    @multiplying = 20
    load_progress
  end

  def load_progress
    @prog = Rails.application.config.redis.get('dogfood_progress')
    if @prog.nil?
      @prog = -1
      Rails.application.config.redis.set('dogfood_progress', 0)
    else
      @prog = @prog.to_i
    end
  end
end
