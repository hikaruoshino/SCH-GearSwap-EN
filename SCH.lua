-- =============================================================================
-- SCH.lua : main logic of the Scholar (SCH) GearSwap file (English edition)
-- =============================================================================

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('english')
    include('weather_obi.lua') -- the module that picks an elemental obi / Hachirin-no-Obi from storms, weather and day
end


function job_setup()
    -- watched buffs (grimoire and stratagem effects)
    state.Buff['Rapture']      = buffactive['Rapture'] or false
    state.Buff['Focalization']      = buffactive['Focalization'] or false
    state.Buff['Penury']      = buffactive['Penury'] or false
    state.Buff['Sublimation: Activated']   = buffactive['Sublimation: Activated'] or false
    state.Buff['Ebullience']      = buffactive['Ebullience'] or false
    state.Buff['Klimaform']      = buffactive['Klimaform'] or false
    state.Buff['Parsimony']      = buffactive['Parsimony'] or false
    state.Buff['Alacrity']      = buffactive['Alacrity'] or false
    state.Buff['Immanence']      = buffactive['Immanence'] or false
    state.Buff['Tranquility']      = buffactive['Tranquility'] or false
    state.Buff['Celerity']      = buffactive['Celerity'] or false
    state.Buff['Altruism']      = buffactive['Altruism'] or false
    state.Buff['Equanimity']      = buffactive['Equanimity'] or false
    state.Buff['Perpetuance']      = buffactive['Perpetuance'] or false
    
    -- ★ add Normal and MB (magic burst) as casting modes
    state.CastingMode:options('Normal', 'MB')

    state.IdleMode:options('Normal', 'Refresh')
    state.OffenseMode:options('Normal', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'SubtleBlow')

    state.MainWeapons       = M{'Musa',"Bunzi's Rod",'Mafic Cudgel','Malevolence','Daybreak',"Hermit's Wand"}
    state.SubWeapons        = M{'Khonsu','Ammurapi Shield','Genmei Shield','Enki Strap','Culminus',"Chanter's Shield"}
    state.VagaryMode        = M(false, 'Vagary')
    state.TreasureHunter    = M(false)

    send_command('bind ~f7 gs c cycle VagaryMode')
end


function user_unload()
    send_command('unbind ~f7')
end


-- Fast Cast trait (%) of a Red Mage support job. support Lv 15 = 10 / 35 = 15 / 55 = 20
-- With a Scholar at master level 21 the support level is 53, so 15. When the support level is 0, as in Sheol Gaol, 0
local function sub_job_fast_cast()
    if player.sub_job ~= 'RDM' then return 0 end
    local lv = player.sub_job_level or 0
    if lv >= 55 then return 20
    elseif lv >= 35 then return 15
    elseif lv >= 15 then return 10
    end
    return 0
end


function job_post_precast(spell, action, spellMap, eventArgs)
    -- ★ While Dark Arts, Addendum: Black or Immanence is active, use sets.precast.FC.Black (the same one-handed club + shield as the lockstyle)
    --   for the FC of elemental magic and Kaustra.
    --   Switching to the two-handed club Musa makes you flicker, which erases the skillchain effect before the Immanence chain or the MB.
    --   Impact is excluded so that its own FC set (Twilight Cloak) is not broken
    local is_black = buffactive['Dark Arts'] or buffactive['Addendum: Black'] or buffactive['Immanence']
    local is_nuke = (spell.skill == 'Elemental Magic' and spell.name ~= 'Impact') or spell.name == 'Kaustra'
    if is_black and is_nuke and sets.precast.FC.Black then
        -- If the support job's trait FC still reaches the 80% cap, wear the same ears and rings as during Immanence (the Subtle Blow ones)
        local surplus = sets.precast.FC.BlackSurplus and fc_gear_value
            and (fc_gear_value.BlackSurplus + sub_job_fast_cast() >= 80)
        equip(surplus and sets.precast.FC.BlackSurplus or sets.precast.FC.Black)
    end

    -- ★ The Celerity / Alacrity feet (they cut casting time and recast for spells that match the weather)
    --   must be on "when you use the spell", not when you use the ability. Casting time is set when the cast starts,
    --   so wear them here as well as in job_post_midcast. They go on after the FC set, so they replace its feet
    if spell.action_type == 'Magic' and spell.name ~= 'Impact' then
        for _, buff in ipairs({'Celerity', 'Alacrity'}) do
            if buffactive[buff] and sets.buff[buff]
            and not (spell.name == 'Embrava' and buff == 'Celerity') then   -- same exception as in job_post_midcast
                equip(sets.buff[buff])
            end
        end
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- ★ is Immanence active?
    local is_immanence = state.Buff['Immanence'] or buffactive['Immanence']

    -- override with the gear of the active stratagem buffs
    for buff, active in pairs(state.Buff) do
        if active and sets.buff[buff] then
            if spell.name == 'Impact' 
            or (spell.name == 'Embrava' and (buff == 'Celerity' or buff == 'Penury')) then
                -- no override for specific spells
            else
                equip(sets.buff[buff])
            end
        end
    end 

    -- ★ While Immanence is active, do not swap the obi (get_hachirin); always wear
    --   sets.buff['Immanence'] (Arbatel gear etc.) with top priority
    if is_immanence then
        if sets.buff['Immanence'] then
            equip(sets.buff['Immanence'])
        end
    else
        -- Swap the waist automatically only while Immanence is not active
        -- Elemental magic that does damage (including helix spells) and Kaustra: a Scholar also does MBs, so treat them all the same.
        --   Use whichever has the larger effect: an elemental obi (storm, weather, day) or Orpheus's Sash (distance to the target)
        -- Elemental enfeebling (Burn etc.) and Impact are not swapped, so the accuracy set is not broken (same as BLM.lua)
        local is_nuke = (spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' and spell.name ~= 'Impact')
        if is_nuke or spell.name == 'Kaustra' then
            local waist = get_elemental_waist(spell)
            if waist then
                equip(waist)
            end
        elseif spellMap == 'Cure' or spellMap == 'Curaga' then
            -- Cure: an elemental obi if the weather or day gives a plus
            equip(get_hachirin(spell.element))
        end
    end
end


function job_customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff['Sublimation'])
    end
    return idleSet
end


function job_state_change(stateField, newValue, oldValue)
    -- user_state_change comes from greeds's user-globals.lua; skip it if you do not use that file
    if user_state_change then user_state_change(stateField, newValue, oldValue) end
    if stateField == 'Vagary' then
        if newValue then
            equip(sets.precast.FC)
            disable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
        else
            enable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
            if IdleMelee then IdleMelee() end   -- IdleMelee also comes from user-globals.lua
        end
    end
end


function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" and gain then 
        equip(sets.buff['Sublimation'])
    end
end


-- ▼▼▼▼▼▼ Immanence skillchain settings ▼▼▼▼▼▼
-- skillchain -> the element(s) a magic burst needs
sc_mb = {
    ['Liquefaction'] = {'Fire'},
    ['Induration'] = {'Ice'},
    ['Detonation'] = {'Wind'},
    ['Scission'] = {'Earth'},
    ['Impaction'] = {'Thunder'},
    ['Reverberation'] = {'Water'},
    ['Transfixion'] = {'Light'},
    ['Compression'] = {'Dark'},
    ['Fusion'] = {'Fire', 'Light'},
    ['Gravitation'] = {'Earth', 'Dark'},
    ['Fragmentation'] = {'Wind', 'Thunder'},
    ['Distortion'] = {'Ice', 'Water'},
}


function custom_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'lockstyleset' then -- fix the lockstyle
        if cmdParams[2] == 'black' then
            send_command('gs c set MainWeapons Bunzi\'s Rod; wait 0.1; gs c set SubWeapons Ammurapi Shield; wait 0.1; input /lockstyleset '.. (lockstyleset_black or '100'))
        elseif cmdParams[2] == 'white' then
            send_command('gs c set MainWeapons Musa; wait 0.1; gs c set SubWeapons Khonsu; wait 0.1; input /lockstyleset '.. (lockstyleset_white or '100'))
        else
            send_command('gs c set MainWeapons Musa; wait 0.1; gs c set SubWeapons Khonsu; wait 0.1; input /lockstyleset '.. (lockstyleset or '100'))
        end

    elseif cmdParams[1] == 'sc' then -- [Scholar] Immanence skillchain announcements
        if cmdParams[2] == 'start' then
            disp_start_skillchain_message(cmdParams[3], cmdParams[4])
        elseif cmdParams[2] == 'end' then
            disp_end_skillchain_message(cmdParams[3], cmdParams[4])
        else
            windower.add_to_chat(123, 'Invalid argument: ' .. table.concat(cmdParams, ' '))
        end
    end
end


-- Auto-translate tokens are built from fixed IDs (the IDs are the same in every language; the client shows the phrase in its own language).
-- The bytes are the same as in the Japanese edition (FD 02 01 <id hi> <id lo> FD). IDs come from res/auto_translates.lua.
-- (windower.convert_auto_trans only goes the other way, from the bytes to text, so it is not used here.)
-- Not tested on the English client. If a phrase has no ID here, the plain text is sent instead.
local AT_ID = {
    ['Liquefaction'] = 7875, ['Induration'] = 7876, ['Detonation'] = 7880, ['Scission'] = 7879,
    ['Impaction'] = 7881, ['Reverberation'] = 7877, ['Transfixion'] = 7878, ['Compression'] = 7874,
    ['Fusion'] = 7873, ['Gravitation'] = 7870, ['Fragmentation'] = 7871, ['Distortion'] = 7872,
    ['Fire'] = 7858, ['Ice'] = 7842, ['Wind'] = 7847, ['Earth'] = 7808, ['Thunder'] = 7886, ['Water'] = 7885,
    ['Light'] = 7755, ['Dark'] = 7882,   -- 7882 is the phrase "Darkness"
    ["I'm not ready."] = 5392, ['Full attack!'] = 1291,
}

function get_auto_translate_char_squence(phrase)
    local id = AT_ID[phrase]
    if not id then
        return ' ' .. phrase .. ' '
    end
    local at_start, at_end, at_type, at_lang = 0xFD, 0xFD, 0x02, 0x01
    return string.char(at_start, at_type, at_lang, bit.band(bit.rshift(id, 8), 0xFF), bit.band(id, 0xFF), at_end)
end


-- Skillchain announcement to the party: <count> <skillchain> <elements> "I'm not ready." -> <t> <scall21>
-- (the auto-translate phrase "I'm not ready." is the English text of the Japanese "preparing")
function disp_start_skillchain_message(sc_name, count)
    if not sc_mb[sc_name] then
        windower.add_to_chat(123, '[SC] Unknown skillchain name: ' .. tostring(sc_name))
        return
    end

    count = count or ''

    local sc_msg = get_auto_translate_char_squence(sc_name)
    local sc_mb_msg = {}

    for i, v in ipairs(sc_mb[sc_name]) do
        sc_mb_msg[i] = get_auto_translate_char_squence(v)
    end

    local msg = 'input /p '..count..sc_msg

    for i, v in ipairs(sc_mb_msg) do
        msg = msg..v
    end

    local start_msg = get_auto_translate_char_squence("I'm not ready.")

    msg = msg..start_msg..'   -> '..' <t> <scall21>'
    send_command('wait 0.2; '..msg)
end


function disp_end_skillchain_message(sc_name, count)
    if not sc_mb[sc_name] then
        windower.add_to_chat(123, '[SC] Unknown skillchain name: ' .. tostring(sc_name))
        return
    end

    count = count or ''

    local sc_msg = get_auto_translate_char_squence(sc_name)
    local sc_mb_msg = {}

    for i, v in ipairs(sc_mb[sc_name]) do
        sc_mb_msg[i] = get_auto_translate_char_squence(v)
    end

    local msg = 'input /p '..count..sc_msg

    for i, v in ipairs(sc_mb_msg) do
        msg = msg..v
    end

    local end_msg = get_auto_translate_char_squence('Full attack!')

    msg = msg..end_msg..' -> '..' <t> '..'* '..'<recast=Stratagems>'
    -- If this is called from the same macro right after the start announcement (0.2 s later), the two chat inputs overlap
    -- and the game says there was an error in the command (2026-10-12, the Fusion-only macro, step 1 -> 3). So the end announcement is delayed by 1 s
    send_command('wait 1.2; '..msg)
end
-- ▲▲▲▲▲▲ Immanence skillchain settings ▲▲▲▲▲▲