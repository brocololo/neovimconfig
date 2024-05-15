-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

vim.api.nvim_create_autocmd({
	"BufNewFile",
	"BufRead",
}, {
	pattern = "**/ansible/**/*.yaml,**/ansible/**/*.yml",
	callback = function()
		if vim.fn.search("{{.\\+}}", "nw") ~= 0 then
			local buf = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_option(buf, "filetype", "yaml.ansible")
		end
	end,
})

vim.api.nvim_create_autocmd({
	"BufNewFile",
	"BufRead",
}, {
	pattern = "*.hcl.j2",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "filetype", "hcl")
	end,
})
