#Requires AutoHotkey v2.0.19+

; Create a hotkey to assign view toggling for the picker
*F1::Picker.toggle()

class Picker {
    static gui := Gui()
    
    static __New() {
        this.make_gui()
        this.adjust_tray_menu()
    }
    
    static make_gui() {
        width := 350
        
        ; Setup gui
        goo := this.gui := Gui('-DPIScale')
        goo.BackColor := 0x181818
        goo.SetFont('s12 cWhite', 'Times New Roman')
        goo.SetFont(, 'Consolas')
        
        ; Add names to pick from
        goo.AddText('xm w' width,'Add a list of items.`nPut each item on its own line.')
        goo.AddEdit('xm wp r10 vedt_itemlist +Multi Background303030')
        
        ; Choose total winners
        goo.AddText('xm wp', 'How many to pick?')
        con := goo.AddEdit('xm w50 Number vedt_picktotal Background303030')
        goo.AddUpDown(, 1)
        con.OnEvent('Change', validate_number)
        
        ; Button to pick winners
        con := goo.AddButton('xm w' width, 'Randomly select item(s)!')
        con.OnEvent('Click', random_selection)
        
        ; Winner display box
        goo.AddText('xm wp', 'Winners!')
        goo.AddEdit('xm wp r10 vedt_winners +Multi Background303030')
        
        ; Hide name picker until need again
        con := goo.AddButton('xm', 'Close Picker')
        con.OnEvent('Click', (*) => this.gui.Hide())
        
        ; Allow gui to be moved by clicking and dragging
        WM_MOUSEMOVE := 0x0200
        OnMessage(WM_MOUSEMOVE, on_mouse_move)
        
        goo.Show()
        return
        
        on_mouse_move(Wparam, Lparam, Msg, Hwnd) {
            static WM_NCLBUTTONDOWN := 0x00A1
            MouseGetPos(,,, &con_hwnd, 2)
            if (Wparam = 1)
                SendMessage(WM_NCLBUTTONDOWN, 2,,, 'ahk_id ' this.gui.Hwnd)
        }
        
        validate_number(con, *) => (con.Text < 1) ? con.Text := 1 : 0
        random_selection(con, *) {
            unfiltered_list := StrSplit(Trim(con.gui['edt_itemlist'].Text), '`n', '`r')
            list := []
            for index, name in unfiltered_list
                if RegExMatch(name, '\S+')
                    list.Push(name)
            winners := ''
            win_count := 0
            loop Number(con.Gui['edt_picktotal'].Text)
                win_count++
                ,winner_list .= win_count ': ' list.RemoveAt(Random(1, list.Length)) '`n'
            con.Gui['edt_winners'].Value := winner_list
        }
    }
    
    static adjust_tray_menu() {
        tray := A_TrayMenu
        tray.Delete()
        tray.Add('Show Picker', this.show.Bind(this))
        tray.Add()
        tray.AddStandard()
        tray.Default := 'Show Picker'
    }
    
    static show(*) => WinExist('ahk_id ' this.gui.hwnd) ? 0 : this.gui.Show()
    static hide(*) => WinExist('ahk_id ' this.gui.hwnd) ? this.gui.Hide() : 0
    static toggle(*) => WinExist('ahk_id ' this.gui.hwnd) ? this.gui.Hide() : this.gui.Show()
}
