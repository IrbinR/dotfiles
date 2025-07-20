# Configuración Personal de Neovim
## Requisitos
Antes de instalar mi configuracion personal asegurate que tengas esto instalado para que no surga ningún error.
- `tree-sitter-cli` -> Para instalación automatica de los lenguajes de resaltado
    ~~~
    npm install -g tree-sitter-cli
    ~~~
- `rustup` -> Para que funcione correctamente blink.cmp
    La instalación puede ser con curl o con tu administrador de paquetes(pacman, apt, dnf, etc).

    Con curl:

    ~~~
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    ~~~
    Con un administrador de paquetes, en mi caso lo hago con pacman:

    ~~~
    sudo pacman -S rustup
    ~~~

    **Post-instalacion de rustup**
    ----
    ~~~
    rustup install nightly
    ~~~
    > rustup nos va servir para instalar nightly el cual nos va ayudar a compilar blink.cmp

