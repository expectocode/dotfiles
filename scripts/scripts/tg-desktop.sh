#!/bin/bash

# Switch to tg if it's open (then exit script)

for desktop in $(bspc query -D); do
    case $(bspc query -T -d "$desktop") in
        *TelegramDesktop*)
            bspc desktop "$desktop" -f

            for nid in $(bspc query -N -d "$desktop" -n .window); do
                case $(xtitle "$nid") in
                    *Telegram*)
                        bspc node -f "$nid"
                esac
            done
            exit
    esac
done

gdb --args /usr/bin/telegram-desktop "$@" << EOF
tbreak _ZN3App9initMediaEv
commands

    # Make all circled images into rounded rectangles
    # Original code doesn't matter much
    # This sets some arguments specific to pixRounded and jumps to it
    # The first few arguments are in the same order so no need to touch them
    # mov $0xffff,%r9d
    set {short}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+0) = 0xB941
    set {int}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+2) = 0xFFFF
    # mov $0x1,%r8d
    set {short}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+6) = 0xB841
    set {int}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+8) = 0x01
    # jmpq <_ZNK5Image10pixRoundedEN4Data10FileOriginEii16ImageRoundRadiusN4base5flagsI8RectPartEE>
    set {char}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+12) = 0xE9
    set {int}(_ZNK5Image10pixCircledEN4Data10FileOriginEii+13) = (_ZNK5Image10pixRoundedEN4Data10FileOriginEii16ImageRoundRadiusN4base5flagsI8RectPartEE) - (_ZNK5Image10pixCircledEN4Data10FileOriginEii + 17)

    # Make pins not notify by default
    # -mov $0x1,%ecx (imm part only)
    # +mov $0x0,%ecx (imm part only)
    set {int}(_ZN13PinMessageBox7prepareEv+424) = 0x0

    # Remove conditional jumps in toggleTabbedSelectorMode to never put a sidebar
    set {char [2]}(_ZN13HistoryWidget24toggleTabbedSelectorModeEv+80) = { 0x90, 0x90 }
    # - 75 59                 jne 0x10b5468
    # + 90 90                 nop nop
    set {char [2]}(_ZN13HistoryWidget24toggleTabbedSelectorModeEv+92) = { 0x90, 0x90 }
    # - 74 45                 je 0x10b5460
    # + 90 90                 nop nop
    set {char [2]}(_ZN13HistoryWidget24toggleTabbedSelectorModeEv+99) = { 0x90, 0x90 }
    # - 74 3e                 je 0x10b5460
    # + 90 90                 nop nop


    # Never default to sending files uncompressed if other option exists
    set {char}(_ZN12SendFilesBox11initSendWayEv+353) = 0x1
end
run
detach
quit
EOF

# TODO disable emoji panel on hover
# hasan's stuff:
    # set {char}(_ZN11ChatHelpers11TabbedPanel10otherEnterEv+0) = 0xc3

    # - e9 ab ff ff ff        jmp sym.ChatHelpers::TabbedPanel::showAnimated
    # + c3 90 90 90 90        ret; nop nop nop nop
