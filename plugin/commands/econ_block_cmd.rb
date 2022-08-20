module AresMUSH
  module Economy
    class EconBlockCmd
      include CommandHandler
      
      attr_accessor :name, :days, :reason

     def parse_args
        if (cmd.args =~ /[^\/]+\=.+\/.+/)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.name = trim_arg(args.arg1)
          self.days = integer_arg(args.arg2)
          self.reason = args.arg3
        end
      end

      def required_args
        [ self.name, self.days, self.reason ]
      end
       
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          if !(enactor.is_admin?)
            client.emit_failure "You don't have the permission to trigger this command."
            return nil
          else 
            Economy.block_char(model.name, self.days, self.reason)
            client.emit_success "#{model.name} has been blocked from economic ventures."
            return true
          end
        end
      end  
    end
  end
end
