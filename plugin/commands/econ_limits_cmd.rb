module AresMUSH

  module Economy
    class EconLimitsCmd
      include CommandHandler

      def handle
         if !(enactor.is_admin?)
           client.emit_failure "You don't have the permission to trigger this command."
           return nil
         else
           template = EconomyLimitsTemplate.new Economy.econ_limit_chars
   	   client.emit template.render
         end
      end

    end
  end

end
