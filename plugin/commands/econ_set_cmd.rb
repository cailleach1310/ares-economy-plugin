module AresMUSH

  module Economy
    class EconSetCmd
      include CommandHandler

      attr_accessor :name

      def parse_args
         self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end

      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
           if (model.limit != 0)
              client.emit_failure "#{model.name}'s limit is already set.\n"
              return
           end

           if (model.block_info)
              client.emit_failure "#{model.name} is currently blocked from financial ventures.\n"
              return
           end

           if !(model.is_approved?)
              client.emit_failure "#{model.name} must be approved to set the economy limit.\n"
              return
           end 

           if (model.name != enactor.name) && !(enactor.is_admin?)
              client.emit_failure "You're not allowed to do that.\n"
              return
           end

           pos = Economy.get_factor_attr(model)
           non_factors = Global.read_config("economy","non_factors").to_s.split
           if (non_factors.include? pos)
              client.emit_failure "#{model.name} is not allowed to set a limit.\n"
              return
           end      
        
           econ_limit = Economy.calc_limit(model)
           model.update(limit: econ_limit)
           limit = Economy.prettify(econ_limit)   
           Global.logger.info "#{model.name} sets the econ limit (triggered by #{enactor.name})."
           Achievements.award_achievement(model, "econ_limit")
           client.emit_success "#{model.name}'s limit has been set to #{limit}.\n"
        end
      end

    end
  end

end
