module AresMUSH
  module Economy

    def self.build_web_econ_chart(char, viewer)
      builder = WebEconChartDataBuilder.new
      builder.build(char, viewer)
    end

    def self.build_web_econ_modifiers(char, viewer)
      builder = WebModifierDataBuilder.new
      builder.build(char, viewer)
    end

    def self.econ_blocked_chars()
      Character.all.select { |c| (c.block_info != nil) }
    end

    def self.econ_limit_chars()
      Character.all.select { |c| (c.limit > 0) }
    end

  end
end
