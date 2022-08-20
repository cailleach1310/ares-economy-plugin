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

### Updating Custom Profile and Chargen Files
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

#### shortcuts
Here is a space where you can define shortcuts for the commands.


## Uninstallation
Removing the plugin requires some code fiddling. See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).

## License
Same as [AresMUSH](https://aresmush.com/license).
