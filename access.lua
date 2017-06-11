local token = require "app.modules.token"
local cookie = require "app.modules.cookie"

local token_name = cookie.get('token_name')
if not token_name then
    return ngx.redirect("/login")
end

local token_value = cookie.get('token_value')
if not token_name then
    return ngx.redirect("/login")
end

local found_token = token.get(token_name)

if not found_token == token_value then
    return ngx.redirect("/login")
end