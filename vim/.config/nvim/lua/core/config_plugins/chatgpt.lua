require("chatgpt").setup({
    api_key_cmd = "op read op://private/OpenAI/API_ARCH_DESKTOP --no-newline"
})

vim.keymap.set("n", "<leader>gpt", ":ChatGPT<CR>")
vim.keymap.set("n", "<leader>gpa", ":ChatGPTActAs<CR>")
vim.keymap.set("n", "<leader>gpc", ":ChatGPTCompleteCode<CR>")
vim.keymap.set("n", "<leader>gpe", ":ChatGPTEditWithInstructions<CR>")
vim.keymap.set("n", "<leader>gpr", ":ChatGPTRun<CR>")
