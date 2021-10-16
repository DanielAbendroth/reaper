-- @description Remove content to end of item
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.0
-- @about
--   This is will delete everything from the edit cursor to the end of the item.

reaper.Undo_BeginBlock()
reaper.Main_OnCommand(1016, 0) -- Transport: Stop
reaper.Main_OnCommand(40289, 0) -- Unselect all items
reaper.Main_OnCommand(40759, 0) -- Split items and select right
reaper.Main_OnCommand(40006, 0) -- Remove item
reaper.MoveEditCursor(-1, false) -- Move edit cursor back 1 sec
reaper.Main_OnCommand(1007, 0) -- Play
reaper.Undo_EndBlock("Remove content to end of item",0)
