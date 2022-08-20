module AresMUSH
  class Character
     attribute :limit, :type => DataType::Integer, :default => 0
     attribute :block_info
     attribute :block_expiry
  end
end
