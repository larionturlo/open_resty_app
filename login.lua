local template = require "resty.template"
local ck = require "resty.cookie"
local crypt = require "app.modules.crypt"
local token = require "app.modules.token"
local cookie = require "app.modules.cookie"
local locale = require "app.modules.locale"


local username = 'admin'
local passhash = 'f8723f09756270f2aaaaec30776fc317d3b6473b'
local renderData = {
    page_title = locale.login_title,
    style = 'static/css/login.css',
    error = '',
    username = ''
}

ngx.req.read_body()  -- explicitly read the req body
local data = ngx.req.get_body_data()
if data then
    local args = ngx.req.get_post_args()
    if crypt.sha1(args.password) == passhash and username == args.username then
        local tokenHash = crypt.sha1(passhash .. username)
        token.set(username, tokenHash)
        cookie.set('token_name',username,1)
        cookie.set('token_value',tokenHash,1)
        return ngx.redirect("/")
    end
    renderData.error = "Не верная пара Имя/Пароль"
    renderData.username = args.username
end

template.render("login.html", renderData)