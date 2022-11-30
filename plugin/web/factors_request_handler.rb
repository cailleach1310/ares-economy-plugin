module AresMUSH
  module Economy
    class FactorsRequestHandler
      def handle(request)
        factors = []
        factor_mode = Global.read_config("economy","factor_group")
        if (factor_mode == {}) then
          factor_group = "Rank"
           rgroup = Demographics.get_group(Ranks.rank_group)["values"].keys.map { |t| t.titlecase }
           rgroup.each do |g|
              entry = { faction: g, factors: list_factors(g) }
              if (check_factors(g)) then factors << entry end
           end
        else
          list = []
          factor_group = factor_mode
          rgroup = Demographics.get_group(factor_group)["values"].keys.map { |t| t }
          rgroup.each do |g|
             entry = { profession: g, value: if (Economy.non_factors.include? g) then "-" else Economy.factors[g] end }
             list << entry
          end
          factors << { faction: "Factors", factors: list }
        end
        modifiers = Economy.modifiers.sort_by { |a| a['name'] }.map { |a| {
          name: a['name'].titleize,
          type: a['type'],
          effect: a['effect']
        }}

        {
           factor_group: factor_group,
           factors: factors,
           modifiers: modifiers
        }
      end

      def list_factors(group)
         Ranks.all_ranks_for_group(group).map { |r| { profession: r, value: if (Economy.non_factors.include? r) then "-" else Economy.factors[r] end } }
      end

      def check_factors(faction)
         has_factors = false
         Ranks.all_ranks_for_group(faction).each { |r| if (Economy.factors[r] != nil) then has_factors = true end }
         return has_factors
      end

    end
  end
end
