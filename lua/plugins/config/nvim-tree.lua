-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
  return
end

local config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
  quit_on_open = 0,
  git_hl = 1,
  disable_window_picker = 0,
  root_folder_modifier = ":t",
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
}

local events_ok, nvim_tree_events = pcall(require, 'nvim-tree.events')
if not events_ok then
  return
end

local bufferline_ok, bufferline_state = pcall(require, 'bufferline.state')
if not bufferline_ok then
  return
end

local view_ok, nvim_tree_view = pcall(require, 'nvim-tree.view')
if not view_ok then
  return
end

local function get_tree_size()
  return nvim_tree_view.View.width
end

local username = os.getenv("USERNAME")

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size(), username)
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size(), username)
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)
