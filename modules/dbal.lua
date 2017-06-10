local mysql = require "resty.mysql"
local dbal = {}

local function conn()
    local db, err = mysql:new()

    if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
    end

    db:set_timeout(1000) -- 1 sec


    local ok, err, errcode, sqlstate = db:connect{
        host = "127.0.0.1",
        port = 3306,
        database = "drill_list",
        user = "root",
        password = "",
        charset = "utf8",
        max_packet_size = 1024 * 1024,
    }

    if not ok then
        ngx.say("failed to connect: ", err, ": ", errcode, " ", sqlstate)
        return
    end

    ngx.say("connected to mysql.")
end

dbal.conn = conn

return dbal