module AresMUSH
  module Economy
    class WebModifierDataBuilder
      def build(char, viewer)
        if (!viewer)
          return nil
        end

        is_owner = (viewer && viewer.id == char.id)
        is_admin = viewer.is_admin?

        show_modifiers = is_admin || is_owner
        
        if show_modifiers
           return build_modifier_data(char)
        else
           return nil
        end
      end

      def get_modifier_list(char)
        mod_list = []
        pos = Economy.get_factor_attr(char)
        non_factors=Global.read_config("economy","non_factors").to_s.split
        if non_factors.include? pos
           return nil
        else
           factor = Economy.factors[pos]
           if !(factor)
              factor = 0
           end
           entry = [pos, "factor", factor]
           mod_list << entry
           Economy.modifiers.each do |a|
             case a["type"]
             when "advantage"
                adv = char.fs3_advantages.find(name: a["name"]).first
                if (adv)
                   effect = a["effect"]
                   mod = effect * adv.rating
                   entry = [a["name"], a["type"], mod]
                   mod_list << entry
                end
             when "actionskill"
                skill = char.fs3_action_skills.find(name: a["name"]).first
                if (skill)
                   effect = a["effect"]
                   mod = effect * skill.rating / 2
                   entry = [a["name"], a["type"], mod]
                   mod_list << entry
                end
             when "country"
               if (char.groups["country"] == a["name"])
                  entry = [a["name"], a["type"], a["effect"]]
                  mod_list << entry
               end
             end
           end
        end
        mod_list
     end

     def build_modifier_data(char)
        modifiers = get_modifier_list(char)
        if (modifiers == nil)
           return nil
        end
        modifiers.map { |n, t, m|
        {
           name: n,
           type: t,
           value: m
        }}

     end

    end
  end
end
