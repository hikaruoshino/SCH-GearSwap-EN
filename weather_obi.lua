-- =============================================================================
-- weather_obi.lua : picks an elemental obi / Hachirin-no-Obi from the weather, the day and Scholar storms (English edition of v3)
-- =============================================================================
-- It uses world.weather_element / world.weather_intensity / world.day_element, which GearSwap provides.
--   - GearSwap itself (weather_update in refresh.lua) overwrites the weather with your Scholar storm:
--     a storm (buff IDs 178-185) counts as weak weather (intensity 1) and a storm II (buff IDs 589-596) as strong weather (intensity 2).
--     A storm only affects you, so if you have one it takes priority over the zone's weather.
--   - It does not judge by weather names or storm names. It is not affected by typos in storm names, or by the fact that
--     storm II has the same English name as storm I (for example "Firestorm"). It does not depend on the language setting either.
--
-- Effect of an elemental obi / Hachirin-no-Obi (it always activates):
--   weather of the same element +10% (strong weather +25%) / day of the same element +10%
--   weather of the opposing element -10% (strong weather -25%) / day of the opposing element -10%
--   The obi is worn only when the total is positive.
-- =============================================================================

local element_map = {
    ['Fire'] = 'Fire', ['Water'] = 'Water', ['Lightning'] = 'Thunder', ['Thunder'] = 'Thunder',
    ['Earth'] = 'Earth', ['Wind'] = 'Wind', ['Ice'] = 'Ice', ['Light'] = 'Light', ['Dark'] = 'Dark',
}

-- the element that is strong against it (= lowers the effect of that element)
local weaken_element = {
    ['Fire'] = 'Water', ['Water'] = 'Thunder', ['Thunder'] = 'Earth', ['Earth'] = 'Wind',
    ['Wind'] = 'Ice', ['Ice'] = 'Fire', ['Light'] = 'Dark', ['Dark'] = 'Light',
}

-- effect (%) by weather intensity
local weather_bonus = { [1] = 10, [2] = 25 }
local day_bonus = 10

-- Set the single-element obis you own (Karin, Furin, Anrin Obi here).
-- The other elements are nil, so Hachirin-no-Obi is used automatically
local elemental_obi = {
    ['Fire'] = {waist="Karin Obi"},
    ['Water'] = nil, -- use Hachirin-no-Obi
    ['Thunder'] = nil, -- use Hachirin-no-Obi
    ['Earth'] = nil, -- use Hachirin-no-Obi
    ['Wind'] = {waist="Furin Obi"},
    ['Ice'] = nil, -- use Hachirin-no-Obi
    ['Light'] = nil, -- use Hachirin-no-Obi
    ['Dark'] = {waist="Anrin Obi"},
}

local hachirin = {waist="Hachirin-no-Obi"}

-- Returns the effect (%) of wearing an obi for a spell / move of spell_element. nil if it has no element
function get_obi_bonus(spell_element)
    local elem = element_map[spell_element]
    if not elem then return nil end   -- no element / none / physical, etc.
    local weak_elem = weaken_element[elem]

    local bonus = 0

    -- weather (including storm and storm II)
    local weather_elem = element_map[world.weather_element]
    local power = weather_bonus[tonumber(world.weather_intensity) or 0] or 0
    if weather_elem == elem then
        bonus = bonus + power
    elseif weather_elem == weak_elem then
        bonus = bonus - power
    end

    -- day
    local day_elem = element_map[world.day_element]
    if day_elem == elem then
        bonus = bonus + day_bonus
    elseif day_elem == weak_elem then
        bonus = bonus - day_bonus
    end

    return bonus
end

-- Returns the obi to wear if it helps (a single-element obi first, otherwise Hachirin-no-Obi). nil if it would hurt or do nothing
function get_hachirin(spell_element)
    local bonus = get_obi_bonus(spell_element)
    if not bonus or bonus <= 0 then return nil end
    return elemental_obi[element_map[spell_element]] or hachirin
end

-- -----------------------------------------------------------------------------
-- Orpheus's Sash: the closer to the target, the more elemental damage, +1 to +15%
--   +15% within 1.93, +1% at 13 or more, in between it falls in proportion to the distance (BG-Wiki values; the middle is a straight-line approximation)
--   The distance is GearSwap's spell.target.distance (between the centers of you and the target)
-- -----------------------------------------------------------------------------
local orpheus = {waist="Orpheus's Sash"}
local ORPHEUS_NEAR, ORPHEUS_FAR = 1.93, 13
local ORPHEUS_MAX, ORPHEUS_MIN = 15, 1

-- Returns the effect (%) of Orpheus's Sash from the distance to the target. nil if the distance is unknown
function get_orpheus_bonus(distance)
    distance = tonumber(distance)
    if not distance then return nil end
    if distance <= ORPHEUS_NEAR then return ORPHEUS_MAX end
    if distance >= ORPHEUS_FAR then return ORPHEUS_MIN end
    local rate = (distance - ORPHEUS_NEAR) / (ORPHEUS_FAR - ORPHEUS_NEAR)
    return ORPHEUS_MAX - (ORPHEUS_MAX - ORPHEUS_MIN) * rate
end

-- Returns the waist item with the larger effect: an elemental obi (weather, day) or Orpheus's Sash (distance).
-- If they are equal it picks the obi, whose effect does not change when the target moves. nil if neither helps (keep the set's waist)
function get_elemental_waist(spell)
    local obi_bonus = get_obi_bonus(spell.element)
    if not obi_bonus then return nil end   -- it has no element
    local orpheus_bonus = get_orpheus_bonus(spell.target and spell.target.distance)

    if obi_bonus > 0 and (not orpheus_bonus or obi_bonus >= orpheus_bonus) then
        return elemental_obi[element_map[spell.element]] or hachirin
    end
    if orpheus_bonus then return orpheus end
    return nil
end
