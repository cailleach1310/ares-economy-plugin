---
toc: Game Systems
summary: Economy - explanation of limits and temporary economy blocks.
---
# Economy
Wealth is not accumulated through a fixed monthly income on this game. Instead, financial limits will be calculated when needed, based on status, position and certain modifiers. Once your character makes a substantial investment, admin will ask you to set your limit, to determine the subsequent econ/block. This reflects the time during which your character's financial ressources will be used mostly for this one investment. It will keep your character from committing to other financial ventures until that block has expired.

You won't be able to set a new limit while you're blocked from fincancial ventures. Once that block has expired, it will be removed and you will be notified.

Please note: economy information is only visible for the character and admin.
  
## Econ Commands
Within the game, you can use the following commands to handle your economy limit:

`econ/set` - Sets your financial limit for an undertaking (auction, investment, etc). The value will be calculated based on a formula that takes status into account but also relies a great deal on chance. This value will stay in effect until staff resets your character bit. 
`econ/limit` - Shows your current limit.
`econ/chart` - Shows an overview of potential econ/blocks resulting from your investment, depending on how much money you spend.

## Webportal View
You can set your limit on the 'Economy' tab of your character page on the webportal. Here you can also view economy limit, economy chart, block details and expiry. 

## Calculation of Limit
Below is a brief explanation of the algorithm used in this game:

 limit = ((random + 15) * (factor + modifiers) + 70) * 100

* Random is a random number between 1 and 10.
* Factor is based on the position of the character.
* An example for a modifier is the 'Resources' advantage with its rating.
