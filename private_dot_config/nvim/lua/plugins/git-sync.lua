local wiki_dir = vim.fn.expand("~/git/wiki")
local work_dir = vim.fn.expand("~/git/work-notes")

local repos = {}

if vim.fn.isdirectory(wiki_dir) then
	table.insert(repos, {
		path = "~/git/wiki",
		sync_interval = 15,
		commit_template = "AUTOCOMMIT - [{hostname}] - {timestamp}",
	})
end

if vim.fn.isdirectory(work_dir) then
	table.insert(repos, {
		path = "~/git/work-notes",
		sync_interval = 30,
		commit_template = "AUTOCOMMIT - [{hostname}] - {timestamp}",
	})
end

return {
	"BladeWDR/git-sync.nvim",
	opts = {
		repos = repos,
	},
}
