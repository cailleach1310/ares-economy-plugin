module AresMUSH
  module Economy
    class EconHousesRequestHandler
      def handle(request)
        { houses: Economy.econ_houses }
      end
    end
  end
end
