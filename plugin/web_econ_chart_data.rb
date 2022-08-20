module AresMUSH
  module Economy
    class WebEconChartDataBuilder
      def build(char, viewer)
        is_owner = (viewer && viewer.id == char.id)
        is_admin = viewer.is_admin?

        show_econ = is_admin || is_owner
        
        if show_econ
           return get_econ_chart(char)
        else
           return nil
        end
      end

      def get_econ_chart(char)
         Economy.econ_chart(char).map { |m,d|
          {
            amount: Economy.prettify(m),
            days: d
          }}
      end

    end
  end
end
