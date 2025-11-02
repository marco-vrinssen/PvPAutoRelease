# Bento PvP Utility

PvP utility addon that automatically releases spirit in PvP zones and provides context-aware TAB targeting that switches between player and enemy targeting based on your current zone.

## Features

- **Auto Spirit Release** - Automatically releases spirit when you die in PvP zones or combat zones
- **Smart Detection** - Skips auto-release when self-resurrection abilities are available
- **Context-Aware TAB Targeting** - Automatically switches TAB binding between targeting enemy players (PvP) and targeting any enemy (PvE) based on zone type
- **PvP Optimized** - Only activates in battlegrounds, arenas, and world PvP combat zones

## Installation

1. Download the addon
2. Extract to `World of Warcraft/_retail_/Interface/AddOns/`
3. Restart WoW or reload UI with `/reload`

## Usage

The addon works automatically once installed:

- When you die in a PvP zone, your spirit will be released automatically after a short delay
- TAB key binding updates automatically when entering or leaving PvP zones
- In arenas, battlegrounds, or world PvP: TAB targets nearest enemy player
- In PvE zones: TAB targets nearest enemy (any type)
