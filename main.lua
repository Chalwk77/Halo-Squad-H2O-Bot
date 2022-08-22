-- Halo Squad - H2O Entry point file (v1.0)
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

local Discord = {
    timer = require('timer'),
    dependencies = {
        ['./'] = { 'settings' },
        ['./Events/'] = {
            'OnMessage',
            'OnTick',
            'OnVoiceConnect',
            'OnVoiceDisconnect',
        }
    }
}

local Discordia = require('discordia')
local client = Discordia.Client()

setmetatable(Discord, {
    __index = client
})

local function Ready(self)
    self.guild = client:getGuild(self.discord_server_id)
    if (self.guild) then

        self.members = {}
        self:OnTick() -- begin clock (loops every 1 second)

        self.client = client
        client:info('Initialization Complete')
    end
end

-- Loads all file dependencies (each file inherits the parent Discord{} table).
--
local function LoadDependencies(self)
    local s = self
    for path, t in pairs(self.dependencies) do
        for _, file in pairs(t) do
            local f = loadfile(path .. file .. '.lua')()
            setmetatable(s, { __index = f })
            s = f
        end
    end
end

-- Initializes the Discord Bot:
--
function Discord:StartBot()

    LoadDependencies(self)

    client:run('Bot ' .. self.token())
    client:setGame("Monitoring H2O intake since dehydration")
end

Discord:on('ready', function()
    Ready(Discord)
end)

Discord:on('messageCreate', function(msg)
    Discord:Respond(msg)
end)

Discord:on('voiceChannelJoin', function(member)
    Discord:Connect(member)
end)

Discord:on('voiceChannelLeave', function(member)
    Discord:Disconnect(member)
end)

Discord:StartBot()