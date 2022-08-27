module AresMUSH
  module Economy
    class EconUnblockCmd
      include CommandHandler
      
      attr_accessor :name

     def parse_args
          self.name = trim_arg(cmd.args)
      end

      def required_args
        [ self.name ]
      end
       
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          if !(enactor.is_admin?)
            client.emit_failure "You don't have the permission to trigger this command."
            return nil
          else 
            Economy.unblock_char(model.name)
            client.emit_success "Economy block for #{model.name} has been successfully removed."
            Global.logger.info "Economy block for #{model.name} has been removed (triggered by #{enactor.name})."
            return true
          end
        end
      end
  
    end
  end
end
