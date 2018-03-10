function EventSystem.SetupChase()

    local scenarios = {}

    table.insert(scenarios,{
        name = "thief",
        chance = 1.33,
        npcCount = 2,
        npc1 = {
            name = "thief",
            type = "NPC",
            soul = "436e524a-94a1-8bed-9d87-5a9f371fc2a5",
            patch = "man_flee",
            lootLegal = true
        },
        npc2 = {
            name = "chaser",
            type = "NPC",
            soul = "4a065489-ab71-f3b7-553a-2a04b15525ae",
            patch = "man_chase",
            lootLegal = false
        },
    })

    return scenarios
end

function EventSystem.Chase_PickScenario(scenarios)
    local total = 0
    for i=1,#scenarios do
        total = total + scenarios[i].chance
    end

    local roll = math.random() * total
    local chance = 0

    for i=1,#scenarios do
        chance = scenarios[i].chance
        if roll < chance then
            return scenarios[i]
        else
            roll = roll - chance
        end
    end
end

function EventSystem.SpawnChaseEntity(entdata, pos, direction)
    local spawnParams = {}
    spawnParams.class = entdata.type
    spawnParams.name = entdata.name
    spawnParams.position = pos
    spawnParams.orientation = direction
    spawnParams.properties = {}
    spawnParams.properties.sharedSoulGuid = entdata.soul
    spawnParams.properties.bWH_PerceptibleObject = 1
    local entity = System.SpawnEntity(spawnParams)
    entity.Properties.Script.bIdleUntilFirstPatch = true;
    entity:SetLootLegal(entdata.lootLegal)
    entity:MarkAsIgnoredCorpse()
    return entity
end

