if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Iosevka SS10 9')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
else
    GuiFont Iosevka SS10:h9
endif

