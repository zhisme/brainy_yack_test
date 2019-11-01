module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # just mock it
      self.current_user = OpenStruct.new(id: Time.now.to_i)
      logger.add_tags 'ActionCable', current_user.id
    end
  end
end
