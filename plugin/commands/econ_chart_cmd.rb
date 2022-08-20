module AresMUSH

  module Economy
    class EconChartCmd
      include CommandHandler

      def handle
        template = EconomyChartTemplate.new enactor
	client.emit template.render
      end

    end
  end

end
