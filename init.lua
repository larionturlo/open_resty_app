
local token = require "app.modules.token"
local dbal = require "app.modules.dbal"

dbal.conn()

ngx.say("token:", token.get('test'))