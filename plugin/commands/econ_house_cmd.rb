module AresMUSH

  module Economy
    class EconHouseCmd
      include CommandHandler

      def handle
         if (!enactor.is_admin? && !enactor.has_permission?("view_house_econ"))
           client.emit_failure "You don't have the permission to trigger this command."
           return nil
         else
           house = enactor.groups["house"]
           template = EconomyHouseTemplate.new house, Economy.econ_house_chars(house)
   	   client.emit template.render
         end
      end

    end
  end

end
