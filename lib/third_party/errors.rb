module ThirdParty
  module Errors
    class UnexpectedResponseError < StandardError
      def initialize(msg = nil)
        super "ThirdParty::Errors::UnexpectedResponseError #{msg}".strip
      end
    end

    class ClientError < StandardError
      def initialize(msg = nil)
        super "ThirdParty::Errors::ClientError: #{msg}".strip
      end
    end

    class NotFoundError < ClientError
      def initialize(msg = nil)
        super "ThirdParty::Errors::NotFoundError: #{msg}".strip
      end
    end

    class ServerError < StandardError
      def initialize(msg = nil)
        super "ThirdParty::Errors::ServerError:#{msg}".strip
      end
    end
  end
end
