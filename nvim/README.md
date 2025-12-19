# Mi configuración de neovim
![Mi entorno neovim 1](./resources/Main.png)
![Mi entorno neovim 2](./resources/Main2.png)
## Requerimientos
* `Nightly`:

    Necesario para buscador difuso de blim.cmp, se debe instalar rustup para poder instalar nightly(`rustup install nightly`).
    Podemos poner a nightly pro default o hacer lo siguiente apara que solo nuestra configuración lo utilize para que compile el buscador difuso en la instalación de blink.cmp:
    ~~~
    cd ~/.config/nvim
    rustup override set nightly
    ~~~

* `xclip`

    Necesario para que neovim pueda acceder al portapapeles del sistema permitiendo así copiar/pegar contenido entre neovim y otras aplicaciones
* `nodejs, npm`

    Necesario para instalación de servidores lsp
* `gcc`

    Utilizado en nvim-treesitter en la compilación de parsers
* `ripgrep`

    Necesario para las búsquedas con fzfLua live_grep

## Temas
### Onedark Pro

|Onedark|Onedark Dark| 
|---|---| 
|![Onedark](../.resources/nvim/themes/onedark.png)| ![OnedarkDark](../.resources/nvim/themes/onedarkDark.png)|

|Onedark Light|Onedark Vivid|
|---|---|
|![OnedarkLight](../.resources/nvim/themes/onedarkLight.png)|![OnedarkVivid](../.resources/nvim/themes/onedarkVivid.png)|


### Catppuccin

|Frappe|Latte|
|---|---|
|![CatppuccinFrappe](../.resources/nvim/themes/catppuccinFrappe.png)|![CatppuccinLatte](../.resources/nvim/themes/catppuccinLatte.png)|

|Macchiato|Mocha|
|---|---|
|![CatppuccinMacchiato](../.resources/nvim/themes/catppuccinMacchiato.png)|![CatppuccinMocha](../.resources/nvim/themes/catppuccinMocha.png)|

### Monokai Pro

|Light|Machine|
|---|---|
|![MonokaiProLight](../.resources/nvim/themes/monokaiproLight.png)|![MonokaiProMachine](../.resources/nvim/themes/monokaiproMachine.png)|

|Octagon|Ristretto|
|---|---|
|![MonokaiProOctagon](../.resources/nvim/themes/monokaiproOctagon.png)|![MonokaiProRistretto](../.resources/nvim/themes/monokaiproRistretto.png)|

|Spectrum | 
|---|
|![MonokaiProSpectrum](../.resources/nvim/themes/monokaiproSpectrum.png)|
### Solarized

|Solarized | 
|---|
|![Solarized](../.resources/nvim/themes/solarized.png)|

### Gruvbox

|Gruvbox| 
|---|
|![Gruvbox](../.resources/nvim/themes/gruvbox.png)|

### Tundra

|Tundra | 
|---|
|![Tundra](../.resources/nvim/themes/tundra.png)|

# Demo
![Demo](../.resources/nvim/neovim.gif)

# Install
~~~bash
git clone --depth 1 https://gitlab.com/irbinr1/dotfiles.git ~/.config/nvim && rm -rf ~/.config/nvim/resources && nvim
~~~

# Uninstall
~~~bash
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
~~~

