local function setup_mason_tool_installer()
    require('mason-tool-installer').setup {

        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        --
        -- List of available packages
        -- https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
        ensure_installed = {
            'bash-language-server',
            'lua-language-server',
            'vim-language-server',
            -- 'java-language-server', -- error installing maven build?
            'jdtls',
            'stylua',
            'shellcheck',
            -- 'editorconfig-checker',
            -- 'luacheck', -- requires luarocks
            -- 'misspell', -- depends on go
            'shellcheck',
            'shfmt',
            'vint',
            'solargraph',
            'clangd',
            'clang-format',
            'json-lsp',
	    'gopls',
	    'goimports',
	    'rust_analyzer',
        },

        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 1500, -- 1.5 second delay
    }
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
        })

        -- ensure installed
        setup_mason_tool_installer()

        -- enable/configure lsp servers via lspconfig
        mason_lspconfig_setup_handlers()


    end
}
