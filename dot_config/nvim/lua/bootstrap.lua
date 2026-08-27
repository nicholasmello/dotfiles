local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local offline_marker = vim.fn.stdpath("config") .. "/.offline"

-- Define your functions first

local function is_offline()
  return vim.fn.filereadable(offline_marker) == 1
end

local function set_offline()
  local f = io.open(offline_marker, "w")
  if f then
    f:write("offline\n")
    f:close()
  end
end

local function clear_offline()
  os.remove(offline_marker)
end

local function has_network()
  local handle = io.popen("ping -c 1 github.com 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result and #result > 0
  end
  return false
end

local function install_lazy()
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  print("lazy.nvim installed!")
end

-- Now call the functions

if not vim.loop.fs_stat(lazypath) then
  if is_offline() then
    print("Offline mode enabled. Skipping lazy.nvim install.")
    return
  else
    if has_network() then
      install_lazy()
      clear_offline()
    else
      print("No network detected. Enabling offline mode.")
      set_offline()
      return
    end
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
})

vim.api.nvim_create_user_command("GoOnline", function()
  clear_offline()
  print(".offline marker cleared. Restart Neovim to attempt plugin install again.")
end, {})
