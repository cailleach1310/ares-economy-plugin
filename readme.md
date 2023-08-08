# Ares Economy Plugin
An economy system plugin for AresMUSH. 

## Credits
Lyanna @ AresCentral

## Overview
Economy can be handled in many different ways on a game. The approach of this plugin ensures that new characters are not at a great disadvantage to established characters, as wealth is not accumulated through coded monthly income. It is useful for situations like auctions, but also for longer term investments, when you need to determine just how much money your character can spend. 

The limit is calculated on the basis of chance, status (as determined through a character attribute, for example 'rank' or a group attribute) and certain modifiers, if such modifiers are defined. Modifiers can be fs3 advantages, fs3 action skills or group attributes. 

Players can set their limit once when needed. After the limit is set, it can only be reset by admin, usually after a decision about a potential investment has been made.

Should a player decide to have their character finally spend a certain amount of money, admin will set an economy block on them, the duration of which is usally based on the economy chart of the player. During this economy block, the character will be unable to spend money on another financial venture. 

This plugin requires only custom code parts to be adjusted. It has been developed and tested with AresMUSH versions v0.108 - v1.0.8.

However, you can modify the algorithms used for calculating economy limits, as is explained below.

Also, this plugin now supports integration of the renown plugin, such as using renown as an economy modifier and listing renown of house members in the house overview route.

### What this plugin covers
* Game client commands for players to set their economy limit, to view the economy limit and to view the economy chart. 
* The webportal character page gets a new 'Economy' tab, where all these things are visible for the player, but not for other players.
* In-game commands for admin to check current economy limits, economy blocks and also to set an economy block on a player. 
* The 'Economy' tabs on character pages are visible for admin. 
* Webportal-side economy management page that shows current economy limits and economy blocks (visible for admin alone). On this page, admin can set an economy block on a player and also reset limits on players.
* A daily cron job checks current economy blocks on players and removes those that have expired. It sends a mail notification to players and creates a block expiry job for admin.
* Achievements are awarded for setting a limit or for completing a financial transaction for the first time.
* A factors route for the website to show the configured factors and modifiers, similar to the system pages that show groups and fs3skills.
* House Management route for admin to track econ and status of houses.
* House Overview route for admin and those that have the required permissions to view house economy and status page of a house.
* econ/house command for those with permission.
* econ/set can now also be used by those with the required permission to set econ for NPCs (-> house economy).

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

### Custom CSS
Add the following lines to your *custom_style.scss* file:

    .econ-line {
      padding: 5px;
      border-bottom: 1px solid #c0c0c0; }
    .econ-line-simple {
      padding: 5px; }

### Other plugins

#### /aresmush/game/config/achievements.yml
You can configure achievements of type 'economy' to use a descriptive icon.

    ---
    achievements:
      types:
        economy: fa-sack-dollar


#### /aresmush/game/config/website.yml
Add routes to the top bar menu for the admin management pages. Access to these routes is limited to admin and coder roles. 

For example:

      top_navbar:
    (...)
    - title: Special
      menu:
        - title: Economy Management
          route: econ-management
        - title: House Management
          route: house-management
    (...)

Add a route to the top bar menu under 'System' for the configured factors and modifiers. This route is visible to everyone.

      top_navbar:
    (...)
    - title: System
      menu:
    (...)
        - title: Economy Factors
          route: factors
    (...)


### economy.yml 
After installation, you should check the economy.yml and make adjustments where necessary. The keys in the configuration file are explained below.

#### achievements
There are two achievements defined, *econ_limit* for setting a limit for the first time, and *econ_complete* for completing a transaction (when the daily cron job unblocks a character). 

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
Modifiers can be added here, with fields 'name', 'type', 'effect'. 'Effect' can be positive or negative, usually '1' or '-1'. Currently supported modifier types are listed below.

| Modifier Type        | System           | Effect  |
| :---------------- | :--------------------| :----------------------------|
| actionskill   | fs3skills      | rating / 2 * effect |
| advantage     | fs3skills / d6system | rating * effect |
| disadvantage  | d6system | rating * effect |
| skill         | d6system       | round up (dice / 2) * effect |
| renown        | renown         | renown gained / 200 * effect |
| *group*       | demographics   | effect |  

#### non_factors
If certain factor attribute values are meant to be excluded from economy ventures, list them here. Characters that fall into this category won't have an 'Economy' tab on their webportal character page, nor will they be able to set their limit from the game client. Default value for this key is '{}'.

#### permissions
Two permissions have been defined here, 'view_house_econ' and 'manage_house_econ'. These permissions need to be associated with roles to be of use. For instance, you could create a role 'head_of_house' and add these two permissions to it, and also a role 'house_member' with just the permission 'view_house_econ'.

#### shortcuts
Here is a space where you can define shortcuts for the commands.

#### web_blocked_fields
Fields that will be listed in the webportal view of the economy management route.

#### web_limit_fields
Fields that will be listed in the webportal view of the economy management route. This will most probably need to be modified. 

## Code Tinkering

### Adjusting Limit Algorithm
If you want to adjust the algorithm for determining the economy limit, you'll need to change the code. The function in question is *Economy.calc_limit(char)*, it can be found in the *helpers.rb* file in the */aresmush/plugins/economy* directory. If you make changes here, make sure to adjust the economy help file, *\aresmush\plugins\economy\help\en\economy.md*, as well.

### Adjusting Modifier Handling
As is, modifiers will have the following effects: fs3 advantages grant a modifier of (effect * rating), fs3 action skills grant a modifier of (effect * rating / 2). Group modifiers simply return the effect. If you want to change or add modifiers and their handling, you'd have to look into the functions *Economy.calculate_modifiers(char)*, located in *\aresmush\plugins\economy\helpers.rb*, and *get_modifier_list(char)*, (located in *\aresmush\plugins\economy\econ_web_modifier_data.rb*. 

## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
