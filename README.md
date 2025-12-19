# ![dotfiles](./.resources/dotfiles.svg) DOTFILES
Mi configuración de GNU/Linux para kitty, alacritty, neovim y más.
> Para esta configuración uso la Shell [zsh](https://zsh.sourceforge.io/)

## Terminal
![Terminal](./.resources/terminal.png)
Para instalar kitty o alacritty podemos hacerlo con su gestor de paquetes de sus sistema en mi caso es Debian:
* kitty: `sudo apt install kitty`
* Alacritty: `sudo apt install alacritty`

> Antes de copiar las configuraciones para `kitty` o `alacritty` debemos borrar el directorio alacritty o kitty dentro de `~/.config` si se encontrara.

Copiar los directorios kitty o alacritty de este repositorio a `~/.config`

## Instalar Shell ZSH

1. Instalar ZSH con su gestor de paquetes de su sistema
```bash
sudo apt install zsh
```

2. Ejecutamos `ZSH` desde la terminal escribiendo zsh y nos lanzara una lista de opciones para generar el archivo de configuración `.zshrc`. Como recien hemos instalado zsh elegiremos la opción de configuración vacía.  

3. Cambiar el shell bash a zsh por defecto
```bash
sudo usermod --shell /usr/bin/zsh root
sudo usermod --shell /usr/bin/zsh $USER
```

4. Reiniciamos el sistema o cerramos sessión.

### Marco de configuraciones ZSH
Si bien el marco más popular es [ohmyszsh](https://ohmyz.sh/) pero yo voy a usar [ZimFw](https://github.com/zimfw/zimfw) como marco para ZSH.
Para instalarlo haremos uso de `curl` o `wget`
```bash
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

```bash
wget -nv -O - https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
```

Con esto ya tendras un prompt con el tema ascciship, así como también autocompletado, etc.
![Prompt](./.resources/zimfw.png)

Si bien zimfw trae por defecto un tema para el prompt yo instale un tema diferente para mi prompt el cual es [`starship`](https://starship.rs/),, pero para instalarlo debemos de desintalar el tema por defecto de zimfw para ello debemos abrir el archivo de configuración de zimfw con su editor de texto favorito: `nvim ~/.zimrc`.

Dentro del archivo borrar o comentar la linea donde este `zmodule asciiship`, guardamos y cerramos el archivo.

![zimrc](./.resources/zimrc.png)
En la terminal ejecutamos `zim uninstall` y con eso tendremos ya desinstalado el tema por defecto de zimfw, ahora pasaremos a instalar `starship` el cual en su [página](https://starship.rs/guide/#%F0%9F%9A%80-installation) nos da dos formas de instalarlo con el script o con su gestor de paquetes pero solo tiene para algunos sistemas, en mi caso lo instale con apt pero si no estuviera tu gestor de paquetes para `starship` entonces use el script que se instala con curl.
```bash
curl -sS https://starship.rs/install.sh | sh
```

Luego de haber instalado `starship` tenemos que agregar dentro del archivo `.zshrc` el siguiente comando:
```bash
eval "$(starship init zsh)"
```

![zshrch](./.resources/zshrc.png)

Listo al volver abrir la terminal nos aparecera algo como esto:

![starship](./.resources/starship.png)

> Para saber más [comandos](https://zimfw.sh/docs/commands/) de zimfw visitar su web oficial

## LSD
Si quieres que tu terminal se vea asi cuando uses `ls`

![lsd](./.resources/lsd.png)

