#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
global no_ui := false
; Read the clipboard content
clipboard_content := Clipboard

scriptlog("clipboard: " . clipboard_content)

; Split the content into chunks of 499 characters
chunk_size := 499
chunks := []
Loop, Parse, clipboard_content, % chunk_size
{
    chunks.Push(A_LoopField)
}

; Counter to keep track of the current chunk index
chunk_index := 1
; Flag to indicate whether the next chunk should be set on clipboard
set_next_chunk := true
; Register the hotkey
^v::
    set_next_chunk := true
    return
+Insert::
    set_next_chunk := true
    return

; Main loop to set the chunks on clipboard
Loop
{
    if (set_next_chunk)
    {
        ; Get the next chunk
        chunk := chunks[chunk_index]

        ; Set the chunk on clipboard
        Clipboard := chunk

        ; Update the chunk index and reset the flag
        chunk_index := (chunk_index + 1) / chunks.Length()
        set_next_chunk := false
        scriptlog("ready to paste chunk " . Clipboard)
    }
    ; Sleep to reduce CPU usage
    Sleep 100
}
