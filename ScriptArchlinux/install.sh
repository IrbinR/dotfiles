#!/bin/bash

cat <<EOF
┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓
╏             Script de instalación Archlinux              ╏
┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
EOF

set -e

read -p "Ingrese la ruta del disco a FORMATEAR(ej. /dev/sda): " DISCO
read -p "Ingrese el nombre del HOSTNAME: " HOSTNAME
read -p "Ingrese el nombre de USUARIO: " USUARIO


if [[ "$DISCO" == *"nvme"* ]] || [[ "$DISCO" == *"mmcblk"* ]]; then
    P1="${DISCO}p1"
    P2="${DISCO}p2"
    P3="${DISCO}p3"
else
    P1="${DISCO}1"
    P2="${DISCO}2"
    P3="${DISCO}3"
fi

DISCO_BYTES=$(blockdev --getsize64 "$DISCO")
DISCO_GB=$(( DISCO_BYTES / 1024 / 1024 / 1024 ))
DISCO_DISPONIBLE=$(( DISCO_GB - 1 )) 

cat <<EOF
┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓
╏       El disco $DISCO tiene un tamaño total de: ${DISCO_GB}GB        ╏
╏ Descontando EFI, te quedan aprox: ${DISCO_DISPONIBLE}GB disponibles. ╏
┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
EOF

read -p "Tamaño para ROOT (ej: 40G 0 50G) [por defecto +40G]: " TAMANIO_ROOT
TAMANIO_ROOT=${TAMANIO_ROOT:-+40G}
if [[ ! "$TAMANIO_ROOT" == +* ]]; then
    TAMANIO_ROOT="+$TAMANIO_ROOT"
fi

pacman -Sy curl --noconfirm
ZONA=$(curl -s https://ipapi.co/timezone || echo "America/Lima")
PAIS=$(curl -s https://ipapi.co/country/ || echo "PE")
if [[ ! -z "$PAIS" ]]; then
    PAIS=${PAIS^^}
    case "$PAIS" in
        US|CA|BZ|GY) IDIOMA="en";;
        BR) IDIOMA="pt";;
        SR) IDIOMA="nl";;
        GF) IDIOMA="fr";;
        *) IDIOMA="es";;
    esac
    LOCALE="${IDIOMA}_${PAIS}.UTF-8"
else
    LOCALE="es_PE.UTF-8"
fi


cat <<EOF
┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓
╏         CONFIGURACIÓN DE DISTRIBUCIÓN DE TECLADO         ╏
┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
1) Español Latinoamericano  (la-latin1)
2) Español de España        (es)
3) Inglés / Americano       (us)
4) Portugués / Brasil       (br-abnt2)
╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
EOF

read -p "Seleccione su tipo de teclado [1-4]: " OP_KEY

case "$OP_KEY" in
    1) KEYMAP="la-latin1" ;;
    2) KEYMAP="es" ;;
    3) KEYMAP="us" ;;
    4) KEYMAP="br-abnt2" ;;
    *) 
        echo "Opción no válida. Se asignará Latinoamericano por defecto."
        KEYMAP="la-latin1" 
        ;;
esac
loadkeys $KEYMAP

echo "━━ Actualizando reloj... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
timedatectl set-ntp true

echo "━━ Particionando disco $DISCO... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sfdisk "$DISCO" <<EOF
label: gpt
size=512M, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
size=$TAMANIO_ROOT, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF

echo "━━ Formateando particiones... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mkfs.fat -F32 -n "EFI" $P1
mkfs.ext4 -L "ROOT" $P2
mkfs.ext4 -L "HOME" $P3

echo "━━ Montando particiones... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mount $P2 /mnt
mkdir -p /mnt/boot
mount $P1 /mnt/boot
mkdir -p /mnt/home
mount $P3 /mnt/home

echo "━━ Optimizando Mirrors... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
pacman -Sy reflector python --noconfirm
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

if grep -q "AuthenticAMD" /proc/cpuinfo; then
    UCODE="amd-ucode"
elif grep -q "GenuineIntel" /proc/cpuinfo; then
    UCODE="intel-ucode"
else
    UCODE=""
fi

echo "━━ Instalando sistema base... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
pacstrap /mnt base base-devel nano linux linux-firmware linux-headers $UCODE mkinitcpio neovim networkmanager grub efibootmgr

echo "━━ Generando fstab... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
genfstab -U /mnt >> /mnt/etc/fstab

echo "━━ Configurando sistema... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
arch-chroot /mnt /bin/bash << CHROOT
set -e

ln -sf /usr/share/zoneinfo/$ZONA /etc/localtime
hwclock --systohc

echo "$LOCALE UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" > /etc/locale.conf
echo "KEYMAP=$KEYMAP" > /etc/vconsole.conf

echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts << HOSTS
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
HOSTS

systemctl enable NetworkManager

echo "━━ Instalando GRUB... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-install --target=x86_64-efi --efi-directory=/boot --removable
grub-mkconfig -o /boot/grub/grub.cfg

echo "━━ Creando usuario $USUARIO... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
useradd -m -G wheel -s /bin/bash $USUARIO

echo "━━ Configurando sudo... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sed -i 's/#\s*%wheel ALL=(ALL:ALL)\s*ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers 2>/dev/null || sed -i 's/#\s*%wheel ALL=(ALL)\s*ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

CHROOT

cat <<EOF
┏╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┓
╏ Instalación completada                                   ╏
╏ Establece contraseñas ahora:                             ╏
┗╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍┛
EOF
arch-chroot /mnt passwd
arch-chroot /mnt passwd $USUARIO

cat <<EOF
╓                                                          ╖
║               Listo, reinicia con: reboot                ║
╙                                                          ╜
EOF
