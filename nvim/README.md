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
|![Onedark](./resources/themes/onedark.png)| ![OnedarkDark](./resources/themes/onedarkDark.png)|

|Onedark Light|Onedark Vivid|
|---|---|
|![OnedarkLight](./resources/themes/onedarkLight.png)|![OnedarkVivid](./resources/themes/onedarkVivid.png)|

### Catppuccin

|Frappe|Latte|
|---|---|
|![CatppuccinFrappe](./resources/themes/catppuccinFrappe.png)|![CatppuccinLatte](./resources/themes/catppuccinLatte.png)|

|Macchiato|Mocha|
|---|---|
|![CatppuccinMacchiato](./resources/themes/catppuccinMacchiato.png)|![CatppuccinMocha](./resources/themes/catppuccinMocha.png)|

### Monokai Pro

|Light|Machine|
|---|---|
|![MonokaiProLight](./resources/themes/monokaiproLight.png)|![MonokaiProMachine](./resources/themes/monokaiproMachine.png)|

|Octagon|Ristretto|
|---|---|
|![MonokaiProOctagon](./resources/themes/monokaiproOctagon.png)|![MonokaiProRistretto](./resources/themes/monokaiproRistretto.png)|

|Spectrum | 
|---|
|![MonokaiProSpectrum](./resources/themes/monokaiproSpectrum.png)|
### Solarized

|Solarized | 
|---|
|![Solarized](./resources/themes/solarized.png)|

### Gruvbox

|Gruvbox| 
|---|
|![Gruvbox](./resources/themes/gruvbox.png)|

### Tundra

|Tundra | 
|---|
|![Tundra](./resources/themes/gruvbox.png)|

# Demo
![Demo](./resources/neovim.gif)

# Install
~~~bash
git clone --depth 1 https://gitlab.com/irbinr1/dotfiles.git ~/.config/nvim && rm -rf ~/.config/nvim/resources && nvim
~~~

# Unistall
~~~bash
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
~~~

