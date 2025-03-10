class Strung {
    __New(str) {
        this._str := str
    }

    value() {
        return this._str
    }

    ; at()
    static at(str, index) {
        currentIndex := 1
        Loop Parse, str {
            if (currentIndex == index) {
                return A_LoopField
            }
            currentIndex++
        }
    }

    at(index) {
        this._str := Strung.at(this._str, index)
        return this
    }

    ; concat()
    static concat(str, others*) {
        if (others.Length == 1 && others[1] is Array) {
            others := others[1]
        }
        newStr := str
        for other in others {
            newStr := newStr . other
        }
        return newStr
    }

    concat(others*) {
        this._str := Strung.concat(this._str, others*)
        return this
    }

    ; endsWith()
    static endsWith(str, suffix) {
        return SubStr(str, -StrLen(suffix)) == suffix
    }

    endsWith(suffix) {
        return Strung.endsWith(this._str, suffix)
    }

    ; contains() / includes()
    static contains(str, search) {
        return InStr(str, search, true) > 0
    }

    contains(search) {
        return Strung.contains(this._str, search)
    }

    ; includes()
    static includes(str, search) {
        return Strung.contains(str, search)
    }

    includes(search) {
        return Strung.contains(this._str, search)
    }

    ; indexOf()
    static indexOf(str, search, fromIndex := 1) {
        return InStr(str, search, true, fromIndex)
    }

    indexOf(search, fromIndex := 1) {
        return Strung.indexOf(this._str, search, fromIndex)
    }

    ; lastIndexOf()
    static lastIndexOf(str, search) {
        return InStr(str, search, true, -1)
    }

    lastIndexOf(search) {
        return Strung.lastIndexOf(this._str, search)
    }
    
    ; padEnd()
    static padEnd(str, targetLength, padString := " ") {
        if (StrLen(str) >= targetLength) {
            return str
        }
        return str . Strung.repeat(padString, targetLength - StrLen(str))
    }

    padEnd(targetLength, padString := " ") {
        this._str := Strung.padEnd(this._str, targetLength, padString)
        return this
    }

    ; rightPad()
    static rightPad(str, targetLength, padString := " ") {
        return Strung.padEnd(str, targetLength, padString)
    }

    rightPad(targetLength, padString := " ") {
        this._str := Strung.rightPad(this._str, targetLength, padString)
        return this
    }

    ; padStart()
    static padStart(str, targetLength, padString := " ") {
        if (StrLen(str) >= targetLength) {
            return str
        }
        return Strung.repeat(padString, targetLength - StrLen(str)) . str
    }

    padStart(targetLength, padString := " ") {
        this._str := Strung.padStart(this._str, targetLength, padString)
        return this
    }

    ; leftPad()
    static leftPad(str, targetLength, padString := " ") {
        return Strung.padStart(str, targetLength, padString)
    }

    leftPad(targetLength, padString := " ") {
        this._str := Strung.leftPad(this._str, targetLength, padString)
        return this
    }

    ; repeat()
    static repeat(str, count) {
        newStr := ""
        Loop count {
            newStr := newStr . str
        }
        return newStr
    }

    repeat(count) {
        this._str := Strung.repeat(this._str, count)
        return this
    }

    ; replace()
    static replace(str, search, replace) {
        outputVarCount := unset
        return RegExReplace(str, search, replace, &outPutVarCount, 1)
    }

    replace(search, replace) {
        this._str := Strung.replace(this._str, search, replace)
        return this
    }
    ; replaceAll()
    static replaceAll(str, search, replace) {
        outputVarCount := unset
        return RegExReplace(str, search, replace)
    }

    replaceAll(search, replace) {
        this._str := Strung.replaceAll(this._str, search, replace)
        return this
    }

    ; search()
    static search(str, regex) {
        return RegExMatch(str, regex)
    }

    search(regex) {
        return Strung.search(this._str, regex)
    }

    ; slice()
    static slice(str, start, end := StrLen(str)) {
        return SubStr(str, start, end - start + 1)
    }

    slice(start, end := StrLen(this._str)) {
        this._str := Strung.slice(this._str, start, end)
        return this
    }

    ; split()
    static split(str, separator, limit := 0, mode := "string") {
        arr := []
        index := 1
        while (index <= StrLen(str) && limit < index) {
            if (separator == "") {
                arr.Push(Strung.at(str, 1))
                str := Strung.slice(str, 2)
                continue
            }

            if (mode == "regex") {
                matchInfo := unset
                separatorIndex := RegExMatch(str, separator, &matchInfo)
                if (separatorIndex == 0) {
                    arr.Push(Strung.slice(str, index))
                    break
                }
                arr.push(Strung.slice(str, 1, separatorIndex - 1))
                str := Strung.slice(str, separatorIndex + matchInfo.Len)
                continue
            }

            separatorIndex := InStr(str, separator, true)
            if (separatorIndex == 0) {
                arr.Push(Strung.slice(str, index))
                break
            }
            arr.push(Strung.slice(str, index, separatorIndex - 1))
            str := Strung.slice(str, separatorIndex + StrLen(separator))
        }

        return arr
    }

    split(separator, limit := 0) {
        return Strung.split(this._str, separator, limit)
    }

    ; startsWith()
    static startsWith(str, prefix) {
        return SubStr(str, 1, StrLen(prefix)) == prefix
    }

    startsWith(prefix) {
        return Strung.startsWith(this._str, prefix)
    }

    ; toUpperCase()
    static toUpperCase(str) {
        return StrUpper(str)
    }

    toUpperCase() {
        this._str := Strung.toUpperCase(this._str)
        return this
    }

    ; toLowerCase()
    static toLowerCase(str) {
        return StrLower(str)
    }

    toLowerCase() {
        this._str := Strung.toLowerCase(this._str)
        return this
    }

    ; trim()
    static trim(str) {
        return Strung.trimStart(Strung.trimEnd(str))
    }

    trim() {
        this._str := Strung.trim(this._str)
        return this
    }

    ; trimEnd()
    static trimEnd(str) {
        endIndex := StrLen(str)
        while endIndex > 1 {
            currChar := Strung.at(str, endIndex)
            if (currChar != " " && currChar != "`t") {
                break
            }
            endIndex--
        }

        return Strung.slice(str, 1, endIndex)
    }

    trimEnd() {
        this._str := Strung.trimEnd(this._str)
        return this
    }

    ; trimStart()
    static trimStart(str) {
        startIndex := 1
        Loop Parse, str {
            if (A_LoopField != " " && A_LoopField != "`t") {
                break
            }
            startIndex++
        }
        
        return Strung.slice(str, startIndex, StrLen(str))
    }

    trimStart() {
        this._str := Strung.trimStart(this._str)
        return this
    }
    
    ; capitalize()
    static capitalize(str) {
        return StrUpper(Strung.at(str, 1)) . Strung.slice(str, 2, StrLen(str))
    }

    capitalize() {
        this._str := Strung.capitalize(this._str)
        return this
    }

    ; decapitalize()
    static decapitalize(str) {
        return StrLower(Strung.at(str, 1)) . Strung.slice(str, 2, StrLen(str))
    }

    decapitalize() {
        this._str := Strung.decapitalize(this._str)
        return this
    }

    ; chop()
    static chop(str, length) {
        chopped := []
        while StrLen(str) > 0 {
            chopped.push(Strung.slice(str, 1, length))
            str := Strung.slice(str, length + 1, StrLen(str))
        }
        return chopped
    }

    chop(length) {
        return Strung.chop(this._str, length)
    }

    ; consolidateSpaces()
    static consolidateSpaces(str) {
        return Strung.trim(Strung.replaceAll(str, "\s+", " "))
    }

    consolidateSpaces() {
        this._str := Strung.consolidateSpaces(this._str)
        return this
    }
    
    ; toArray()
    static toArray(str) {
        return Strung.split(str, "")
    }
    
    toArray() {
        return Strung.toArray(this._str)
    }

    ; chars()
    static chars(str) {
        return Strung.toArray(str)
    }

    chars() {
        return Strung.toArray(this._str)
    }
    ; swapCase()
    static swapCase(str) {
        newStr := ""
        Loop Parse, str {
            if (IsLower(A_LoopField)) {
                newStr := newStr . StrUpper(A_LoopField)
            } else if (IsUpper(A_LoopField)) {
                newStr := newStr . StrLower(A_LoopField)
            } else {
                newStr := newStr . A_LoopField
            }
        }
        return newStr
    }

    swapCase() {
        this._str := Strung.swapCase(this._str)
        return this
    }

    ; count()
    static count(str, search) {
        return Strung.split(str, search).length - 1
    }

    count(search) {
        return Strung.count(this._str, search)
    }

    ; length()
    static length(str) {
        return StrLen(str)
    }

    length() {
        return Strung.length(this._str)
    }
    
    ; insert()
    static insert(str, index, insert) {
        return Strung.slice(str, 1, index - 1) . insert . Strung.slice(str, index, StrLen(str))
    }

    insert(index, insert) {
        this._str := Strung.insert(this._str, index, insert)
        return this
    }

    ; isBlank()
    static isBlank(str) {
        return Strung.trim(str) == ""
    }

    isBlank() {
        return Strung.isBlank(this._str)
    }

    ; join()
    static join(separator, strs*) {
        if (strs.Length == 1 && strs[1] is Array) {
            strs := strs[1]
        }

        newStr := ""
        for i, str in strs {
            if (i > 1) {
                newStr := newStr . separator
            }
            newStr := newStr . str
        }
        return newStr
    }

    ; linesToArray()
    static linesToArray(str) {
        return Strung.split(str, "(\r\n|\r|\n)", unset, "regex")
    }

    linesToArray() {
        return Strung.linesToArray(this._str)
    }

    ; lineCount()
    static lineCount(str) {
        return Strung.linesToArray(str).length
    }

    lineCount() {
        return Strung.lineCount(this._str)
    }
    
    ; reverse()
    static reverse(str) {
        newStr := ""
        Loop Parse, str {
            newStr := A_LoopField . newStr
        }
        return newStr
    }

    reverse() {
        this._str := Strung.reverse(this._str)
        return this
    }

    ; titleCase()
    static titleCase(str) {
        newStr := ""
        Loop Parse, str {
            if (A_Index == 1 || Strung.at(str, A_Index - 1) == " ") {
                newStr := newStr . StrUpper(A_LoopField)
            } else {
                newStr := newStr . A_LoopField
            }
        }
        return newStr
    }

    titleCase() {
        this._str := Strung.titleCase(this._str)
        return this
    }

    ; truncate()
    static truncate(str, length, truncateStr := "") {
        if (StrLen(str) > length) {
            return Strung.slice(str, 1, length - StrLen(truncateStr)) . truncateStr
        }
        return str
    }

    truncate(length, truncateStr := "") {
        this._str := Strung.truncate(this._str, length, truncateStr)
        return this
    }

    ; wordsToArray()
    static wordsToArray(str) {
        return Strung.split(str, "\s+", unset, "regex")
    }

    wordsToArray() {
        return Strung.wordsToArray(this._str)
    }

    ; wordCount()
    static wordCount(str) {
        return Strung.wordsToArray(str).length
    }

    wordCount() {
        return Strung.wordCount(this._str)
    }
    ; surround()
    static surround(str, surround) {
        return surround . str . surround
    }

    surround(surround) {
        this._str := Strung.surround(this._str, surround)
        return this
    }

    ; quote()
    static quote(str, q := '"') {
        return Strung.surround(str, q)
    }

    quote(q := '"') {
        this._str := Strung.quote(this._str, q)
        return this
    }

    ; unquote()
    static unquote(str, q := '"') {
        if (Strung.startsWith(str, q) && Strung.endsWith(str, q)) {
            return Strung.slice(str, 2, StrLen(str) - 1)
        }
        return str
    }

    unquote(q := '"') {
        this._str := Strung.unquote(this._str, q)
        return this
    }

    ; toBoolean()
    static toBoolean(str) {
        if (StrCompare(str, "true", 0) == 0) {
            return true
        }

        if (StrCompare(str, "false", 0) == 0) {
            return false
        }

        if (StrCompare(str, "yes", 0) == 0) {
            return true
        }

        if (StrCompare(str, "no", 0) == 0) {
            return false
        }

        if (StrCompare(str, "on", 0) == 0) {
            return true
        }

        if (StrCompare(str, "off", 0) == 0) {
            return false
        }

        if (StrCompare(str, "1", 0) == 0) {
            return true
        }

        if (StrCompare(str, "0", 0) == 0) {
            return false
        }

        return ""
    }

    toBoolean() {
        return Strung.toBoolean(this._str)
    }

    ; map()
    static map(str, mapper) {
        newStr := ""
        Loop Parse, str {
                newStr := newStr . mapper(A_LoopField)
        }
        return newStr
    }

    map(mapper) {
        this._str := Strung.map(this._str, mapper)
        return this
    }

    ; Methods to consider for the future:
    ; match()
    ; test() 
    ; toNumber() 
    ; stripTags() / stripHTML()
    ; toSentence()
    ; matchAll()
    ; numberFormat()
    ; levenshtein()
    ; escapeHTML() 
    ; unescapeHTML() 
    ; wrap()
    ; dedent()
    ; splice()
    ; camelCase()
    ; pascalCase()
    ; snakeCase()
    ; kebabCase()
    ; humanize()
    ; prune()
}