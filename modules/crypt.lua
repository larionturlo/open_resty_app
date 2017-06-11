local resty_sha1 = require "resty.sha1"
local str = require "resty.string"
local crypt = {}

function crypt.sha1(word)
    local sha1 = resty_sha1:new()
    if not sha1 then
        ngx.log(ngx.ERR,"failed to create the sha1 object")
        return
    end

    local ok = sha1:update(word)
    if not ok then
        ngx.log(ngx.ERR, "failed to add data")
        return
    end

    local digest = sha1:final()

    return str.to_hex(digest)
end

return crypt