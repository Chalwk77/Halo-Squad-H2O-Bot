-- Halo Squad - H2O OnVoiceDisconnect file (v1.0)
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

local Voice = {}

function Voice:Disconnect(member)

    local member_object = self.members[member.id]

    if (member_object) then
        self.members[member.id] = nil
        member:send(self.on_punish)
    end
end

return Voice