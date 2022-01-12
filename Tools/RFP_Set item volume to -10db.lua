-- @description Set item volume to -10db
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.2
-- @about
--   This will set the volume of the audio within the time selection to -10db. This is great for dealing with really loud breaths.
--   If you don't have any time selection but do have an item selected then it will set that item to -10db.
--   If you have no time selection or items selected then the script does nothing.
--   You don't have to stop playback at all. It will catch back up to the play cursor so that you don't interrupt your listening.
-- @changelog
--   1.2 Changed how it handles multiple tracks. Now if you have an item selected, it will only reduce the time selection on the selected item. Before, it would reduced the volume on all tracks.  
--   1.1 A lot of changes to make this work as expected.
--   1.0 Initial release


--check if there is a time selection
start_time, end_time = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)
if start_time ~= end_time then
  time_selected = true
else
  time_selected = false
end

function SetVolume(x)
  for i = 0, x-1 do
    item = reaper.GetSelectedMediaItem(0, i)
    reaper.SetMediaItemInfo_Value(item, "D_VOL", 0.31622776807138)
  end
end
----------------------------------------------

if not time_selected and reaper.CountSelectedMediaItems(0) >= 1 then
	reaper.Undo_BeginBlock()
  count = reaper.CountSelectedMediaItems(0)
  SetVolume(count)
  action = true
elseif time_selected and reaper.CountSelectedMediaItems(0) >= 1 then
  reaper.Undo_BeginBlock()
  --reaper.Main_OnCommand(40289, 0) --unselect all items
  reaper.Main_OnCommand(40061, 0) --split items
  --reaper.Main_OnCommand(40717, 0) --select all items under time selection
  count = reaper.CountSelectedMediaItems(0)
  SetVolume(count)
  reaper.Main_OnCommand(40635, 0) --unselect time selection
  action = true
elseif time_selected then
	reaper.Undo_BeginBlock()
  reaper.Main_OnCommand(40289, 0) --unselect all items
  reaper.Main_OnCommand(40061, 0) --split items
  reaper.Main_OnCommand(40717, 0) --select all items under time selection
  count = reaper.CountSelectedMediaItems(0)
  SetVolume(count)
  reaper.Main_OnCommand(40635, 0) --unselect time selection
  action = true
end

if action then
	reaper.UpdateArrange()
	reaper.Main_OnCommand(40289, 0) --unselect all items
	reaper.Main_OnCommand(40150, 0) --catch up to play cursor
	reaper.Undo_EndBlock("Set item volume it -10db", -1)
end
