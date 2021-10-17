-- @description Remove selected item(s) ignoring ripple
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.2
-- @about
--   This will remove the item(s) that are selected without affecting any other items or tracks regarless of the ripple editing state.
--   It's great for interviews where there are short items on the non-speaking tracks that you want to remove without accidently cutting audio from the speaker.
-- @changelog
--    Cleaned up the code for handling the ripple toggle

-- create needed functions
function Check_Ripple_State()
  rippleAll = reaper.GetToggleCommandState(41991)
  rippleTrack = reaper.GetToggleCommandState(41990)


  if rippleAll == 1 then
    rippleState = "a"
 elseif rippleTrack == 1 then
   rippleState = "t"
 else
    rippleState = "o"
  end
end

function Set_Ripple_State()
  if rippleState == 'a' then
    reaper.Main_OnCommand(40311, 0)
    reaper.ShowMessageBox('Ripple All', 'Ripple Mode', 0)
  elseif rippleState == 't' then
    reaper.Main_OnCommand(40310, 0)
    reaper.ShowMessageBox('Ripple Track', 'Ripple Mode', 0)
  else
    reaper.Main_OnCommand(40309, 0)
    reaper.ShowMessageBox('Ripple Off', 'Ripple Mode', 0)
  end
end

-- end functions


Check_Ripple_State()
reaper.Main_OnCommand(40309,0) -- Set ripple off
reaper.Main_OnCommand(40697,0) -- Remove item
reaper.Main_OnCommand(40150,0) -- Go to play cursor
Set_Ripple_State()