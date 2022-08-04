require("orgmode").setup_ts_grammar()

require("orgmode").setup({
    org_agenda_files = { "~/Documents/agenda.org", "~/Documents/ttv-journal.org" },
    org_default_notes_file = "~/Documents/agenda.org",
    win_split_mode = "float",
})
