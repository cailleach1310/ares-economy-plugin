module AresMUSH
  module Economy
    class EconomyChartTemplate < ErbTemplateRenderer
      
      attr_accessor :char
      
      def initialize(char)
        @char = char
        super File.dirname(__FILE__) + "/economy.erb"
      end
      
      def limits
        list = []
        Economy.econ_chart(@char).each do |m,d|
           line = limit_line(m,d)
           list << line
        end
        list
      end

      def limit_line(money,days)
        return "%r           upto " + "%xc#{right(Economy.prettify(money),15)}%xn" + "    -->   %xg econ/block of #{days} days%xn"
      end

    end
  end
end
