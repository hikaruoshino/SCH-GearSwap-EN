# SCH-GearSwap-EN (English edition)

A GearSwap job file for the Scholar in Final Fantasy XI, built for the six-step Immanence skillchain and the Kaustra magic burst (the "6-chain Kaustra"). It swaps gear for Immanence, fast cast while a black grimoire is up, elemental obi and Orpheus's Sash by weather, day and distance, and the gear of each active stratagem.

This is the English edition of [SCH-GearSwap](https://github.com/hikaruoshino/SCH-GearSwap), which is written for the Japanese client. The logic is the same. All names are in English: items, spells, job abilities and buffs. It is made to work with [Melton6-EN](https://github.com/hikaruoshino/Melton6-EN), the addon that runs the chain from one macro, but it also works on its own.

> **Not tested on the English client.** I play on the Japanese client. The item, spell, ability and buff names come from the game's resource files (`res/items.lua`, `res/spells.lua`, `res/job_abilities.lua`, `res/buffs.lua`), and a simulated check confirms that every item name exists in the resources and that the sets have the same shape as in the Japanese edition. I have never run this build in game. If something does not swap, please open an issue and include the console message.

## Notice

The FFXI Terms of Service prohibit third-party tools, and Windower and GearSwap may fall under that. Your account could be penalized, so use this at your own risk. The author accepts no responsibility for any harm from using it.

This job file never uses weapon skills or spells for you. It only changes your equipment (and sends a skillchain announcement to your party when you ask it to).

## What it does

- **Immanence.** While Immanence is active it keeps your Immanence set (`sets.buff['Immanence']`) on and does not swap the waist, so the chain is not disturbed.
- **Fast cast while Dark Arts or Immanence is up.** While Dark Arts, Addendum: Black or Immanence is active, elemental magic and Kaustra use `sets.precast.FC.Black` (the same one-handed club and shield as your lockstyle), so you do not switch to a two-handed club and flicker. If your support job's Fast Cast trait (Red Mage) still reaches the 80% cap, it also wears the Subtle Blow ears and rings of the Immanence set (`sets.precast.FC.BlackSurplus`).
- **Elemental obi and Orpheus's Sash.** For damaging elemental magic (helix spells and Kaustra included) it wears whichever helps more: an elemental obi or Hachirin-no-Obi by the weather (including your own storms), the day and the element, or Orpheus's Sash by the distance to the target. For Cure it wears an obi if the weather or day gives a plus. It does not swap the waist for Impact or for enfeebling elemental magic, so your accuracy set stays on.
- **Stratagem gear.** It puts on the pieces you list in `sets.buff[...]` while Rapture, Ebullience, Penury, Parsimony, Alacrity, Celerity, Klimaform and so on are active, and the Sublimation set while Sublimation is charging.
- **Modes.** `CastingMode` Normal / MB, `IdleMode` Normal / Refresh, `OffenseMode` Normal / SubtleBlow, `WeaponskillMode` Normal / SubtleBlow, and `MainWeapons` / `SubWeapons` lists you can cycle.
- **Vagary mode** (`Shift+F7`, bound in `SCH.lua`; or `//gs c cycle VagaryMode`). When it is on, it puts on your fast cast set and then stops swapping, so a mob fight can be done in your Vagary set.
- **Skillchain announcements.** `//gs c sc start <skillchain> <count>` and `//gs c sc end <skillchain> <count>` send a party message with the skillchain, the elements to burst with, and the Stratagems recast. See "Skillchain announcements" below.

## Requirements

| Requirement | Notes |
| :--- | :--- |
| Windower 4 with GearSwap | The GearSwap addon that ships with Windower, including its Mote-Include libraries |
| English client | Names in the files are the English ones |
| `user-globals.lua` (optional) | See the next section |

This job file is written for Mote-Include.

## About `user-globals.lua`

The Japanese edition is meant to be used together with the `user-globals.lua` from [greeds.net's GearSwap code list](https://greeds.net/gearswap-code-list/) (the files are in [ktgreeds/GearSwap](https://github.com/ktgreeds/GearSwap)). That file belongs to greeds. It has no license, it is written in Japanese, and it is not mine to translate or redistribute, so **this repository includes neither the file nor any translation of it.**

You do not need it. The few functions this job file takes from it (`user_state_change`, `IdleMelee`, `init_weapon_skill`) are called only if they exist. Without that file, the job file still swaps gear; only the extras that file provides (for example its key bindings and lockstyle handling) may be missing.

If you already use greeds's code on the English client, note that parts of it may use Japanese names (buff names, spell names, comments). I can point out which places need English names, in an issue on this repository. I will not post the file.

## Files and installation

```text
Windower4/addons/GearSwap/data/<your character name>/
├── SCH.lua            <-- the logic (modes, FC, obi, stratagems, announcements)
├── SCH_gear.lua       <-- your gear sets (rewrite them for your own gear)
└── weather_obi.lua    <-- the elemental obi / Orpheus's Sash picker
```

1. Download this repository (Code > Download ZIP) and unzip it.
2. Put the three files in `Windower4/addons/GearSwap/data/<your character name>/`.
3. **Rewrite `SCH_gear.lua` for the gear you own.** The file contains my own gear, and the item lists are not meant for you.
4. Set the single-element obis you own in `weather_obi.lua` (`elemental_obi`). Elements left at `nil` use Hachirin-no-Obi.
5. Log in as a Scholar and run `//gs reload` (or `//gs load SCH`).

The names in `state.MainWeapons` and `state.SubWeapons` (in `SCH.lua`) should match the `gear['Name']` entries in `SCH_gear.lua`. Weapon names with spaces or apostrophes (such as `Bunzi's Rod`) are sent through `gs c set MainWeapons ...`; I have not tried that on the English client, so check that cycling works.

## Skillchain announcements

`//gs c sc start Fusion 1` sends `/p 1 <Fusion> <Fire> <Light> "I'm not ready." -> <t> <scall21>` after 0.2 seconds, and `//gs c sc end Fusion 1` sends the "Full attack!" message and the Stratagems recast after 1.2 seconds. The skillchain, the elements and the phrases are sent as auto-translate phrases, built from fixed phrase IDs with the same bytes as the Japanese edition, so a Japanese-client player in the party should see them in Japanese. If a phrase has no ID in the file, the plain English text is sent instead. (The auto-translate phrase for the start message is "I'm not ready." in English; in Japanese it reads as "getting ready".) **I have not tested this part on the English client**, and I have not confirmed in game that the same bytes work there. The skillchain names are `Liquefaction`, `Induration`, `Detonation`, `Scission`, `Impaction`, `Reverberation`, `Transfixion`, `Compression`, `Fusion`, `Gravitation`, `Fragmentation` and `Distortion`.

## Credits and license

The base structure of this job file and what I learned while writing it come from the code and explanations of greeds ([greeds.net](https://greeds.net/gearswap-code-list/), [ktgreeds/GearSwap](https://github.com/ktgreeds/GearSwap)), which I customized and rebuilt for the Immanence chain. Thank you for making your code and knowledge public.

This repository has no license. Because it is built on greeds's code, please do not redistribute or repost it. If greeds or the author of any source asks me to take it down, I will.

## Changelog

- **2026-10-26:** The Celerity / Alacrity feet are now worn when the cast starts (precast) as well as during the cast (midcast). Those feet have to be on when you use the spell, and casting time is set when the cast starts.
- **English edition (2026-10-23):** First release of the English edition, based on the current Japanese `SCH.lua` / `SCH_gear.lua` / `weather_obi.lua`. English names throughout, the three `user-globals.lua` functions called only when they exist, and the auto-translate announcements built from fixed phrase IDs.

## Feedback

A one-line "it works" is welcome too. With a GitHub account you can post from [Issues](../../issues/new/choose).
