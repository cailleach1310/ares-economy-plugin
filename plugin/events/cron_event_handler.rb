module AresMUSH
  module Economy
    class CronEventHandler
     
      def on_event(event)
        config = Global.read_config("economy", "check_econ_block_cron")
        if Cron.is_cron_match?(config, event.time)

          Global.logger.debug "Checking econ blocks, clearing expired blocks."

          expired = Economy.expired_blocks
          summary = ""
          expired.each do |c|
             Economy.unblock_char(c.name)
             message = "Congratulations! Your economy block has expired.\n\nDetails: " + c.block_info + "\n\nExpiry Date: " + c.block_expiry
             Mail.send_mail([c.name], "Economy Block Expiry", message, nil)
             summary = summary + "\n\n#{c.name}:\nDetails: #{c.block_info}\nExpiry Date: #{c.block_expiry}\n"
          end
          if !(expired.empty?)
             Jobs.create_job("MISC",
             "Economy Block Expiry",
             "The following economy blocks have expired: #{summary}",
             Game.master.system_character)
          end
        end
      end 

    end
  end
end
