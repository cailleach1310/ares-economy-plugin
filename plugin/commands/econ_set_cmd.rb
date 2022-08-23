module AresMUSH

  module Economy
    class EconSetCmd
      include CommandHandler

      def handle
        if (enactor.limit != 0)
           client.emit "Your limit is already set.\n"
           return
        end

        if (enactor.block_info)
           client.emit "You are currently blocked from financial ventures.\n"
           return
        end

        if !(enactor.is_approved?)
           client.emit "You must be approved to set your limit.\n"
           return
        end 

        pos = Economy.get_factor_attr(enactor)
        non_factors = Global.read_config("economy","non_factors").to_s.split
        if (non_factors.include? pos)
           client.emit "You are not allowed to set a limit.\n"
           return
        end      
        
        econ_limit = Economy.calc_limit(enactor)
        enactor.update(limit: econ_limit)
        limit = Economy.prettify(econ_limit)   
        Achievements.award_achievement(enactor, "econ_limit")
        client.emit "Your limit has been set to #{limit}.\n"
      end

    end
  end

end
