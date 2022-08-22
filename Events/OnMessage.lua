-- Halo Squad - H2O OnMessage file (v1.0)
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

local Message = {}
local wrap = coroutine.wrap

function Message:Respond(msg)

    local author = msg.author
    local content = msg.content
    local id = author.id

    local members = self.members

    if (author and not author.bot and members[id]) then

        if (members[id].time > self.grace_period / 2) then
            author:send("Please don't talk to me!")
            return
        end

        local member = members[id].member -- member guild object
        if (content == self.responses[1]) then

            self.members[id] = nil
            author:send(self.consumed_h20)

        elseif (content == self.responses[2]) then

            -- Disconnect member from voice:
            wrap(function()
                member:setVoiceChannel(nil)
            end)()
            --

        else
            author:send("Invalid Response! Reply with yes or no.")
        end
    end
end

return Message