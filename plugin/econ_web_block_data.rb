module AresMUSH
  module Economy
    class WebEconBlockDataBuilder
      def build(char, viewer)
        is_owner = (viewer && viewer.id == char.id)
        is_admin = viewer.is_admin?

        show_block = is_admin || is_owner
        
        if show_block && char.block 
            {
               expiry: char.block[0],
               info: char.block[1]
            }
        else
           return nil
        end
      end

    end
  end
end
