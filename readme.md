# Ares Economy Plugin
An economy system plugin for AresMUSH. 

## Credits
Lyanna @ AresCentral

## Overview

(tbd)

### What this plugin covers


## Screenshots

(tbd)

## Prerequisites


## Installation
In the game, run: plugin/install https://github.com/cailleach1310/ares-economy-plugin

### Updating Custom Profile Files
If you do not have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the marque plugin.

#### aresmush/plugins/profile/custom_char_fields.rb
Update with: custom_files/custom_char_fields.rb

### Updating Custom Web Portal Profile Files
If you don't have any existing edits to these custom files, you can use the files in the custom_files folder of this repository as-is. If you do, then you may use them as templates to add the lines of code needed for the marque plugin.

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
You don't have to modify the economy.yml for the plugin to work, but you can make adjustments here. The keys in the yaml are explained below.

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

#### shortcuts
Here is a space where you can define shortcuts for the commands.

#### web_blocked_fields
Fields that will be listed in the webportal view of the economy management route.

#### web_limit_fields
Fields that will be listed in the webportal view of the economy management route. This will most probably need to be modified. 

## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
