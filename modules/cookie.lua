local ck = require "resty.cookie"
local os = require "os"
local cookie = {}
local day = 24 * 60 * 60

local function cook()
    local cook, err = ck:new()
    if not cookie then
        ngx.log(ngx.ERR, err)
        return
    end
    return cook
end

function cookie.set(name, value, days)
    local cookie = cook();

    local ok, err = cookie:set({
        key = name,
        value = value,
        path = "/",
        secure = false, httponly = false,
        expires = os.date("!%A, %d-%b-%Y %H:%M:%S GMT", os.time() + days * day),
        max_age = 50,
        samesite = "Strict",
        extension = "a4334aebaec"
    })

    if not ok then
        ngx.log(ngx.ERR, err)
        return
    end
end

function cookie.get(name)
    local cookie = cook();
    local field, err = cookie:get(name)
    if not field then
        ngx.log(ngx.ERR, err)
    end
    return field
end

return cookie