-- @description Remove selected item(s) ignoring ripple
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.1
-- @about
--   This will remove the item(s) that are selected without affecting any other items or tracks regarless of the ripple editing state.
--   It's great for interviews where there are short items on the non-speaking tracks that you want to remove without accidently cutting audio from the speaker.


-- @description Save ripple mode to persistent ExtState
-- @author mendel
-- @version 1.0
-- 
--   # Save ripple mode to persistent ExtState
--
--   A most basic script that simply gets the current ripple mode, and saves it as a persistent ExtState. This state may be recalled by another script, and the ripple mode restored.
--
--   These two scripts are intended to be used in conjunction: as bookends to custom actions that require a programmatic change of the ripple mode.

Ra = reaper.GetToggleCommandState(41991)
R1 = reaper.GetToggleCommandState(41990)

function Save_Ripple_State()
  if Ra==1 then
    reaper.SetExtState("Ripple","RippleState","A",1)
    -- reaper.ShowMessageBox("Ripple Mode Saved: All Tracks", "Ripple Mode", 0)
  end
  if R1==1 then
    reaper.SetExtState("Ripple","RippleState","P",1)
  -- reaper.ShowMessageBox("Ripple Mode Saved: Per Track", "Ripple Mode", 0)
  end
  if Ra+R1==0 then
    reaper.SetExtState("Ripple","RippleState","N",1)
    -- reaper.ShowMessageBox("Ripple Mode Saved: Off", "Ripple Mode", 0)
  end
end

Save_Ripple_State()

---

reaper.Main_OnCommand(40309,0) -- Set ripple off
reaper.Main_OnCommand(40697,0) -- Remove item
reaper.Main_OnCommand(40150,0) -- Go to play cursor


---

-- @description Restore ripple mode from persistent ExtState
-- @author mendel
-- @version 1.0
-- 
--   # Restore ripple mode from persistent ExtState
--
--   This script works in conjunction with "Save ripple mode to persistent ExtState". These two scripts are intended to be used as bookends for custom actions which change the ripple mode programatically. This allows a custom action to proceed as expected, leaving the user experience of the ripple mode unchanged.

function Restore_Ripple_State()
RippleState = reaper.GetExtState("Ripple","RippleState")
  if RippleState=="A"
    then
      reaper.Main_OnCommand(40311,0,1)
      -- reaper.ShowMessageBox("Ripple Mode Restored: All Tracks", "Ripple Mode", 0)
  end
  if RippleState=="P"
    then
      reaper.Main_OnCommand(40310,0,1)
      -- reaper.ShowMessageBox("Ripple Mode Restored: Per Track", "Ripple Mode", 0)
  end
  if RippleState=="N"
    then
      reaper.Main_OnCommand(40309,0,1)
      -- reaper.ShowMessageBox("Ripple Mode Restored: Off", "Ripple Mode", 0)
  end
end

Restore_Ripple_State()
