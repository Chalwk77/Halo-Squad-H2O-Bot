-- Halo Squad - H2O settings file (v1.0)
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

return {

    -- =================================================--
    -- CONFIGURATION STARTS ...

    --------------------------------------
    -- DISCORD SERVER ID --
    -- Paste your Discord server numerical ID (NOT NAME):
    -- 1). Right click the Discord server icon and click "Copy ID".
    -- 2). Replace "xxxxxxxxxxxxxxxxxx" below with the id you copied.
    discord_server_id = 'xxxxxxxxxxxxxxxxxx',


    --
    -- The Bot will send you this message at nag_interval/2 seconds after you
    -- join a voice channel:
    notify_text = 'Have you drunk your quota of H2O today? Reply with yes or no.\nTime to respond: $time',


    -- Message to omit when someone is kicked (either from not responding or time runs out):
    --
    on_punish = "Disconnect from voice: Such moist, much thurst. Drink more H2O!",


    -- Message to omit when the member replies with 'yes':
    --
    consumed_h20 = 'You better be drinking water!',


    -- Responses:
    --
    responses = { 'yes', 'no' },


    -- How long until someone is kicked:
    --
    grace_period = 60,


    -- [!] do not touch [!] --
    token = function()
        local token = ''
        local file = io.open('./auth.data')
        if (file) then
            token = file:read()
            file:close()
        end
        return token
    end
}