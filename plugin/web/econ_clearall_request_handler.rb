module AresMUSH
  module Economy
    class EconClearAllRequestHandler
      def handle(request)
        enactor = request.enactor

        error = Website.check_login(request, true)
        return error if error

        request.log_request

        if !enactor.is_admin?
          return { error: t('dispatcher.not_allowed') }
        end
        
        names = ""
        chars = Economy.econ_limit_chars()
        chars.each do |c|
            c.update(limit: 0)
            if names != ""
              filler = ", "
            else 
              filler = ""
            end
            names = names + filler + c.name
        end
        Global.logger.info "All econ limits have been cleared (#{names}) - triggered by #{enactor.name}."
        {
            names: names
        }
      end
    end
  end
end
