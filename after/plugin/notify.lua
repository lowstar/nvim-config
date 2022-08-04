local notify = require("notify")

notify.setup({
    stages = "static",
    render = "minimal",
    timeout = 2000,
})

vim.notify = notify
