-- Halo Squad - H2O OnTick file (v1.0)
-- Copyright (c) 2022, Jericho Crosby <jericho.crosby227@gmail.com>

--[[
    This file is part of Halo Squad - H2O.

    Halo Squad - H2O is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Halo Squad - H2O is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Halo Squad - H2O. If not, see <http://www.gnu.org/licenses/>.
]]

local Timer = {}
local round = math.floor
local format = string.format
local wrap = coroutine.wrap

-- Converts seconds to hrs, mins, secs:
--
local function secondsToTime(seconds)
    local hours = math.floor(seconds / (60 * 60))
    seconds = seconds % (60 * 60)
    local minutes = math.floor(seconds / 60)
    seconds = seconds % 60
    return hours, minutes, seconds
end

local function GetTime(self, t)
    local str = self.notify_text
    local hrs, min, sec = secondsToTime(t)
    str = str:gsub('$time', format('%02d:%02d:%02d', hrs, min, sec))
    return str
end

function Timer:OnTick()

    self.timer.setTimeout(1000, function()

        wrap(function()

            -- @id: member guild id
            -- @v: member object
            for id, v in pairs(self.members) do

                if (id) then

                    -- Decrement time value by 1:
                    v.time = v.time - 1

                    local member = v.member
                    local half_time = self.grace_period / 2
                    local time_remaining = round(v.time)

                    -- Send first notification:
                    if (time_remaining == half_time) then
                        member:send(GetTime(self, time_remaining))

                        -- Disconnect from voice:
                    elseif (time_remaining <= 0) then
                        member:setVoiceChannel(nil)
                    end
                end
            end
        end)()

        self:OnTick()
    end)
end

return Timer