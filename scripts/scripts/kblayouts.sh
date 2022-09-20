atreus_id=$(xinput | rg 'Atreus Keyboard.+keyboard'|cut -f 2|cut -d= -f2)
moonlander_id=$(xinput | rg 'Moonlander Mark I    .+keyboard'|cut -f 2|cut -d= -f2)
setxkbmap us -variant dvp -option ctrl:swapcaps -option compose:ralt
setxkbmap -device "$atreus_id" us -option
setxkbmap -device "$atreus_id" us -option compose:ralt
setxkbmap -device "$moonlander_id" us -option compose:ralt
