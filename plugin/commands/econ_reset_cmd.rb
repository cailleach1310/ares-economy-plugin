module AresMUSH

  module Economy
    class EconResetCmd
      include CommandHandler

      attr_accessor :name
      
      def parse_args
         self.name = trim_arg(cmd.args)
      end

      def required_args
        [ self.name]
      end
            
      def check_can_set
        return nil if enactor.is_admin?
        return t('dispatcher.not_allowed')
      end      

      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|        
          if (model)
             model.update(limit: "0")
             client.emit_success "#{model.name}'s limit has been reset.\n"
             Global.logger.info "#{model.name}'s econ limit has been reset (triggered by #{enactor.name})."
          else
             client.emit_failure "Character #{self.name} not found.\n"
          end
        end
      end

    end
  end

end
