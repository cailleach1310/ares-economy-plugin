module AresMUSH
  module Economy
    class EconBlockedRequestHandler
      def handle(request)

        fields = Global.read_config("economy", "web_blocked_fields")
        titles = fields.map { |f| f['title'] }
        titles << "Action"        
        chars = Economy.econ_blocked_chars.sort_by { |c| c.name}

        people = []
        
        chars.each do |c|
          char_data = {}
          char_data['char'] = {
               name: c.name,
               icon:  Website.icon_for_char(c)  }
          fields.each do |field_config|
            field = field_config["field"]
            title = field_config["title"]
            value = field_config["value"]

            char_data[title] = Economy.general_field(c, field, value)
          end
          char_data['Action'] = "action"
          
          people << char_data
        end
        
        {
          titles: titles,
          investors: people
        }
      end
    end
  end
end
