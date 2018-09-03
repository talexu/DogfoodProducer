class FactoryController < ApplicationController
  before_action :prepare

  def index; end

  def reset
    Rails.application.config.redis.set('dogfood_progress', -1)
    render_status
  end

  def start
    Rails.application.config.redis.set('dogfood_progress', 0)
    render_status
  end

  def increase
    Rails.application.config.redis.incr('dogfood_progress') if @prog >= 0
    render_status
  end

  def status
    render_status
  end

  private

  def render_status
    render(
      json: {
        progress: [[@prog, 100 * @multiplying].min, 0].max / @multiplying
      }
    )
  end

  def prepare
    @multiplying = 1
    @prog = Rails.application.config.redis.get('dogfood_progress')
    if @prog.nil?
      @prog = -1
      Rails.application.config.redis.set('dogfood_progress', 0)
    else
      @prog = @prog.to_i
    end
  end
end
