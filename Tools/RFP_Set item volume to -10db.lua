-- @description Set item volume to -10db
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.0
-- @about
--   This will set the volume of the audio within the time selection to -10db.
--   This is great for dealing with really loud breaths.
--   Known issue: doesn't behave as expected when the time selection goes beyond the selected item.
--   Future versions will be able to handle multiple items as well as follow playback.


reaper.Undo_BeginBlock()

--check that 1 and only 1 item is selected
if reaper.CountSelectedMediaItems(0) > 1 then
  reaper.ShowMessageBox('Only 1 item can be selected', 'Too many items selected', 0)
elseif reaper.CountSelectedMediaItems(0) ~= 1 then
  reaper.ShowMessageBox('Please select 1 item', 'No item selected', 0)
else -- set the volume
	--check if there's a time selection and split items if there is
	
	start_time, end_time = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)
	if start_time ~= end_time then
  		reaper.Main_OnCommand(40061, 0) --unselect all items
  		reaper.Main_OnCommand(40061, 0) --split items
	end
	
	--end check

	local item = reaper.GetSelectedMediaItem(0, 0)
	reaper.SetMediaItemInfo_Value(item, "D_VOL", 0.31622776807138)
	
	reaper.UpdateArrange()
	reaper.Main_OnCommand(40289, 0) --unselect all items
 	reaper.Main_OnCommand(40635, 0) --unselect time selection

end

reaper.Undo_EndBlock("Set item volume it -10db", -1)