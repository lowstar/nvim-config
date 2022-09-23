local notify = require("notify")

notify.setup({
    stages = "fade_in_slide_out",
    render = "minimal",
    timeout = 2000,
})

vim.notify = notify
