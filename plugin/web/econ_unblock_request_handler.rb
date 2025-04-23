module AresMUSH
  module Economy
    class EconUnblockRequestHandler
      def handle(request)
        enactor = request.enactor
        char = Character.find_one_by_name request.args['name']

        error = Website.check_login(request, true)
        return error if error

        request.log_request

        if (!char)
          return { error: t('webportal.not_found') }
        end

        if (!enactor.is_admin?)
          return { error: t('dispatcher.not_allowed') }
        end

        Economy.unblock_char(char.name)
        Global.logger.info "#{char.name}'s econ block has been removed (triggered by #{enactor.name})."
        {
            name: char.name
        }
      end
    end
  end
end
