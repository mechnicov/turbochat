module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user

      logger.add_tags "ActionCable", "User #{current_user.id}"
      # Rails.logger.info "Auth check for connect to ActionCable server"
    end

    def disconnect
      close(reason: nil, reconnect: true)
    end

    def close(reason: nil, reconnect: true)
      transmit(
        type: ActionCable::INTERNAL[:message_types][:disconnect],
        reason: reason,
        reconnect: reconnect
      )
      websocket.close
    end

    private

    def find_verified_user
      if current_user = env['warden'].user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
