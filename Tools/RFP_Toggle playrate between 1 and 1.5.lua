-- @description Toggle playrate between 1 and 1.5
-- @author Daniel Abendroth (Reaper for Podcasting)
-- @version 1.1
-- @about
--   You can easily toggle your playrate back and forth for faster editing.
--   You can toggle whether or not you are currently playing audio. It will keep playing if you are currently playing audio but won't start playing if it's paused or stopped.
-- @changelog
--   1.1
--      Now running this script will always have preserve pitch turned on
--   1.0
--      Initial release

local rate = reaper.Master_GetPlayRate()
local playstate = reaper.GetToggleCommandState(1007)
local pitch = reaper.GetToggleCommandState(40671)

reaper.Undo_BeginBlock()
if playstate == 1 then
	reaper.OnPauseButton() --pause playback
end --play

if rate == 1 then
	reaper.CSurf_OnPlayRateChange(1.5)
else
	reaper.CSurf_OnPlayRateChange(1)
end

--check and turn on pitch preserve
if pitch == 0 then
	reaper.Main_OnCommand(40671, 0)
end

if playstate == 1 then
	reaper.OnPlayButton()
end --play
reaper.Undo_EndBlock('Toggle playrate', -1)