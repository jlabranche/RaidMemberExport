local RaidMemberExportFrame = CreateFrame("Frame")
RaidMemberExportFrame:RegisterEvent("ADDON_LOADED")
local filePath = "Interface\\AddOns\\RaidMemberExport\\RaidMembers.txt"

local function ExportRaidMembers()
    local isInRaid = GetNumRaidMembers() > 0
    local isInParty = GetNumPartyMembers() > 0

    if isInRaid or isInParty then
        local raidMembers = {}

        for i = 1, (isInRaid and GetNumRaidMembers()) or (isInParty and GetNumPartyMembers()) do
            local unit = (isInRaid and "raid" .. i) or (isInParty and "party" .. i)
            local name = UnitName(unit)

            if name then
                table.insert(raidMembers, name)
            end
        end

        RaidMemberExportDB = "\r" .. table.concat(raidMembers, "\r") .. "\r";

        DEFAULT_CHAT_FRAME:AddMessage("Raid members exported to SavedVariable RaidMemberExportDB")
    else
        DEFAULT_CHAT_FRAME:AddMessage("You are not in a raid or party.")
    end
end



local function OnAddonLoaded(event, addonName)
    SLASH_EXPORTRAID1 = "/exportraid"
    SlashCmdList["EXPORTRAID"] = function()
        DEFAULT_CHAT_FRAME:AddMessage("Slash command '/exportraid' triggered.")
        ExportRaidMembers()
    end
end

RaidMemberExportFrame:SetScript("OnEvent", OnAddonLoaded)