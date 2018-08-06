class DogfoodFactoryController < ApplicationController
  before_action :prepare

  class << self
    attr_accessor :status
    attr_accessor :progress
  end

  def index
  end

  def reset
    self.class.status = 'ready'
    self.class.progress = 0
    render_status
  end

  def start
    self.class.status = 'start'
    self.class.progress = 0
    render_status
  end

  def increase
    if self.class.status == 'start'
      self.class.progress = [100, self.class.progress + 10].min
    end

    if self.class.progress >= 100
      self.class.status = 'success'
    end

    render_status
  end

  def status
    render_status
  end

  private

  def render_status
    render(
      json: {
        status: self.class.status,
        progress: self.class.progress
      }
    )
  end

  def prepare
    self.class.status = self.class.status || 'ready'
    self.class.progress = self.class.progress || 0
  end
end
