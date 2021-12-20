﻿; ======================================================================================================================
; Script Function:  Sample script for Class_SQLiteDB.ahk
; AHK Version:      L 1.1.00.00 (U32)
; Language:         English
; Tested on:        Win XPSP3, Win VistaSP2 (32 Bit)
; Author:           just me
; ======================================================================================================================
; AHK Settings
; ======================================================================================================================
#NoEnv
; #Warn
; #Warn LocalSameAsGlobal, Off
#SingleInstance force
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
; ======================================================================================================================
; Includes
#Include Class_SQLiteDB.ahk
; ======================================================================================================================
; Get the Google logo or store a picture named Original.gif in the script's folder and comment this out
FileDelete, Original.gif
URLDownloadToFile, http://www.google.de/intl/de_ALL/images/logos/images_logo_lg.gif, Original.gif
; ======================================================================================================================
; Start
FileDelete, Blob.gif
DBFileName := A_ScriptDir . "\TEST.DB"
If FileExist(DBFileName) {
   SB_SetText("Deleting " . DBFileName)
   FileDelete, %DBFileName%
}
; ======================================================================================================================
; Use Class SQLiteDB : Create new instance
DB := New SQLiteDB
; ======================================================================================================================
; Use Class SQLiteDB : Open/create database and table, insert a BLOB from a GIF file
If !DB.OpenDB(DBFileName) {
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
   ExitApp
}
HFILE := FileOpen("Original.gif", "r")
Size := HFILE.RawRead(BLOB, HFILE.Length)
HFILE.Close()
If !DB.Exec("CREATE TABLE Test (TextType, BlobType);")
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
DB.Exec("BEGIN TRANSACTION;")
; ? stands for an automatically numbered SQL parameter (here: 1)
SQL := "INSERT INTO Test VALUES('Text', ?);"
; Bind BLOB
If !DB.Prepare(SQL, ST)
   MsgBox, 16, DB.Prepare, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
If !ST.Bind(1, "Blob", &Blob, Size)
   MsgBox, 16, ST.Bind, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
If !ST.Step()
   MsgBox, 16, ST.Step, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
If !ST.Reset()
   MsgBox, 16, ST.Reset, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
If !ST.Free()
   MsgBox, 16, ST.Free, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
DB.Exec("COMMIT TRANSACTION;")
; ======================================================================================================================
; Start of query using Query() : Get the BLOB from table Test
HFILE := FileOpen("Blob.gif", "w")
If !DB.Query("SELECT * FROM Test;", RecordSet)
   MsgBox, 16, SQLite Error: Query, % "Msg:`t" . RecordSet.ErrorMsg . "`nCode:`t" . RecordSet.ErrorCode
If (RecordSet.HasRows) {
   If (RecordSet.Next(Row) < 1) {
      MsgBox, 16, %A_ThisFunc%, % "Msg:`t" . RecordSet.ErrorMsg . "`nCode:`t" . RecordSet.ErrorCode
      Return
   }
   Loop, % RecordSet.ColumnCount {
      If IsObject(Row[A_Index]) {
         Size := Row[A_Index].Size
         Addr := Row[A_Index].GetAddress("Blob")
         If !(Addr) || !(Size) {
            MsgBox, 0, Error, BlobAddr = %Addr% - BlobSize = %Size%
         } Else {
            VarSetCapacity(MyBLOBVar, Size) ; added
            DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", &MyBLOBVar, "Ptr", Addr, "Ptr", Size) ; added
            HFILE.RawWrite(&MyBLOBVar, Size) ; changed
            ; HFILE.RawWrite(Addr + 0, Size) ; original
         }
      }
   }
}
RecordSet.Free()
HFILE.Close()
RecordSet.Free()
; ======================================================================================================================
; Show the result
Gui, Margin, 20, 20
Gui, Add, Text, Section, Original from Google:
Gui, Add, Pic, y+5, Original.gif
Gui, Add, Text, ys, Copy out of database:
Gui, Add, Pic, y+5, Blob.gif
Gui, Show, , Pictures
FileDelete, Original.gif
FileDelete, Blob.gif
Return
GuiClose:
GuiEscape:
ExitApp