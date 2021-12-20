;region ;Functions; ######################################################################
varExist(ByRef v) { ; Requires 1.0.46+
   return &v = &n ? 0 : v = "" ? 2 : 1 
}
regionGetColor(x, y, w, h, hwnd=0) {
; created by Infogulch - thanks to Titan for much of this
; x, y, w, h  ~  coordinates of the region to average
; hwnd        ~  handle to the window that coords refers to
   DllCall("QueryPerformanceCounter", "Int64 *", Start1)
   If !hwnd, hdc := GetDC( hwnd )
      hcdc := hdc
   Else
   {
      WinGetPos, , , hwndW, hwndH, ahk_id %hwnd%
      hcdc := CreateCompatibleDC( hdc )
      , hbmp := CreateCompatibleBitmap( hdc, hwndW, hwndH )
      , hobj := SelectObject( hcdc, hbmp )
      , PrintWindow( hwnd, hcdc, 0 )
   }
   memdc := CreateCompatibleDC( hdc )
   , membmp := CreateCompatibleBitmap( hdc, w, h )
   , memobj := SelectObject( memdc, membmp )
   , BitBlt( memdc, 0, 0, w, h, hcdc, x, y, 0xCC0020 )
   , fmtI := A_FormatInteger
   SetFormat,    Integer, Hex
   retval := AvgBitmap(membmp, w * h) + 0
   SetFormat,    Integer, %fmtI%
   
   If hbmp
      DeleteObject(hbmp), SelectObject(hcdc, hobj), DeleteDC(hcdc)
   DeleteObject(membmp), SelectObject(memdc, memobj), DeleteDC(memdc)
   , ReleaseDC(hwnd, hdc)
   , DllCall("QueryPerformanceCounter", "Int64 *", End1), DllCall("QueryPerformanceFrequency", "Int64 *", f)
   return retval, ErrorLevel := (End1-Start1)/f
}

AvgBitmap(hbmp, pc) {
; by Infogulch
; hbmp  ~  handle to an existing bitmap
; pc    ~  size of the bitmap, should be w * h
; http://msdn.microsoft.com/en-us/library/dd144850(VS.85).aspx
   DllCall("GetBitmapBits", "UInt", hbmp, "UInt", VarSetCapacity(bits, pc*4, 0), "UInt", &bits)
   SumIntBytes(bits, pc, ca, cr, cg, cb)
   return ((Round(cr/pc) & 0xff) << 16) | ((Round(cg/pc) & 0xff) << 8) | (Round(cb/pc) & 0xff)
}

SumIntBytes( ByRef arr, len, ByRef a, ByRef r, ByRef g, ByRef b ) {
; by infogulch
; 32 bit:             16,843,009 px ||       4,104 x       4,104 px screen
; 64 bit: 72,340,172,838,076,673 px || 268,961,285 x 268,961,285 px screen
  static f
  
  if !f
  {
   f := MCode("
   (LTrim Join
   1,x86:8b44240833c9568b742408c7442408000000008d04868bd02bd683c203c1ea023bf00f47d185d2745f538b5c241c55
   8b6c241c578b0e8d76048b7c241c8bc1c1e81801078bc78b7c2428835004008bc1c1e81025ff0000000145008bc183550400
   c1e80825ff00000001030fb6c18353040001078b4424148357040040894424143bc275af5f5d5b5ec3,x64:48895c2408488
   97c24104533db8bc2498bf8488d14814c8bd1488bda482bd94883c30348c1eb02483bca490f47db4885db7443488b5424304
   c8b4424280f1f00418b0a49ffc34d8d52048bc148c1e8184801078bc148c1e8100fb6c04901018bc148c1e8080fb6c049010
   00fb6c14801024c3bdb75ca488b5c2408488b7c2410c3
   )")
  }
   DllCall( f, "ptr", &arr, "uint", len
    , "int64*", a, "int64*", r, "int64*", g, "int64*", b
    , "CDecl")
}

MCode(mcode)
{
  static e := {1:4, 2:1}, c := (A_PtrSize=8) ? "x64" : "x86"
  if (!regexmatch(mcode, "^([0-9]+),(" c ":|.*?," c ":)([^,]+)", m))
    return
  if (!DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", 0, "uint*", s, "ptr", 0, "ptr", 0))
    return
  p := DllCall("GlobalAlloc", "uint", 0, "ptr", s, "ptr")
  if (c="x64")
    DllCall("VirtualProtect", "ptr", p, "ptr", s, "uint", 0x40, "uint*", op)
  if (DllCall("crypt32\CryptStringToBinary", "str", m3, "uint", 0, "uint", e[m1], "ptr", p, "uint*", s, "ptr", 0, "ptr", 0))
    return p
  DllCall("GlobalFree", "ptr", p)
}

regionWaitColor(color, X, Y, W, H, hwnd=0, interval=100, timeout=5000, a="", b="", c="") {
   CompareColor := (color != "" ? color : regionGetColor(X, Y, W, H, hwnd))
   Start := A_TickCount
   while !(color ? retVal : !retVal) && !(timeout > 0 ? A_TickCount-Start > timeout : 0) 
   {
      retVal := regionCompareColor( CompareColor, x, y, w, h, hwnd, a, b, c)
      If interval
         Sleep interval
   }
   ErrorLevel := A_TickCount-Start
   Return (color ? retVal : !retVal)
}

regionCompareColor(color, x, y, w, h, hwnd=0, a="", b="", c="") {
   return withinVariation(regionGetColor(x, y, w, h, hwnd), color, a, b, c)
}

withinVariation( x, y, a, b="", c="") { 
; return wether x is within ±A ±B ±C of y
; if a is blank return wether x = y
; if b or c is blank, they are set equal to a
    If (a = "")
        return (x = y)
    v := Variation(x, y)
    return v >> 16 & 0xFF <= a
        && v >> 8  & 0xFF <= (b+0 ? b : a)
        && v       & 0xFF <= (c+0 ? c : a)
}

Variation( x, y ) {
    return Abs((x & 0xFF0000) - (y & 0xFF0000))
         | Abs((x & 0x00FF00) - (y & 0x00FF00))
         | Abs((x & 0x0000FF) - (y & 0x0000FF))
}

invertColor(x, a = "") {
; by Infogulch
; inverts the rgb/bgr hex color passed
; x: color to be inverted
; a: true to invert alpha as well
   return ~x & (a ? 0xFFFFFFFF : 0xFFFFFF)
}

/* Old version, if you want to compare performance
AvgBitmap(hbmp, pc) {
; by Infogulch
; hbmp  ~  handle to an existing bitmap
; pc    ~  size of the bitmap, should be w * h
; http://msdn.microsoft.com/en-us/library/dd144850(VS.85).aspx
   cb := cg := cr := 0
   DllCall("GetBitmapBits", "UInt", hbmp, "UInt", VarSetCapacity(bits, pc*4, 0), "UInt", &bits)
   Loop, % pc
   {
      a := NumGet(bits, A_Index*4-4)
      , cr += a >> 16 & 0xff
      , cg += (a >> 8) & 0xff
      , cb += a & 0xff
   }
   return ((Round(cr/pc) & 0xff) << 16) | ((Round(cg/pc) & 0xff) << 8) | (Round(cb/pc) & 0xff)
}
*/
;end_region

;region ;mfc wrapper;#####################################################################
CreateCompatibleDC(hdc=0) {
   return DllCall("CreateCompatibleDC", "UInt", hdc)
}     

CreateCompatibleBitmap(hdc, w, h) {
   return DllCall("CreateCompatibleBitmap", UInt, hdc, Int, w, Int, h)
}

SelectObject(hdc, hgdiobj) {
   return DllCall("SelectObject", "UInt", hdc, "UInt", hgdiobj)
}

GetDC(hwnd=0) {
   return DllCall("GetDC", "UInt", hwnd)
}

BitBlt( hdc_dest, x1, y1, w1, h1 , hdc_source, x2, y2 , mode ) {
   return DllCall("BitBlt"
          , UInt,hdc_dest   , Int, x1, Int, y1, Int, w1, Int, h1
          , UInt,hdc_source , Int, x2, Int, y2
          , UInt, mode) 
}

DeleteObject(hObject) {
   Return, DllCall("DeleteObject", "UInt", hObject)
}

DeleteDC(hdc) {
   Return, DllCall("DeleteDC", "UInt", hdc)
}

ReleaseDC(hwnd, hdc) {
   Return, DllCall("ReleaseDC", "UInt", hwnd, "UInt", hdc)
}

PrintWindow(hwnd, hdc, Flags=0) {
   return DllCall("PrintWindow", "UInt", hwnd, "UInt", hdc, "UInt", Flags)
}
;end_region