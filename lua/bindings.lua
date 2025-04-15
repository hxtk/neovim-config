local map = vim.keymap.set

-- diagnostic
local diagnostic_goto = function(len, severity)
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        vim.diagnostic.jump({ count = len, float = true, severity = severity })
    end
end

local setup = function()
    map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
    map("n", "]d", diagnostic_goto(1), { desc = "Next Diagnostic" })
    map("n", "[d", diagnostic_goto(-1), { desc = "Prev Diagnostic" })
    map("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next Error" })
    map("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev Error" })
    map("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next Warning" })
    map("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev Warning" })
end

return {
    setup = setup,
}
