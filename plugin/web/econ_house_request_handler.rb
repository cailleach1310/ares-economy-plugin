module AresMUSH
  module Economy
    class EconHouseRequestHandler
      def handle(request)

        house = request.args['house']

        fields = Global.read_config("economy", "web_limit_fields")
        titles = fields.map { |f| f['title'] }
        titles << 'Action'
        chars = Economy.econ_house_chars(house).sort_by { |c| c.name}

        people = []
        
        chars.each do |c|
          char_data = {}
          char_data['char'] = {
               name: c.name,
#               npc: c.is_npc,
               icon:  Website.icon_for_char(c)  }
          fields.each do |field_config|
            field = field_config["field"]
            title = field_config["title"]
            value = field_config["value"]

            char_data[title] = Economy.general_field(c, field, value)
          end
          if (c.is_npc && (c.limit == 0) )
             char_data['Action'] = "set limit"
          else
             char_data['Action'] = ""
          end
          
          people << char_data
        end

        total = Economy.prettify(Economy.calculate_limit_total(house))
        
        {
          titles: titles,
          people: people,
          total: total
        }
      end
    end
  end
end

