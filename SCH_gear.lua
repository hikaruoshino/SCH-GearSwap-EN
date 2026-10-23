function init_weaponns()
    send_command('gs c set MainWeapons '..('Musa')
    ..'; wait 1;  gs c set SubWeapons ' ..('Khonsu'))
end


function init_gear_sets()
    -- Lockstyle set numbers
    lockstyleset  =109
    lockstyleset_white  = 110
    lockstyleset_black  = 111

    
    -- Weapons
    gear['Musa']                                    = { name="Musa"}
 --   gear['Opashoro']                            = { name="Opashoro"}
    gear['Khonsu']                              = { name="Khonsu"}
    gear['Enki Strap']                        = { name="Enki Strap"}
    gear["Bunzi's Rod"]                            = { name="Bunzi's Rod"}
	gear["Hermit's Wand"]                            = { name="Hermit's Wand"}
    gear['Daybreak']                      = { name="Daybreak"}
	gear['Mafic Cudgel']                      = { name="Mafic Cudgel"}
    gear['Malevolence']                          = { name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}}
    gear['Ammurapi Shield']                        = { name="Ammurapi Shield"}
	gear['Genmei Shield']                        = { name="Genmei Shield"}
	gear['Culminus']                        = { name="Culminus"}
	gear["Chanter's Shield"]                        = { name="Chanter's Shield"}


    -- Job capes
    gear.JobMantle                                  = { }
    gear.JobMantle.Idle                             = { name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%'}}
    gear.JobMantle.Melee                            = { name="Lugh's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%'}}
    gear.JobMantle.MGC                              = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%'}}


    -- Treasure Hunter
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        body="Volte Jupon",
        waist="Chaac Belt"
    }


    -- Buffs that change gear (stratagems etc.)
    sets.buff['Sublimation']                           = { head="Acad. Mortar. +2",body="Peda. Gown +3",waist="Embla Sash",}
    sets.buff['Celerity']                       = { feet="Peda. Loafers +3"}
    sets.buff['Alacrity']                       = { feet="Peda. Loafers +3"}
    sets.buff['Rapture']                       = { head="Arbatel Bonnet +2"}
    sets.buff['Ebullience']                       = { head="Arbatel Bonnet +2"}
    sets.buff['Perpetuance']                       = { hands="Arbatel Bracers +2"}
    sets.buff['Penury']                       = { legs="Arbatel Pants +2"}
    sets.buff['Parsimony']                       = { legs="Arbatel Pants +2"}
    sets.buff['Klimaform']                       = { feet="Arbatel Loafers +2"}
    sets.buff['Immanence']                       = { 
   -- main="Hermit's Wand",
    main="Mafic Cudgel",
    sub="Chanter's Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
    body="Zendik Robe",
    hands="Acad. Bracers +3",
    legs="Pinga Pants +1",
    feet="Acad. Loafers +4",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Digni. Earring",
    right_ear="Assuage Earring",   -- Subtle Blow +3 (obtained 2026-10-10; it was the Etiolation Earring before)
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	} 
    
    
    -- Gear for job abilities
    sets.precast.JA['Tabula Rasa']                       = { legs="Peda. Pants +3"}
    sets.precast.JA['Light Arts']                 = { }
    sets.precast.JA['Dark Arts']                 = { }
    sets.precast.JA['Stratagems']                   = { }
    sets.precast.JA['Sublimation']                     = { }
    sets.precast.JA['Modus Veritas']                 = { }
    sets.precast.JA['Enlightenment']                     = { body="Peda. Gown +3"}
    sets.precast.JA['Libra']                     = { }
    sets.precast.JA['Caper Emissarius']           = { }

    
    -- Idle (normal)
    sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Arbatel Bonnet +2",
    body="Arbatel Gown +2",
    hands="Nyame Gauntlets",
    legs="Arbatel Pants +2",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Carrier's Sash",
    left_ear="Arete del Luna +1",
    right_ear="Alabaster Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Shneddick Ring",
        back=gear.JobMantle.Idle,
    }


    -- Idle (refresh)
    sets.idle.Refresh = {
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets", 
        neck="Sibyl Scarf",
        waist="Null Belt",
        left_ear="Malignance Earring",
        right_ear="Alabaster Earring",
        left_ring="Stikini Ring +1",
        right_ring="Shneddick Ring",
        back=gear.JobMantle.Idle,
    }

    -- Idle (after elemental magic)
    sets.idle.seirei = {
	main="Bunzi's Rod",
    sub="Ammurapi Shield",
    }

    -- Idle (after helix spells)
    sets.idle.keiryaku = {
    main="Bunzi's Rod",
    sub="Culminus",
    }

    -- Idle (back to normal)
    sets.idle.modoshi = {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    }

    -- Engaged (normal)
    sets.engaged = {
--    main="Mafic Cudgel",
--    sub="Genmei Shield",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="Zendik Robe",
    hands="Acad. Bracers +3",
    legs="Pinga Pants +1",
    feet="Acad. Loafers +4",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Murky Ring",
    }


    --FC
    sets.precast.FC = {
    main="Musa",
	sub="Khonsu",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="Arbatel Gown +2",
    hands="Acad. Bracers +3",
    legs="Agwu's Slops",
    feet="Acad. Loafers +4",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Alabaster Earring",
    left_ring="Kishar Ring",
    right_ring="Murky Ring",
    back=gear.JobMantle.Idle,
    }

    
    -- FC (for Dark Arts / Immanence)
    -- Use the same one-handed club + shield as the black lockstyle, so the swap flicker does not make the skillchain effect disappear
    -- (switching to the two-handed club Musa changes your appearance and flickers). SCH.lua's job_post_precast puts this on
    -- FC total 80% (the cap, even in Sheol Gaol with no support job) + the cast time -12% of Acad. Loafers +4 while a grimoire is active
    sets.precast.FC.Black = {
    main="Mafic Cudgel",
    sub="Chanter's Shield",
    ammo="Sapience Orb",
    head={ name="Merlinic Hood", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="Merlinic Jubbah",
    hands="Acad. Bracers +3",
    legs="Pinga Pants +1",
    feet="Acad. Loafers +4",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back=gear.JobMantle.Idle,
    }

    -- FC (for Dark Arts / Immanence, when there is FC to spare)
    -- When the support job's (RDM) Fast Cast trait takes you over the 80% cap, wear the same ears and rings as the Immanence set (the Subtle Blow ones)
    -- FC given up: Loquac. Earring 2 + Kishar Ring 4 + Rahab Ring 2 = 8 -> the gear FC is 72%
    sets.precast.FC.BlackSurplus = set_combine(sets.precast.FC.Black, {
    left_ear="Digni. Earring",
    right_ear="Malignance Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    })

    -- Gear FC (%) of the two sets above. SCH.lua adds the support job's trait FC to decide whether it reaches 80%
    fc_gear_value = {Black = 80, BlackSurplus = 72}


    -- FC (for Dispelga)
    sets.precast.FC['Dispelga'] = set_combine( sets.precast.FC,{main="Daybreak",})


    -- FC (for Impact)
    sets.precast.FC['Impact'] = set_combine( sets.precast.FC,{head=empty,body="Twilight Cloak",})


    -- Weapon skill damage
    sets.precast.WS.Damage = {
        ammo="Coiste Bodhar",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets", 
        neck="Combatant's Torque",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Telos Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
        back="Null Shawl",
    }


    -- Weapon skill magic attack
    sets.precast.WS.Magic = {
        ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets", 
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets", 
        neck={ name="Argute Stole +2", augments={'Path: A',}},
        waist="Skrymir Cord +1",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Freke Ring",
        right_ring="Cornelia's Ring",
        back=gear.JobMantle.MGC ,
    }
    
	    sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS.Magic,{
    ammo="Oshasha's Treatise",
    waist="Furin Obi",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Freke Ring",
    right_ring="Cornelia's Ring",
   }) 
	
	    sets.precast.WS["Myrkr"] = set_combine(sets.precast.WS.Magic,{
    ammo="Staunch Tathlum +1",
    head="Peda. Mortar. +4",
    body="Peda. Gown +3",
    hands="Peda. Bracers +3",
    legs={ name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
    feet="Arbatel Loafers +2",
    neck="Sanctity Necklace",
    waist="Shinjutsu-no-Obi +1",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Murky Ring",
    back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
   })
   
    
    -- Load the shared weapon skill definitions
    if init_weapon_skill then init_weapon_skill() end   -- defined in greeds's user-globals.lua; skipped if you do not use that file

    
    -- Enfeebling magic
    sets.midcast['Enfeebling Magic'] = {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="Arbatel Bonnet +2",
    body="Arbatel Gown +2",
    hands="Acad. Bracers +3",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+9',}},
    feet="Arbatel Loafers +2",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Null Belt",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Kishar Ring",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
    }


    -- Dispelga
    sets.midcast['Dispelga'] = set_combine(sets.midcast['Enfeebling Magic'],{
        main="Daybreak",
        sub="Ammurapi Shield"
    })


    -- Impact
    sets.midcast['Impact']  = set_combine(sets.midcast['Enfeebling Magic'],{
        head=empty,body="Twilight Cloak",
    })
    
    
    -- Stun
    sets.midcast['Stun']      = set_combine(sets.midcast['Enfeebling Magic'],{
        ammo="Pemphredo Tathlum"
    })


    -- Elemental magic
    sets.midcast['Elemental Magic'] = {
--    main="Opashoro",
--    sub="Enki Strap",
    main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Ghastly Tathlum +1",
    head="Peda. Mortar. +4",
    --body="Agwu's Robe",
	body="Arbatel Gown +2",
    --hands="Agwu's Gages",
	hands="Arbatel Bracers +2",
    legs="Agwu's Slops",
    feet="Arbatel Loafers +2",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Hachirin-no-Obi",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Freke Ring",
    back="Aurist's Cape +1",
    }
    
    
    -- Low-tier elemental magic
    sets.midcast['Elemental Magic'].weak = set_combine(sets.midcast['Elemental Magic'],{
    })
    
    
    -- Kaustra
    sets.midcast['Kaustra'] =  set_combine(sets.midcast['Elemental Magic'],{
	main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Ghastly Tathlum +1",
    head="Arbatel Bonnet +2",
    body="Agwu's Robe",
    hands="Agwu's Gages",
    legs="Agwu's Slops",
    feet="Arbatel Loafers +2",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Anrin Obi",
    left_ear="Regal Earring",
    right_ear={ name="Arbatel Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+13','Enmity-3',}},
    left_ring="Metamor. Ring +1",
    right_ring="Archon Ring",
	back=gear.JobMantle.MGC,
	})


    -- Helix spells
    sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'] ,{
    main="Bunzi's Rod",
    sub="Culminus",
    ammo="Ghastly Tathlum +1",
    head="Arbatel Bonnet +2",
    body="Arbatel Gown +2",
    hands="Arbatel Bracers +2",
    legs="Agwu's Slops",
    feet="Arbatel Loafers +2",
    neck={ name="Argute Stole +2", augments={'Path: A',}},
    waist="Skrymir Cord",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Metamor. Ring +1",
    right_ring="Freke Ring",
    back={ name="Bookworm's Cape", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
    })


    -- Luminohelix II
    sets.midcast["Luminohelix II"] = set_combine(sets.midcast.Helix,{main="Daybreak"})


    -- Aspir
    sets.midcast.Aspir = set_combine(sets.midcast['Elemental Magic'] ,{
        --main="Rubicundity",
    main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Arbatel Gown +2",
    hands="Acad. Bracers +3",
    legs="Peda. Pants +3",
    feet="Agwu's Pigaches",
    neck="Erra Pendant",
    waist="Fucho-no-Obi",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Evanescence Ring",
    right_ring="Archon Ring",
    back={ name="Bookworm's Cape", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
    })


    -- Drain
    sets.midcast.Drain = sets.midcast.Aspir


    -- Enhancing magic
    sets.midcast['Enhancing Magic'] = {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
    body="Peda. Gown +3",
    hands="Arbatel Bracers +2",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Hoxne Torque",
    waist="Embla Sash",
    left_ear="Magnetic Earring",
    right_ear="Calamitous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Murky Ring",
    back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    }

    
    -- Storms
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {
	feet="Peda. Loafers +3",
	})


    -- Regen
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="Arbatel Bonnet +2",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    hands="Arbatel Bracers +2",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Hoxne Torque",
    waist="Embla Sash",
    left_ear="Magnetic Earring",
    right_ear="Calamitous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Murky Ring",
    back={ name="Bookworm's Cape", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
	})


    -- Refresh
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    ammo="Pemphredo Tathlum",
    head="Amalric Coif +1",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    hands="Arbatel Bracers +2",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Hoxne Torque",
    waist="Embla Sash",
    left_ear="Magnetic Earring",
    right_ear="Calamitous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Murky Ring",
    back={ name="Bookworm's Cape", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
	})


    -- Bar spells
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels"})


    -- Stoneskin
    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels",neck="Nodens Gorget",left_ear="Earthcry Earring",waist="Siegel Sash"})


    -- Aquaveil
    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
	main="Vadose Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
    body="Peda. Gown +3",
    hands="Arbatel Bracers +2",
    legs="Shedir Seraweels",
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Loricate Torque +1",
    waist="Emphatikos Rope",
    left_ear="Magnetic Earring",
    right_ear="Calamitous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Murky Ring",
    back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
      
    
    -- Cure
    sets.midcast.Cure = {
    main={ name="Musa", augments={'Path: C',}},
    sub="Khonsu",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Arbatel Gown +2",
    hands="Peda. Bracers +3",
    legs="Pinga Pants +1",
    feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
	neck="Nodens Gorget",
    waist="Shinjutsu-no-Obi +1",
    left_ear="Mendi. Earring",
    right_ear="Calamitous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Lebeche Ring",
    back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    }
    
    -- Cursna
    sets.midcast.Cursna={
        hands="Hieros Mittens",
        feet="Gende. Galosh. +1",
        neck="Debilis Medallion",
        left_ring="Menelaus's Ring",
        right_ring="Haoma's Ring",
        back="Oretan. Cape +1",
    }
end
