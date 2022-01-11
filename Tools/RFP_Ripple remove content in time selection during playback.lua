-- @description Ripple remove content in time selection maintaining play cursor position
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.0
-- @about
--   This is a ripple edit function that maintains the play cursor position in relation to the speaker. This way you can cut audio while playing and you won't missed anything as the item(s) reposition.
-- @changelog
--   1.0 
--      Initial release


--Calculate length of selection
StartTime, EndTime = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
local Length = EndTime - StartTime
--
local playstate = reaper.GetPlayState()

function RemoveSelection()
  reaper.Main_OnCommand(40717, 0) --Item: Select all items in current time selection
  reaper.Main_OnCommand(40201, 0) --Time selection: Remove contents of time selection (moving later items)
  if reaper.APIExists("CF_GetSWSVersion") then
    reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_CROSSFADE"), 0) --SWS: Crossfade adjacent selected items (move edges of adjacent items)
  end
  reaper.Main_OnCommand(40289, 0) --Item: Unselect (clear selection of) all items
end

--Is there a time selection
if Length > 0 then
  reaper.Undo_BeginBlock()
  reaper.OnPauseButton()
  CursorPosition = reaper.GetCursorPosition()
  --check where the cursor is
  if CursorPosition < StartTime then
    --before
    NewCursorPosition = CursorPosition
  elseif CursorPosition > StartTime and CursorPosition < EndTime then
    --middle
    NewCursorPosition = StartTime
  else
    --after
    NewCursorPosition = CursorPosition - Length
  end

  RemoveSelection()
  reaper.SetEditCurPos(NewCursorPosition, false, false)

  if playstate == 1 then
    reaper.OnPlayButton()
  else
    reaper.OnStopButton()
  end --play
  
  reaper.Undo_EndBlock("Ripple edit", -1)
end --end length check