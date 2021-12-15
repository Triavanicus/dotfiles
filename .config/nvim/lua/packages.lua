local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- Have packer manage itself
    use 'wbthomason/packer.nvim'

    -- Color Themes
    use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}

    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}

    -- Auto Completion
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
    use {'hrsh7th/nvim-cmp'}
    use {'onsails/lspkind-nvim'}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
