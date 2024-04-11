-- A function to move selected lines down in visual mode
function move_lines_down_visual()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local last_line = vim.api.nvim_buf_line_count(0)

	local selected_line_count = vim.fn.line("'>") - vim.fn.line("'<")

	-- When we hit the bottom we just reselect the lines
	if current_line + selected_line_count < last_line then
		vim.api.nvim_command("'<, '>m '>+1")
		vim.api.nvim_command("normal! gv=gv")
	elseif current_line + selected_line_count >= last_line then
		vim.api.nvim_command("normal! gv")
	end
end


-- A function to move selected lines up in visual mode
function move_lines_up_visual()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	-- When we hit the top we just reselect the lines
	if current_line > 1 then
		vim.api.nvim_command("'<, '>m '<-2")
		vim.api.nvim_command("normal! gv=gv")
	elseif current_line >= 1 then 
		vim.api.nvim_command("normal! gv")
	end
end


-- Set key mappings to call the functions above
vim.api.nvim_set_keymap('v', 'J', [[:lua move_lines_down_visual()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', [[:lua move_lines_up_visual()<cr>]], { noremap = true, silent = true })


-- Remap Esc to jj to enter normal mode
vim.keymap.set('i', 'jj', '<Esc>')


-- Set buffer navigation remaps
vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<BS>", ":bp<CR>")


-- Select all from current buffer
vim.keymap.set("n", "<C-a>", "ggVG")


-- Keymaps for using system clipboard
vim.keymap.set("n", ",y", '"+y')
vim.keymap.set("n", ",p", '"+p')

vim.keymap.set("v", ",y", '"+y')
vim.keymap.set("v", ",p", '"+p')


-- Ctrl+p not to loose the stuff youre pasting over with
vim.keymap.set("x", "<C-p>", "\"_dP")
