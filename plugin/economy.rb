$:.unshift File.dirname(__FILE__)

module AresMUSH
     module Economy

    def self.install_setup
      Character.all.each { |c| c.update(limit: '0') }
    end

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.achievements
      Global.read_config("economy", "achievements")
    end

    def self.currency
      Global.read_config("economy", "currency")
    end

    def self.factors
      Global.read_config("economy", "factors")
    end

    def self.modifiers
      Global.read_config("economy", "modifiers")
    end

    def self.shortcuts
      Global.read_config("economy", "shortcuts")
    end

    def self.non_factors
      Global.read_config("economy", "non_factors")
    end

    def self.get_cmd_handler(client, cmd, enactor)      
      case cmd.root
      when "econ"
        case cmd.switch
        when "limit"
          return EconLimitCmd
        when "set"
          return EconSetCmd
        when "chart"
          return EconChartCmd
        when "limits"
          return EconLimitsCmd
        when "reset"
          return EconResetCmd
        when "block"
          return EconBlockCmd
        when "blocked"
          return EconBlockedCmd
        when "unblock"
          return EconUnblockCmd
        end
      end
    end

    def self.get_event_handler(event_name)
      case event_name
      when "CronEvent"
        return CronEventHandler      
      end
    end

    def self.get_web_request_handler(request)
       case request.cmd
         when "econSet"
           return EconSetRequestHandler
         when "econLimits"
           return EconLimitsRequestHandler
         when "econBlock"
           return EconBlockRequestHandler
         when "econUnblock"
           return EconUnblockRequestHandler
         when "econBlocked"
           return EconBlockedRequestHandler
         when "econReset"
           return EconResetRequestHandler
         when "econClearAll"
           return EconClearAllRequestHandler
         when "infoFactors"
           return FactorsRequestHandler
       end
    end

  end
end
