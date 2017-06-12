local template = require "resty.template"
local locale = require "app.modules.locale"
local renderData = {
    page_title = locale.main_title,
    style = 'static/css/main.css'
}

template.render("main.html", renderData)