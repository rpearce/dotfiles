{ pkgs, ... }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};
in {
  programs.neovim = {
    enable = true;

		viAlias = true;
    vimAlias = true;

    configure = {
      customRC = builtins.readFile ./vimrc;

			plug.plugins = with plugins; [
				# Themes
				onedark-vim

				# Linting
				ale

				# Search
				ack-vim
				ctrlp-vim

				# Tools
				nerdcommenter
				nerdtree
				supertab
				tlib_vim
				vim-addon-mw-utils
				vim-buffergator
				vim-css-color
				vim-easymotion
				vim-endwise
				vim-eunuch
				vim-fugitive
				vim-gitgutter
				vim-multiple-cursors
				vim-snipmate
				vim-trailing-whitespace
				vim-vroom

				# Languages
				vim-polyglot
				#csv-vim
        #elm-vim
				#scss-syntax-vim
				#typescript-vim
				#vim-coffee-script
				#vim-elixir
				#vim-go
				#vim-haml
				#vim-haskell
				#vim-javascript
        #vim-jsx
        vim-markdown
				#vim-mustache-handlebars
        #vim-pug
				#vim-rails
				#vim-rspec
        #vim-ruby
        #vim-ruby-minitest
				#vim-scala
				vim-stylish-haskell
				#vimerl
			];
    };
  };
}
