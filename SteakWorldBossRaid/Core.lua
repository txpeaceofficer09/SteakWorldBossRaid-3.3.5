local f = CreateFrame("Frame")

local function OnEvent(self, event, ...)
	local areaID = GetCurrentMapAreaID()
	if areaID ~= 33 then return end

	if event:match("^CHAT_MSG_") then
		local msg, sender = ...
		msg = msg:lower()

		if msg:match("^inv") and GetNumRaidMembers() < 40 then
			InviteUnit(sender)
		end
	else
		if UnitIsPartyLeader("player") then
			if GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 then
				ConvertToRaid()
			end

			for i=1,GetNumRaidMembers() do
				if not UnitIsRaidOfficer("raid"..i) then
					PromoteToAssistant(UnitName("raid"..i))
				end
			end
		end
	end
end

f:RegisterEvent("CHAT_MSG_YELL")
f:RegisterEvent("CHAT_MSG_SAY")
f:RegisterEvent("CHAT_MSG_WHISPER")
f:RegisterEvent("PARTY_MEMBERS_CHANGED")
f:RegisterEvent("RAID_ROSTER_UPDATE")

f:SetScript("OnEvent", OnEvent)
