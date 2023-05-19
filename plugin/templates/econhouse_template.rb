module AresMUSH
  module Economy
    class EconomyHouseTemplate < ErbTemplateRenderer
      
      attr_accessor :house, :house_chars
      
      def initialize(house,house_chars)
        self.house = house
        self.house_chars = house_chars
        super File.dirname(__FILE__) + "/econhouse.erb"
      end
      
      def fields
        Global.read_config("economy", "econ_limit_fields")
      end
      
      def house_title
        return "Current Limits of House " + self.house
      end

      def house_header
        return fields.map { |f| f['title'] }
      end
      
      def chars_by_handle
        self.house_chars.sort_by{ |c| c.name }
      end

      def show_field(char, field_config)
        field = field_config["field"]
        value = field_config["value"]
        width = field_config["width"]
        
        field_eval = Economy.general_field(char, field, value)
        left(field_eval, width)
      end
      
      def show_title(field_config)
        title = field_config["title"]
        width = field_config["width"]
        
        left(title, width)
      end

      def house_total
        total = Economy.calculate_limit_total(self.house)
        title = "Total"
        line = "#{left(title,56)} #{left(Economy.prettify(total),15)}"
      end

    end
  end
end
