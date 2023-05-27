module AresMUSH
  module Economy

     def self.calculate_modifiers(char)
       mod = 0
       Economy.modifiers.each do |a|
          case a["type"]
          when "advantage"
             effect = a["effect"]
             adv = char.fs3_advantages.find(name: a["name"]).first
             if (adv)
                mod = mod + effect * adv.rating
             end
          when "actionskill"
             effect = a["effect"]
             skill = char.fs3_action_skills.find(name: a["name"]).first
             if (skill)
                mod = mod + effect * skill.rating / 2
             end
          when "renown"
             if Manage.is_extra_installed?("renown")
                effect = a["effect"]
                if (a["name"] == "Renown")
                   mod = mod + effect * Renown.calculate_gained(char.name) / 200
                end
             end
          else
            type = a["type"]
            if Demographics.get_group(type) 
               if (char.groups[type] == a["name"])
                  effect = a["effect"]
                  mod = mod + effect
               end
            end
          end 
       end
       return mod
     end

     def self.get_factor_attr(char)
        factor_group = Global.read_config("economy","factor_group")
        if ( factor_group == {} )
           pos = char.ranks_rank
           if (!pos)
               return { error: t('economy.config_error') }
           end
        else
           pos = char.groups[factor_group]
           if (!pos)
               return { error: t('economy.config_error') }
           end
        end
        return pos
     end

     def self.calc_limit(char)
        limit = 0
        random = rand(1..10)
        factor_attr = Economy.get_factor_attr(char).to_s
        non_factors=Global.read_config("economy","non_factors").to_s.split
        if non_factors.include? factor_attr
           return 0
        else
           factor = Economy.factors[factor_attr]
           if !(factor)
              factor = 0
           end
           modifiers = calculate_modifiers(char)
           if (factor)
              limit = ((random + 15) * (factor + modifiers) + 70) * 100
           end
           Global.logger.info t('economy.calc_details', :factor => factor, :modifier => modifiers, :random => random)
           return limit
        end
     end

     def self.expired_blocks()
        list = []
        datestr = Time.now.to_date.strftime("%Y-%m-%d")
        blocked = Economy.econ_blocked_chars
        blocked.each do |c|
           if (c.block_expiry <= datestr)
               list << c
           end           
        end
        return list
     end

     def self.prettify(amount)
         if !amount
             return "Not set."
         else
           rev = amount.to_s.reverse
           ar = rev.scan(/.{3}/)
           len_last = amount.to_s.length % 3
           last = amount.to_s.slice(0,len_last).reverse
           if (last.length > 0)
              ar = ar << last
           end
           string = ar.join(",").reverse + " " + Economy.currency
        end
        return string
     end

    def self.econ_chart(char)
        list = []
        limit = char.limit

        if (limit > 0)  
           amount = limit / 2
           entry = [amount, 14]
           list << entry
           amount = (limit * 85) / 100
           entry = [amount, 30]
           list << entry
           entry = [limit, 40]
           list << entry
           amount = (limit * 125) / 100
           entry = [amount, 60]
           list << entry
        end
        return list
     end

     def self.block_char(name, days, reason)
        char = Character.find_one_by_name name
        time = Time.now.to_date + days
        block_message = t('economy.econ_block', :name => char.name, :days => days, :reason => reason)
        char.update(block_expiry: time.strftime("%Y-%m-%d"))
        char.update(block_info: block_message)
        char.update(limit: 0)
     end

     def self.unblock_char(name)
        char = Character.find_one_by_name name
        char.update(block_expiry: nil) 
        char.update(block_info: nil)
     end

    def self.general_field(char, field_type, value)
      case field_type

      when 'name'
        Demographics.name_and_nickname(char)
    
      when 'rank'
        char.ranks_rank
   
      when 'group'
        char.group(value)

      when 'handle'
        char.handle ? "@#{char.handle.name}" : ""
        
      when 'limit'
        Economy.prettify(char.limit)

      when 'block_info'
        char.block_info

      when 'block_expiry'
        char.block_expiry

      when 'last_on'
        char.last_on

      else 
        nil
      end
    end

  end
end
