if &compatible
  set nocompatible
end

" Remove declared plugins
function! s:UnPlug(plug_name)
  if has_key(g:plugs, a:plug_name)
    call remove(g:plugs, a:plug_name)
  endif
endfunction
command!  -nargs=1 UnPlug call s:UnPlug(<args>)

let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'vim-scripts/taglist.vim'
Plug 'mileszs/ack.vim'

if g:has_async
  " Plugins require async
endif

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

call plug#end()