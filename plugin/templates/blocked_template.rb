module AresMUSH
  module Economy
    class EconomyBlockedTemplate < ErbTemplateRenderer
      
      attr_accessor :blocked_chars
      
      def initialize(chars)
        self.blocked_chars = chars
        super File.dirname(__FILE__) + "/blocked.erb"
      end
      
      def fields
        Global.read_config("economy", "econ_blocked_fields")
      end
      
      def blocked_header
        return fields.map { |f| f['title'] }
      end
      
      def chars_by_handle
        self.blocked_chars.sort_by{ |c| c.name }
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

    end
  end
end
