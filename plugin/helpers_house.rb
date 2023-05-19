module AresMUSH
  module Economy

     def self.calculate_limit_total(house)
       total =0
       chars = Character.all.select { |c| (c.groups["house"] == house) }
       chars.each do |c|
         total = total + c.limit
       end
       return total
     end

     def self.house_view(char)
       return (char.is_admin? || char.has_permission?("view_house_econ") )
     end

    def self.econ_house_chars(house)
      Character.all.select { |c| (c.groups["house"] == house) }
    end

    def self.econ_houses
      chars = Chargen.approved_chars
      houses = []
      chars.each do |c|
         houses << c.groups["house"]
      end
      houses.uniq.sort
    end
 
  end
end
