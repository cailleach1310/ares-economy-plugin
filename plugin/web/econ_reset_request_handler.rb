module AresMUSH
  module Economy
    class EconResetRequestHandler
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
        
        Global.logger.info "#{char.name}'s econ limit has been reset (triggered by #{enactor.name})."
        char.update(limit: 0)
        {
            name: char.name
        }
      end
    end
  end
end
