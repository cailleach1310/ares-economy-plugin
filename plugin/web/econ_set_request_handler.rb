module AresMUSH
  module Economy
    class EconSetRequestHandler
      def handle(request)
        enactor = request.enactor
        char = Character.find_one_by_name request.args[:name]

        error = Website.check_login(request, true)
        return error if error

        request.log_request

        if (!char)
          return { error: t('webportal.not_found') }
        end

        if (enactor.name != char.name) && !enactor.is_admin?
          return { error: t('dispatcher.not_allowed') }
        end

        if !(char.is_approved?)
          return { error: t('dispatcher.not_allowed') }
        end

        if (char.block_info)
          return { error: t('economy.econ_blocked') }
        end
        
        if (char.limit > 0)
          return { error: t('economy.limit_set') }
        end

        Global.logger.info "#{char.name} sets the econ limit (triggered by #{enactor.name})."
        econ_limit = Economy.calc_limit(char)
        if econ_limit
           char.update(limit: econ_limit)
           Achievements.award_achievement(enactor, "econ_limit")
        end
        {
            name: char.name
        }
      end
    end
  end
end
