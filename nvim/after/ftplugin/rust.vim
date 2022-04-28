nnoremap <F4> :RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
inoremap <F4> <ESC>:RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
vnoremap <F4> <ESC>:RustFmt<ENTER>:w<ENTER>:RustTest!<ENTER><CR>
nnoremap <F5> :RustFmt<ENTER>:w<ENTER>:Dispatch !cargo run<ENTER>
inoremap <F5> <ESC>:RustFmt<ENTER>:w<ENTER>:Dispatch !cargo run<ENTER>
vnoremap <F5> <ESC>:RustFmt<ENTER>:w<ENTER>:Dispatch !cargo run<ENTER>
