-- PvP utility addon for auto spirit release and context-aware TAB targeting

local RELEASE_DELAY = 0.1

local function releaseSpiritInPvp()
  
  -- Skip when self-resurrection is available
  if C_DeathInfo and C_DeathInfo.GetSelfResurrectOptions then
    local selfResOptions = C_DeathInfo.GetSelfResurrectOptions()
    if selfResOptions and #selfResOptions > 0 then
      return
    end
  end

  -- Only release in PvP zones or combat zones
  local _, instanceType = IsInInstance()
  local zonePvp = GetZonePVPInfo()
  if instanceType ~= "pvp" and zonePvp ~= "combat" then
    return
  end

  -- Delay to allow death UI to initialize
  C_Timer.After(RELEASE_DELAY, function()
    if not UnitIsDead("player") or UnitIsGhost("player") then
      return
    end

    if RepopMe then
      RepopMe()
      return
    end

    if StaticPopup_FindVisible then
      local deathDialog = StaticPopup_FindVisible("DEATH")
      if deathDialog and deathDialog.button1 and deathDialog.button1:IsEnabled() then
        deathDialog.button1:Click()
      end
    end
  end)
end

local function updateTabTargetBinding()
  local _, instanceType = IsInInstance()
  local zonePvpInfo = C_PvP.GetZonePVPInfo()

  local tabKey = "TAB"
  local bindingSet = GetCurrentBindingSet()

  -- Skip during combat or when using account-wide bindings
  if InCombatLockdown() or (bindingSet ~= 1 and bindingSet ~= 2) then
    return
  end

  local currentBinding = GetBindingAction(tabKey)

  -- Pick action based on PvP or PvE context
  local targetAction = (instanceType == "arena" or instanceType == "pvp" or zonePvpInfo == "combat")
    and "TARGETNEARESTENEMYPLAYER"
    or  "TARGETNEARESTENEMY"

  if currentBinding == targetAction then
    return
  end

  -- Write binding and notify
  SetBinding(tabKey, targetAction)
  SaveBindings(bindingSet)

  local bindingMode = (targetAction == "TARGETNEARESTENEMYPLAYER") and "PVP TAB" or "PVE TAB"
  print(bindingMode)
end

local spiritReleaseFrame = CreateFrame("Frame")
spiritReleaseFrame:RegisterEvent("PLAYER_DEAD")
spiritReleaseFrame:SetScript("OnEvent", releaseSpiritInPvp)

local tabBindingFrame = CreateFrame("Frame")
tabBindingFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
tabBindingFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
tabBindingFrame:SetScript("OnEvent", updateTabTargetBinding)
