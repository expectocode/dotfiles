#!/bin/bash

gdb --args /usr/bin/telegram-desktop "$@" << EOF
tbreak _ZN3App9initMediaEv
commands
    # TODO find a way to change this value (it's in RO data)
    #set {int}(_ZN2st20historyMessageRadiusE) = 3

    # Make all circled images into rounded rectangles
    set {char}(_ZNK5Image10pixCircledEii+0) = 0x41
    set {char}(_ZNK5Image10pixCircledEii+1) = 0xB8
    set {int}(_ZNK5Image10pixCircledEii+2) = 0xFFFF
    set {char}(_ZNK5Image10pixCircledEii+6) = 0xB9
    set {int}(_ZNK5Image10pixCircledEii+7) = 0x01
    set {char}(_ZNK5Image10pixCircledEii+11) = 0xE9
    set {int}(_ZNK5Image10pixCircledEii+12) = (_ZNK5Image10pixRoundedEii16ImageRoundRadiusN4base5flagsI8RectPartEE) - (_ZNK5Image10pixCircledEii + 16)

    # Make pins not notify by default
    set {int}(_ZN13PinMessageBox7prepareEv+619) = 0x0
end
run
detach
quit
EOF
