# Ares Economy Plugin
An economy system plugin for AresMUSH. 

## Credits
Lyanna @ AresCentral

## Overview
Economy can be handled in many different ways on a game. The approach of this plugin ensures that new characters are not at a disadvantage to established characters, which would occur, if wealth were acquired through coded monthly income. It is useful for situations like auctions, but also for longer term investments, when you need to determine just how much money your character can spend. 

The limit is calculated on the basis of chance, status (as determined through a character attribute, for example 'rank' or a group attribute) and certain modifiers, if such modifiers are defined. Modifiers can be for example an advantage 'Resources', or a country attribute value. 

Players can set their limit once when needed. After the limit is set, it can only be cleared by admin.

Should a player decide to have their character finally spend a certain amount of money, admin will set an economy block on them, the duration of which is usally based on the economy chart of the player. During this economy block, the character will be unable to spend money on another financial venture. Meaning big financial venture. It is not meant to leave them broke for the time.

### What this plugin covers
In game commands for players to set their economy limit, to view the economy limit and to view the economy chart. The webportal character page gets a new 'Economy' tab, where all these things are visible for the player, but not for other players.

In game commands for admin to check current economy limits, economy blocks and also to set an economy block on a player. Webportal-side: The 'Economy' tabs on character pages are visible for admins. There is also an admin page for economy management that shows current economy limits and economy blocks. On this page, an admin can set an economy block on a player and also clear limits on players.

A daily cron job checks current economy blocks on players and clears those that have expired. It sends a mail notification to players and creates a block expiry job for admin.

## Screenshots

### Game Client - Economy Chart View
![econ-chart](/images/econ_chart_game.PNG)

### Game Client - Admin Commands
![econ-admin-commands](/images/econ_admin_game_commands.PNG)

### Webportal - Profile View
![profile-economy-tab](/images/economy_tab_view.PNG)

### Webportal - Economy Management View (Admin)
![econ-management](/images/econ_management_page.PNG)

## Installation
In the game, run: plugin/install https://github.com/cailleach1310/ares-economy-plugin

### Updating Custom Files
If you do not have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the economy plugin.

#### aresmush/plugins/profile/custom_char_fields.rb
Update with: custom_files/custom_char_fields.rb

#### ares-webportal/app/custom-routes.js
Update with: custom_files/custom-routes.js

#### ares-webportal/app/templates/components/profile-custom.hbs
Update with: custom_files/profile-custom.hbs

#### ares-webportal/app/templates/components/profile-custom-tabs.hbs
Update with: custom_files/profile-custom-tabs.hbs

#### ares-webportal/app/components/profile-custom.js
Update with: custom_files/profile-custom.js

## Configuration

### Other plugins

#### /aresmush/game/config/website.yml
Add a route to the top bar menu for the admin management page. This route is limited to admin and coder roles for now. 

For example:

      top_navbar:
    (...)
    - title: Special
      menu:
        - title: Economy Management
          route: econ-management
    (...)

### economy.yml 
After installation, you should check the economy.yml and make adjustments where necessary. The keys in the configuration file are explained below.

#### check_econ_block_cron
Time for the daily econ block expiry check. If needed, adjust to a time that suits you better.

#### currency
Update this field with the currency of your game, 'dollars', 'ducats', whatever.

#### econ_blocked_fields
The fields that will be listed when using the in-game econ/blocked admin command. 

#### econ_limit_fields
The fields that will be listed when using the in-game econ/limits admin command. This will most probably need to be modified. 

#### factor_group
Add here the name of the group that will determine the factor, for example 'position'. If you want to use 'rank' as determining attribute, set this to '{}'.

#### factors
This is where factor attribute values are tied to the actual factor numbers.

#### modifiers
Modifiers can be added here, with fields 'name', 'type', 'effect'. 'Effect' can be positive or negative, usually '1' or '-1'. This is where you'd usually tie in the advantage 'Resources'. Modifiers of type 'advantage' will have their rating multiplied to the effect.

#### non_factors
If certain factor attribute values are meant to be excluded from economy ventures, list them here. Characters that fall into this category won't have an 'Economy' tab on their webportal character page. Default value for this key is '{}'.

#### shortcuts
Here is a space where you can define shortcuts for the commands.

#### web_blocked_fields
Fields that will be listed in the webportal view of the economy management route.

#### web_limit_fields
Fields that will be listed in the webportal view of the economy management route. This will most probably need to be modified. 

### Adjusting Limit Algorithm
If you want to adjust the algorithm for determining the limit, you'll need to dig into the code. The function in question is **Economy.calc_limit(char)**, it can be found in the helpers.rb file in the /aresmush/plugins/economy directory.

## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
