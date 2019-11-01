class ArticlesChannel < ApplicationCable::Channel
  def subscribed
    stream_from self.class.name
  end
end
