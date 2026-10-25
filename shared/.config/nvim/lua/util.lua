-- allow vim.pack to accept a data argument that specifies additional commands to be executed on update
vim.api.nvim_create_autocmd("PackChanged", {
  pattern = "*",
  callback = function(e)
    local run_func = (e.data.spec.data or {}).run
    
    if e.data.kind ~= "delete" and type(run_func) == "function" then
      local success, err = pcall(run_func, e.data)
      if not success then 
        vim.notify("Build failed: " .. err, vim.log.levels.ERROR) 
      end
    end
  end,
})
