class AllKeyBinder{
    __New(callback, pfx := "~*"){
        static mouseButtons := ["LButton", "RButton", "MButton", "XButton1", "XButton2", "WheelUp", "WheelDown"]
        keys := {}
        this.Callback := callback
        Loop 512 {
            i := A_Index
            code := Format("{:x}", i)
            n := GetKeyName("sc" code)
            if (!n || keys.HasKey(n))
                continue
            keys[n] := code
            
            fn := this.KeyEvent.Bind(this, "Key", i, n, 1)
            hotkey, % pfx "SC" code, % fn, On
            
            fn := this.KeyEvent.Bind(this, "Key", i, n, 0)
            hotkey, % pfx "SC" code " up", % fn, On             
        }
        
        for i, k in mouseButtons {
            fn := this.KeyEvent.Bind(this, "Mouse", i, n, 1)
            hotkey, % pfx k, % fn, On
            
            fn := this.KeyEvent.Bind(this, "Mouse", i, n, 0)
            hotkey, % pfx k " up", % fn, On             
        }
    }
    
    KeyEvent(type, code, name, state){
        if (type == "Mouse") {
            if (code == 6) {
                name := "WheelUp"
            } else if (code == 7) {
                name := "WheelDown"
            } else if (code == 1) {
                name := "LButton"
            } else if (code == 2) {
                name := "RButton"
            } else if (code == 3) {
                name := "MButton"
            } else if (code == 4) {
                name := "XButton1"
            } else if (code == 5) {
                name := "XButton2"
            }
        }
        this.Callback.Call(type, code, name, state)
    }
   
}