return {
    -- make sure mason installs gopls language server
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
            } 
        }
    },
    --
    {
        "neovim/nvim-lspconfig",
        dependencies= {
            { "williamboman/mason-lspconfig.nvim" },
            { "williamboman/mason.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local util = require("lspconfig.util")
            
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                local opts = { noremap = true, silent = true }
                
                buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
                buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
                buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                client.server_capabilities.document_formatting = true
            end
            
            lspconfig.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {"gopls"},
                filetypes = {"go", "gomod", "gowork", "gotmpl"},
                root_dir= util.root_pattern("go.work", "go.mod", ".git"),
                settings =  {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        }
                    }
                }
            }
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft= "go",
        opts = function()
            return require "lahssen.configs.null-ls"
        end
    }
}