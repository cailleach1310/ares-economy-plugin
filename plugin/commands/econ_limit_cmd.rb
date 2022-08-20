module AresMUSH

  module Economy
    class EconLimitCmd
      include CommandHandler

      def handle
        econ_limit = Economy.prettify(enactor.limit)
        client.emit "Your current limit is #{econ_limit}.\n"
      end

    end
  end

end
