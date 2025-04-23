module AresMUSH
  module Economy
    class EconBlockRequestHandler
      def handle(request)
        enactor = request.enactor
        char = Character.find_one_by_name request.args['name']
        days = request.args['days'].to_i
        reason = request.args['reason']

        error = Website.check_login(request, true)
        return error if error

        request.log_request

        if (!char)
          return { error: t('webportal.not_found') }
        end

        if (!enactor.is_admin?)
          return { error: t('dispatcher.not_allowed') }
        end

        if (char.block_info)
          return { error: t('economy.econ_blocked') }
        end

        Economy.block_char(char.name, days, reason)
        Global.logger.info "#{char.name} is blocked from economic ventures for #{days} days, reason: #{reason} (triggered by #{enactor.name})."
        {
            name: char.name
        }
      end
    end
  end
end
