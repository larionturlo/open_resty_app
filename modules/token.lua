local redis = require "resty.redis"
local token = {}

local function conn()
    local red = redis:new()

    red:set_timeout(1000) -- 1 sec

    local ok, err = red:connect("127.0.0.1", 6379)

    if not ok then
        ngx.say("failed to connect: ", err)
        return
    end

    return red
end

function token.set( name , hash )
    local rconn = conn()

    local ok, err = rconn:set(name, hash)
    if not ok then
        ngx.log(ngx.ERR,"failed to set " .. name .. ": ", err)
    end

    rconn:close()

    return
end

function token.get( name )
    local rconn = conn()
    local res, err = rconn:get(name)

    if not res then
        ngx.log(ngx.ERR, "failed to get " .. name .. ": ", err)
    end

    if res == ngx.null then
        ngx.log(ngx.ERR, name .. " not found.")
    end

    rconn:close()

    return res
end


return token