---
toc: ~admin~ Managing the Game
summary: Economy - managing economy limits and blocks.
---
# Economy Management

## Game Commands

### Economy Limit
`econ/set <name>` - Sets economy limit for a character.
`econ/limits` - Lists current economy limits of all characters.
`econ/chart <name>` - Shows the econ chart of a character.
`econ/reset <name>` - Resets the current limit of a character. 
`econ/clearall` - Resets current limits of all characters.

### Economy Block
`econ/block <name>=<number of days>/<details>` - Sets an econ block on a character, for the duration of the given number of days.
`econ/unblock <name>` - Removes a block from a player. This will usually happen automatically on the day the block expires.
`econ/blocked` - Lists current economy blocks with expiry dates.

## Webportal View
All details on the 'Economy' tab of a character page are visible to admin. This is especially helpful in regards to the economy chart which is often the basis for determining the duration of a subsequent econ block.

The 'Economy Management' route provides an overview of current limits and blocks, along with the option of setting blocks and clearing limits from the webportal. 

