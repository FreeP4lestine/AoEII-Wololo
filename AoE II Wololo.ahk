#Requires AutoHotkey v1.1.36
#SingleInstance, Force

FileCreateDir, AoE II Wololo
SetWorkingDir, AoE II Wololo

FileInstall, AoE II Wololo\7za.exe, %A_ScriptDir%\7za.exe

#Include, AoE II Wololo\Language.ahk

FileRead, Language, Language.txt
Language := Language = "" ? "English" : Language

Gui, T:Add, Text, w300 Center vText, % "`n`n"
If !FileExist("Patches") {
    If !ConnectedToInternet() && !FileExist("DPackages\Patches.7z.001") {
        MsgBox, 48, % LngList[Language][45], % LngList[Language][46]
        ExitApp
    }

    GuiControl, T:, Text, % LngList[Language][38] "...`n`n" LngList[Language][41] "..."
    Gui, T:Show,, % LngList[Language][41] "..."
    UrlDownloadToFile, https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/Patches/Version.txt, Version.txt
    PartsCount := 0
    FileReadLine, PartsCount, Version.txt, 2
    FileCreateDir, DPackages
    Loop, % PartsCount {
        Index := A_Index < 10 ? "00" A_Index : "0" A_Index
        If !FileExist("DPackages\Patches.7z." Index)
            UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/Patches/Patches.7z." Index, % "DPackages\Patches.7z." Index
    }
    GuiControl, T:, Text, % LngList[Language][39] "...`n`n" LngList[Language][41] "..."
    RunWait, 7za x "DPackages\Patches.7z.001" -o"Patches" -aos,, Hide
}

If !FileExist("Icons") && ConnectedToInternet() {
    GuiControl, T:, Text, % LngList[Language][38] "...`n`n" LngList[Language][41] "..."
    Gui, T:Show,, % LngList[Language][41] "..."
    UrlDownloadToFile, https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/Icons/Version.txt, Version.txt
    PartsCount := 0
    FileReadLine, PartsCount, Version.txt, 2
    FileCreateDir, DPackages
    Loop, % PartsCount {
        Index := A_Index < 10 ? "00" A_Index : "0" A_Index
        If !FileExist("DPackages\Icons.7z." Index)
            UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/Icons/Icons.7z." Index, % "DPackages\Icons.7z." Index
    }
    GuiControl, T:, Text, % LngList[Language][39] "...`n`n" LngList[Language][41] "..."
    RunWait, 7za x "DPackages\Icons.7z.001" -o"Icons" -aos,, Hide
}

If !FileExist("Mp3") && ConnectedToInternet() {
    GuiControl, T:, Text, % LngList[Language][38] "...`n`n" LngList[Language][41] "..."
    Gui, T:Show,, % LngList[Language][41] "..."
    UrlDownloadToFile, https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/Mp3/Version.txt, Version.txt
    PartsCount := 0
    FileReadLine, PartsCount, Version.txt, 2
    FileCreateDir, DPackages
    Loop, % PartsCount {
        Index := A_Index < 10 ? "00" A_Index : "0" A_Index
        If !FileExist("DPackages\Mp3.7z." Index)
            UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/Mp3/Mp3.7z." Index, % "DPackages\Mp3.7z." Index
    }
    GuiControl, T:, Text, % LngList[Language][39] "...`n`n" LngList[Language][41] "..."
    RunWait, 7za x "DPackages\Mp3.7z.001" -o"Mp3" -aos,, Hide
}

Gui, T:Hide
Gui, +HwndWololo
Gui, Color, White
Gui, Add, GroupBox, w300 r15 cBlue, % LngList[Language][1]
Gui, Font, Bold
Gui, Add, Text, xp+10 yp+20 w280 cGreen, % "1 - " LngList[Language][2]
Gui, Font, Norm
Gui, Add, Edit, wp vInstallDir ReadOnly
Gui, Add, Button, gChoose HwndBtn w70, % LngList[Language][3]
SetButtonIcon(Btn, "Icons\Folder.ico")

Gui, Add, Button, xp+160 yp w120 gChooseGR HwndBtn, % LngList[Language][4]
SetButtonIcon(Btn, "Icons\GR.ico")

Gui, Add, Button, xp yp+30 w120 gSetChooseGR HwndBtn, % LngList[Language][47]
SetButtonIcon(Btn, "Icons\GR.ico")

Gui, Add, Button, xp-160 yp+30 gOpenInExplorer w280 HwndBtn, % LngList[Language][43]
SetButtonIcon(Btn, "Icons\Folder.ico")

Gui, Font, Bold
Gui, Add, Text, xp ym+170 w280 cGreen, % "2 - " LngList[Language][9]
Gui, Font, Norm
Gui, Add, Button, gDownload w140 HwndBtn, % LngList[Language][10]
SetButtonIcon(Btn, "Icons\Down.ico")

Gui, Add, Progress, xp yp w280 vDP -Smooth Hidden Range1-9
Gui, Add, Text, wp vDPT Center Hidden, ...

Gui, Add, GroupBox, ym w300 r15 cBlue, % LngList[Language][18]
Gui, Font, Bold
Gui, Add, Text, xp+10 yp+20 w280 cGreen, % "1 - " LngList[Language][19]
Gui, Font, Norm
Gui, Add, Pic, xp+220 yp+20 gOpenAok, Icons\empires2.ico
Gui, Font, s10, Consolas
Gui, Add, Text, xp yp+50 wp Center cRed vAokVerT, ...
Gui, Add, Radio, xp-200 yp-50 vAokVer gApplyPatchAok, 2.0  CD
Gui, Add, Radio, gApplyPatchAok, 2.0a No CD
Gui, Add, Radio, gApplyPatchAok, 2.0b CD
Gui, Font
Aok := ["2.0", "2.0a", "2.0b"]
Gui, Add, CheckBox, xp-20 yp+30 vAddFixAok gAddFixAok w280, % LngList[Language][24]

Gui, Font, Bold s8
Gui, Add, Text, xp ym+140 w280 cGreen, % "2 - " LngList[Language][20]
Gui, Font, Norm
Gui, Add, Pic, xp+220 yp+20 gOpenAoc, Icons\age_x1.ico
Gui, Font, s10, Consolas
Gui, Add, Text, xp yp+50 wp Center cBlue vAocVerT, ...
Gui, Add, Radio, xp-200 yp-50 vAocVer gApplyPatchAoc, 1.0  CD
Gui, Add, Radio, gApplyPatchAoc, 1.0c No CD
Gui, Add, Radio, gApplyPatchAoc, 1.0e No CD
Gui, Add, Radio, gApplyPatchAoc, 1.1  No CD
Gui, Add, Radio, gApplyPatchAoc, 1.5  CD
Gui, Font
Aoc := ["1.0", "1.0c", "1.0e", "1.1", "1.5"]
Gui, Add, CheckBox, xp-20 yp+30 vAddFixAoc gAddFixAoc w280, % LngList[Language][24]

FileRead, StartCheck, UpdateCheck.txt
If ConnectedToInternet() && (StartCheck) {
    GuiControl, T:, Text, % LngList[Language][34] "...`n`n" LngList[Language][41] "..."
    Gui, T:Show,, % LngList[Language][41] "..."
    UrlDownloadToFile, https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/VMods/Version.txt, Version.txt
    Version := CVersion:= ""
    FileReadLine, Version, Version.txt, 1
    FileReadLine, CVersion, VMods\Version.txt, 1
    If (CVersion = "") || (Version < CVersion) {
        MsgBox, 68, % LngList[Language][35], % LngList[Language][26] " ==> " Version "`n`n" LngList[Language][36] "?"
        IfMsgBox, Yes
        {
            PartsCount := 0
            FileReadLine, PartsCount, Version.txt, 2
            FileCreateDir, DPackages
            Loop, % PartsCount {
                Index := A_Index < 10 ? "00" A_Index : "0" A_Index
                GuiControl, T:, Text, % LngList[Language][13] " " A_LoopField " v" Version "...`n( " A_Index " / " PartsCount " )`n" LngList[Language][41] "..."
                If !FileExist("DPackages\VMods.7z." Index)
                    UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/VMods/VMods.7z." Index, % "DPackages\VMods.7z." Index
            }
            GuiControl, T:, Text, % LngList[Language][39] "...`n`n" LngList[Language][41] "..."
            RunWait, 7za x "DPackages\VMods.7z.001" -o"VMods" -aoa,, Hide
            FileMove, Version.txt, VMods\Version.txt, 1
        }
    }
}

VMods           := {}
GotDMod         := 0
InitiateList    := 1

DRS := { "gra" : "graphics.drs"
      ,  "int" : "interfac.drs"
      ,  "ter" : "terrain.drs"  }

FileRead, InstallDir, Gamedirectory.txt
Loop, Files, VMods\*, D
{
    If (A_Index = 1) {
        Gui, Add, GroupBox, ym w300 r15 cBlue, % LngList[Language][26]
        Gui, Add, ListView, Checked xp+10 yp+20 w280 r13 gUpdateVmod vVmodList AltSubmit -Multi, % LngList[Language][27]
        GotDMod := 1
        FileInstall, AoE II Wololo\DrsBuild.exe, DrsBuild.exe
    }
    ModName := A_LoopFileName
    VMods[A_Index] := ModName
    IniRead, Installed, %InstallDir%\Config.ini, VMods, % ModName
    LV_Add((Installed = 1) ? "Check" : "", ModName)
}

If (GotDMod) {
    Gui, Font, Bold s8
    Gui, Add, Text, xp ym+280 vVmodT Center cBlue wp, ...
    Gui, Font, Norm
}

If ConnectedToInternet() && (StartCheck) {
    GuiControl, T:, Text, % LngList[Language][34] "...`n`n" LngList[Language][41] "..."
    Gui, T:Show,, % LngList[Language][41] "..."
    UrlDownloadToFile, https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/DMods/DMods.txt, DMods.txt
    FileRead, DMods, DMods.txt
    Loop, Parse, DMods, `n, `r
    {
        ModNameAsLink := StrReplace(A_LoopField, " ", "%20")
        UrlDownloadToFile, % "https://raw.githubusercontent.com/FreeP4lestine/AoEII-Wololo/main/DMods/" ModNameAsLink "/Version.txt", Version.txt
        Version := CVersion:= ""
        FileReadLine, Version, Version.txt, 1
        FileReadLine, CVersion, DMods\%A_LoopField%\Version.txt, 1
        If (CVersion = "") || (Version < CVersion) {
            MsgBox, 68, % LngList[Language][35], % A_LoopField " ==> " Version "`n" LngList[Language][36] "?"
            IfMsgBox, Yes
            {
                Gui, T:Show
                FileCreateDir, DPackages
                PartsCount := 0
                FileReadLine, PartsCount, Version.txt, 2
                Loop, % PartsCount {
                    Index := A_Index < 10 ? "00" A_Index : "0" A_Index
                    GuiControl, T:, Text, % LngList[Language][13] " " A_LoopField " v" Version "...`n( " A_Index " / " PartsCount " )`n" LngList[Language][41] "..."
                    If !FileExist("DPackages\" A_LoopField ".7z." Index) || 
                        UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/DMods/" ModNameAsLink "/" ModNameAsLink ".7z." Index, % "DPackages\" A_LoopField ".7z." Index
                }
                FileCreateDir, DMods\%A_LoopField%
                FileMove, % "DPackages\" A_LoopField ".*", DMods\%A_LoopField%\
                FileMove, Version.txt, DMods\%A_LoopField%\Version.txt, 1
            }
        }
    }
}

Gui, T:Hide

GotDMod := 0
DMods   := {}
IniRead, Installed, %InstallDir%\Config.ini, DMods, Installed
Loop, Files, DMods\*, D
{
    ModName := A_LoopFileName
    Pos := ""
    If FileExist("DMods\" ModName "\Version.txt") {
        If (A_Index = 1) {
            Gui, Add, GroupBox, ym w300 r15 cBlue, % LngList[Language][28]
            GotDMod := 1
            Pos := "vSelDmod"
            Gui, Font, Bold s8
            Gui, Add, Text, xp+10 yp+20 w280 cGreen, % "1 - " LngList[Language][50]
            Gui, Font, Norm
        }
        DMods[A_Index] := ModName
        Version := ""
        FileReadLine, Version, DMods\%ModName%\Version.txt, 1
        Gui, Add, Radio, % (Pos) (Installed = ModName ? " Checked" : "") " gUpdateDmod", % ModName " (" (Version ? Version : "-") ")"
    }
}
If (GotDMod) {
    Gui, Font, Bold s8
    Gui, Add, Text, xp ym+220 w280 cGreen, % "2 - " LngList[Language][49]
    Gui, Font, Norm
    Gui, Add, DDL, vModLng w140 gApplyModLng
    Gui, Font, Bold s8
    Gui, Add, Text, xp ym+280 vDmodPBT Center w280 cBlue, ...
    Gui, Font, Norm
}

Gui, Add, DDL, xp+140 ym+310 w140 vLanguage gApplyLng
For Lng in LngList {
    GuiControl, , Language, % Lng ((Lng = Language) ? "||" : "")
}

Gui, Add, CheckBox, % "xm ym+310 vStartCheck gUpdateUpdateCheck" (StartCheck = 1 ? " Checked" : ""), % LngList[Language][44]
Gui, Add, Button, % "gRestart wp", % LngList[Language][51]

Gui, Add, StatusBar
SB_SetParts(12)
SB_SetText("AoE II Wololo 1.0", 2)
Gui, Show,, AoE II Wololo
InstalledPatchs(InstallDir)
SoundPlay, Mp3\Wololo.wav
Sleep, 1000
InitiateList := 0
Return

TGUIClose:
GUIClose:
ExitApp

Restart:
    FileRemoveDir, ..\AoE II Wololo, 1
    FileDelete, ..\7za.exe
    Reload
Return

ApplyModLng:
    Gui, Submit, NoHide
    If !FileExist(InstallDir)
        Return
    FileCopy, %InstallDir%\Games\%Dmod%\*_%ModLng%.ini, %InstallDir%\Games\%Dmod%\Language.ini, 1
Return

UpdateUpdateCheck:
    Gui, Submit, NoHide
    FileOpen("UpdateCheck.txt", "w").Write(StartCheck).Close()
Return

ApplyLng:
    Gui, Submit, NoHide
    FileOpen("Language.txt", "w").Write(Language).Close()
Reload
Return

OpenInExplorer:
    Gui, Submit, NoHide
    If FileExist(InstallDir) {
        Run, % InstallDir
    }
Return

DmodCheckSize:
    KBSize := FolderGetSize(InstallDir "\Games\" Dmod)
    GuiControl,, DmodPBT, % LngList[Language][14] " " Round(KBSize / 1000, 2) " MB..."
Return

UpdateDmod:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    For Each, Mod in Dmods {
        GuiControl, Disabled, % Mod
    }
    If !InStr(FileExist(InstallDir), "D")
        Return
    Dmod := Dmods[SelDmod]
    IniRead, parts, Dmods\%Dmod%\Config.ini, Config, parts
    Loop, % parts {
        Index := A_Index < 10 ? "00" A_Index : "0" A_Index
        If !FileExist("Dmods\" Dmod "\" Dmod ".7z." Index) {
            UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/blob/main/DMods/" StrReplace(Dmod, " ", "%20") "/" StrReplace(Dmod, " ", "%20") ".7z." Index, % "Dmods\" Dmod "\" Dmod ".7z." Index
        }
        FileGetSize, S, % "Dmods\" Dmod "\" Dmod ".7z." Index, M
        GuiControl,, DmodPBT, % A_Index " / " parts " - " LngList[Language][31] "..."
    }

    If !FileExist(InstallDir "\Games\" Dmod ".xml") {
        SetTimer, DmodCheckSize, 1000
        RunWait, 7za x "Dmods\%Dmod%\%Dmod%.7z.001" -o"%InstallDir%\Games" -aos,, Hide
        SetTimer, DmodCheckSize, Off
    }
    GuiControl,, DmodPBT, % Dmod " " LngList[Language][30] "!"
    For Each, Mod in Dmods {
        GuiControl, Enabled, % Mod
    }
    GuiControl,, 1.5, 1
    Gui, Submit, NoHide
    PatchMsg := 0
    GoSub, ApplyPatchAoc
    PatchMsg := 1
    MsgBox, 64, % LngList[Language][32], % LngList[Language][20] " ---> " Dmod, 5

    age2_x1 := FileOpen(InstallDir "\age2_x1\age2_x1.exe", "rw")
    age2_x1.RawRead(BinData, Len := age2_x1.Length())
    Loop, 28 {
        Byte := NumGet(BinData, 2821667 + A_Index, "UChar")
        If (Char := SubStr(Dmod, A_Index, 1)) {
            NumPut(Asc(Char), BinData, 2821667 + A_Index, "UChar")
        } Else {
            NumPut(0, BinData, 2821667 + A_Index, "UChar")
        }
    }
    age2_x1.Position := 0
    age2_x1.RawWrite(BinData, Len)
    age2_x1.Close()
    IniWrite, % Dmod, %InstallDir%\Config.ini, DMods, Installed
    GuiControl,, ModLng, |
    Loop, Files, %InstallDir%\Games\%Dmod%\Language_*.ini
        GuiControl,, ModLng, % (SubStr(StrSplit(A_LoopFileName, "_")[2], 1, -4)) (A_Index = 1 ? "||" : "")
Return

UpdateVmod:
    If !InStr(FileExist(InstallDir), "D")
        Return
    If (A_GuiEvent == "I") {
        If !(Install := (ErrorLevel == "C") ? 1 : ((ErrorLevel == "c") ? -1 : 0)) || (InitiateList)
            Return
        GuiControl, Disabled, VmodList
		ModID   := A_EventInfo
        Gui, Submit, NoHide
        LV_GetText(Name, ModID, 1)
        GuiControl,, VmodT, % Name " " LngList[Language][29] "..."
        Switch Install {
            Case 1:
                Prefixs := {}
                Loop, Files, Vmods\%Name%\*.slp
                    Prefixs[SubStr(A_LoopFileName, 1, 3)] := ""
                For Prefix in Prefixs
                    RunWait, % "DrsBuild.exe /r """ InstallDir "\Data\" DRS[Prefix] """ ""Vmods\" Name "\" Prefix "*.slp""",, Hide
                IniWrite, 1, %InstallDir%\Config.ini, VMods, % Name
                SoundPlay, Mp3\Wololo.wav
            Case -1:
                Prefixs := {}
                Loop, Files, Vmods\%Name%\U\*.slp
                    Prefixs[SubStr(A_LoopFileName, 1, 3)] := ""
                For Prefix in Prefixs
                    RunWait, % "DrsBuild.exe /r """ InstallDir "\Data\" DRS[Prefix] """ ""Vmods\" Name "\U\" Prefix "*.slp""",, Hide
                IniWrite, 0, %InstallDir%\Config.ini, VMods, % Name
        }
        GuiControl,, VmodT, % Name " " LngList[Language][30]
        GuiControl, Enabled, VmodList
    }
Return

OpenAoc:
    If FileExist(InstallDir "\age2_x1\age2_x1.exe")
        Run, % InstallDir "\age2_x1\age2_x1.exe", % InstallDir "\age2_x1"
Return

OpenAok:
    If FileExist(InstallDir "\empires2.exe")
        Run, % InstallDir "\empires2.exe", % InstallDir
Return

AddFixAoc:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    If (AddFixAoc) {
        If (AocVer > 2) {
            MsgBox, 48, % LngList[Language][11], % LngList[Language][25] " " Aoc[AocVer]
            Return
        }
        CopyPatch(InstallDir, "aoeii20c")
        CopyPatch(InstallDir, "aoc20c")
        SoundPlay, Mp3\Wololo.wav
    } Else {
        CleanUp("aoeii20c")
        CleanUp("aoc20c")
    }
Return

AddFixAok:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    If (AddFixAok) {
        CopyPatch(InstallDir, "aoeii20c")
        SoundPlay, Mp3\Wololo.wav
    } Else {
        CleanUp("aoeii20c")
    }
Return

ApplyPatchAok:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    GuiControl,, AokVerT, ...
    CleanUp("aoeii")
    If (AokVer = 3)
        CopyPatch(InstallDir, "aoeii" StrReplace(Aok[2], "."))
    CopyPatch(InstallDir, "aoeii" StrReplace(Aok[AokVer], "."))
    GuiControl,, AokVerT, % Aok[AokVer]
    InstalledPatchs(InstallDir)
    SoundPlay, Mp3\Wololo.wav
    MsgBox, 64, % LngList[Language][19], % LngList[Language][19] " ---> " Aok[AokVer], 5
Return

ApplyPatchAoc:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    GuiControl,, AocVerT, ...
    CleanUp("aoc")
    If (AocVer > 2)
        CopyPatch(InstallDir, "aoc" StrReplace(Aoc[2], "."))
    CopyPatch(InstallDir, "aoc" StrReplace(Aoc[AocVer], "."))
    GuiControl,, AocVerT, % Aoc[AocVer]
    InstalledPatchs(InstallDir)
    SoundPlay, Mp3\Wololo.wav
    If (PatchMsg)
        MsgBox, 64, % LngList[Language][20], % LngList[Language][20] " ---> " Aoc[AocVer], 5
Return

Download:
    GuiControl, Hide, % LngList[Language][10]
    GuiControl, Show, DP
    GuiControl, Show, DPT
    Loop, 9 {
        GuiControl,, DPT, % LngList[Language][13] " ( " A_Index " / 9 )..."
        Index := A_Index < 10 ? "00" A_Index : "0" A_Index
        If !FileExist("DPackages\DATA.7z." Index)
            UrlDownloadToFile, % "https://github.com/FreeP4lestine/AoEII-Wololo/raw/main/GData/DATA.7z." Index, % "DPackages\DATA.7z." Index
        GuiControl,, DP, +1
    }
    MsgBox, 36, % LngList[Language][7], % LngList[Language][21]
    IfMsgBox, Yes
        ExtractTo := SelectFolderEx()
    ExtractTo := ExtractTo ? ExtractTo : A_ProgramFiles "\Age of Empires II"
    GuiControl,, DP, 0
    GuiControl, +Range1-382, DP
    GuiControl,, DPT, % LngList[Language][16] "..."

    If InStr(FileExist(ExtractTo "\Age of Empires II"), "D") {
        MsgBox, 36, % LngList[Language][7], % ExtractTo "\Age of Empires II`n" LngList[Language][22] "`n`n" LngList[Language][23]
        IfMsgBox, Yes
            Switch := "-aoa"
        Else
            Switch := "-aos"
    }
    
    SetTimer, CheckSize, 1000
    RunWait, 7za x DPackages\DATA.7z.001 -o"%ExtractTo%\Age of Empires II\" %Switch%,, Hide
    SetTimer, CheckSize, Off
    GuiControl,, DP, 382
    GuiControl,, DPT, % LngList[Language][15] " ( 382 MB )"
    MsgBox, 64, % LngList[Language][7], % LngList[Language][15] "`n-->" ExtractTo "\Age of Empires II\"
    MsgBox, 36, % LngList[Language][7], % LngList[Language][17]
    IfMsgBox, Yes
    {
        GuiControl,, InstallDir, % ExtractTo "\Age of Empires II"
        InstalledPatchs(ExtractTo "\Age of Empires II")
        FileOpen("Gamedirectory.txt", "w").Write(ExtractTo "\Age of Empires II").Close()
    }
    GuiControl, Show, % LngList[Language][10]
    GuiControl,, DP, 0
    GuiControl, Hide, DP
    GuiControl, Hide, DPT
Return

CheckSize:
    KBSize := FolderGetSize(ExtractTo "\Age of Empires II")
    GuiControl,, DPT, % LngList[Language][14] " ( " (MBSize := Round(KBSize / 1000, 2)) " MB / 382 MB)..."
    GuiControl,, DP, % MBSize
Return

Choose:
    If (Selected := SelectFolderEx()) {
        If FileExist(Selected "\empires2.exe") {
            GuiControl,, InstallDir, % Selected
            FileOpen("Gamedirectory.txt", "w").Write(Selected).Close()
            InstalledPatchs(Selected)
        } Else {
            Msgbox, 52, % LngList[Language][11], % LngList[Language][12]
            IfMsgBox, Yes
                GoSub, Choose
        }
    }
Return

SetChooseGR:
    Gui, Submit, NoHide
    If !InStr(FileExist(InstallDir), "D")
        Return
    Process, Exist, GameRanger.exe
    If (ErrorLevel) {
        WinActivate, ahk_exe GameRanger.exe
        WinWaitActive, ahk_exe GameRanger.exe
        SendInput, ^e
        WinWaitActive, Options ahk_exe GameRanger.exe
        Control, TabLeft, 6, SysTabControl321, Options ahk_exe GameRanger.exe
        ControlSend, SysListView321, {Home}, Options ahk_exe GameRanger.exe
        Loop, 12
	        ControlSend, SysListView321, {Down}, Options ahk_exe GameRanger.exe
        ControlClick, Button2, Options ahk_exe GameRanger.exe
        WinWaitActive, Choose ahk_exe GameRanger.exe
        ControlSetText, Edit1, % InstallDir "\empires2.exe", Choose ahk_exe GameRanger.exe
        Sleep, 250
        SendInput, {Enter}
        WinWaitActive, Options ahk_exe GameRanger.exe
        Loop, 2
	        ControlSend, SysListView321, {Down}, Options ahk_exe GameRanger.exe
        ControlClick, Button2, Options ahk_exe GameRanger.exe
        WinWaitActive, Choose ahk_exe GameRanger.exe
        ControlSetText, Edit1, % InstallDir "\age2_x1\age2_x1.exe", Choose ahk_exe GameRanger.exe
        Sleep, 250
        SendInput, {Enter}
        WinWaitActive, Options ahk_exe GameRanger.exe
        WinClose, Options ahk_exe GameRanger.exe
        WinActivate, ahk_id %Wololo%
        Msgbox, 64, % LngList[Language][7], % LngList[Language][8], 5
    }
Return

ChooseGR:
    Process, Exist, GameRanger.exe
    If (ErrorLevel) {
        WinActivate, ahk_exe GameRanger.exe
        WinWaitActive, ahk_exe GameRanger.exe
        SendInput, ^e
        WinWaitActive, Options
        Control, TabLeft, 6, SysTabControl321, Options ahk_exe GameRanger.exe
        ControlSend, SysListView321, {Home}, Options ahk_exe GameRanger.exe
        Loop, 12
	        ControlSend, SysListView321, {Down}, Options ahk_exe GameRanger.exe
        SelectedGameExe := "", CheckAoC := 0
        ControlGetText, SelectedGameExe, Edit1, Options ahk_exe GameRanger.exe
        If !FileExist(SelectedGameExe) || (SelectedGameExe = "Not Found") {
            Loop, 2
	            ControlSend, SysListView321, {Down}, Options ahk_exe GameRanger.exe
            SelectedGameExe := ""
            ControlGetText, SelectedGameExe, Edit1, Options ahk_exe GameRanger.exe
            If !FileExist(SelectedGameExe) || (SelectedGameExe = "Not Found") {
                Msgbox, 36, % LngList[Language][5], % LngList[Language][6]
                IfMsgBox, Yes
                    GoSub, Choose
                Return
            }
            CheckAoC := 1
        }
        SplitPath, % SelectedGameExe, GameExe, GameDir
        If (CheckAoC) {
            SplitPath, % GameDir,, GameDir
        }
        WinClose, Options ahk_exe GameRanger.exe
        WinActivate, ahk_id %Wololo%
        GuiControl,, InstallDir, % GameDir
        InstalledPatchs(GameDir)
        FileOpen("Gamedirectory.txt", "w").Write(GameDir).Close()
        Msgbox, 64, % LngList[Language][7], % LngList[Language][8], 5
    }
Return

FolderGetSize(Dir) {
    S := 0
    Loop, Files, %Dir%\*.*, R
    {
        FileGetSize, TS, % A_LoopFileFullPath, K
        S += TS
    }
    Return, S
}

SelectFolderEx(StartingFolder := "", Prompt := "", OwnerHwnd := 0, OkBtnLabel := "") {
    Static OsVersion := DllCall("GetVersion", "UChar")
    , IID_IShellItem := 0
    , InitIID := VarSetCapacity(IID_IShellItem, 16, 0)
    & DllCall("Ole32.dll\IIDFromString", "WStr", "{43826d1e-e718-42ee-bc55-a1e261c37bfe}", "Ptr", &IID_IShellItem)
    , Show := A_PtrSize * 3
    , SetOptions := A_PtrSize * 9
    , SetFolder := A_PtrSize * 12
    , SetTitle := A_PtrSize * 17
    , SetOkButtonLabel := A_PtrSize * 18
    , GetResult := A_PtrSize * 20
    SelectedFolder := ""
    If (OsVersion < 6) { ; IFileDialog requires Win Vista+, so revert to FileSelectFolder
        FileSelectFolder, SelectedFolder, *%StartingFolder%, 3, %Prompt%
        Return SelectedFolder
    }
    OwnerHwnd := DllCall("IsWindow", "Ptr", OwnerHwnd, "UInt") ? OwnerHwnd : 0
    If !(FileDialog := ComObjCreate("{DC1C5A9C-E88A-4dde-A5A1-60F82A20AEF7}", "{42f85136-db7e-439c-85f1-e4075d135fc8}"))
        Return ""
    VTBL := NumGet(FileDialog + 0, "UPtr")
    ; FOS_CREATEPROMPT | FOS_NOCHANGEDIR | FOS_PICKFOLDERS
    DllCall(NumGet(VTBL + SetOptions, "UPtr"), "Ptr", FileDialog, "UInt", 0x00002028, "UInt")
    If (StartingFolder <> "")
        If !DllCall("Shell32.dll\SHCreateItemFromParsingName", "WStr", StartingFolder, "Ptr", 0, "Ptr", &IID_IShellItem, "PtrP", FolderItem)
        DllCall(NumGet(VTBL + SetFolder, "UPtr"), "Ptr", FileDialog, "Ptr", FolderItem, "UInt")
    If (Prompt <> "")
        DllCall(NumGet(VTBL + SetTitle, "UPtr"), "Ptr", FileDialog, "WStr", Prompt, "UInt")
    If (OkBtnLabel <> "")
        DllCall(NumGet(VTBL + SetOkButtonLabel, "UPtr"), "Ptr", FileDialog, "WStr", OkBtnLabel, "UInt")
    If !DllCall(NumGet(VTBL + Show, "UPtr"), "Ptr", FileDialog, "Ptr", OwnerHwnd, "UInt") {
        If !DllCall(NumGet(VTBL + GetResult, "UPtr"), "Ptr", FileDialog, "PtrP", ShellItem, "UInt") {
            GetDisplayName := NumGet(NumGet(ShellItem + 0, "UPtr"), A_PtrSize * 5, "UPtr")
            If !DllCall(GetDisplayName, "Ptr", ShellItem, "UInt", 0x80028000, "PtrP", StrPtr) ; SIGDN_DESKTOPABSOLUTEPARSING
                SelectedFolder := StrGet(StrPtr, "UTF-16"), DllCall("Ole32.dll\CoTaskMemFree", "Ptr", StrPtr)
            ObjRelease(ShellItem)
        }
    }
    If (FolderItem)
        ObjRelease(FolderItem)
    ObjRelease(FileDialog)
Return SelectedFolder
}

SetButtonIcon(hButton, File) {
    hIcon := LoadPicture(File,, _)
    SendMessage 0xF7, 1, % hIcon,, ahk_id %hButton% ; BM_SETIMAGE
}

CleanUp(Flag) {
    CloseProcess("empires2.exe")
    CloseProcess("age2_x1.exe")
    CloseProcess("clokspl.exe")
    GuiControlGet, InstallDir

    Loop, Files, Patches\%Flag%*.*
    {
        Patch := StrSplit(A_LoopFileName, ".")
        Switch Patch.MaxIndex() {
            Case 3:
                FileDelete, % InstallDir "\" Patch[2] "." Patch[3]
            Case 4:
                FileDelete, % InstallDir "\" Patch[2] "\" Patch[3] "." Patch[4]
        }
    }
}

CloseProcess(Name) {
    For RanProcess in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where name = '" Name "'")
        Process, Close, % RanProcess.ProcessId
}

CopyPatch(Dir, Ver) {
    Loop, Files, % "Patches\" Ver ".*"
    {
        Patch := StrSplit(A_LoopFileName, ".")
        Switch Patch.MaxIndex() {
            Case 3:
                FileCopy, % A_LoopFileFullPath, % Dir "\" Patch[2] "." Patch[3], 1
            Case 4:
                FileCopy, % A_LoopFileFullPath, % Dir "\" Patch[2] "\" Patch[3] "." Patch[4], 1
        }
    }
}

CheckPatchMods(Dir, Ver) {
    If FileExist(Dir "\icon.drs") {
        GuiControl,, AddFixAok, 1
    } Else {
        GuiControl,, AddFixAok, 0
    }

    If FileExist(Dir "\age2_x1\icon.drs") {
        GuiControl,, AddFixAoc, 1
    } Else {
        GuiControl,, AddFixAoc, 0
    }
}

InstalledPatchs(Dir) {
    GuiControl,, InstallDir, % Dir
    GuiControl,, AokVer, 0
    GuiControl,, 2.0a, 0
    GuiControl,, 2.0b, 0
    If InStr(FileExist(Dir), "D") && FileExist(Dir "\empires2.exe") {
        FileGetSize, AokSize, % Dir "\empires2.exe"
        Switch AokSize {
            Case "2560000": 
                GuiControl,, AokVer, 1
                GuiControl,, AokVerT, 2.0
                CheckPatchMods(Dir, 1)
            Case "2555949":
                GuiControl,, 2.0a, 1
                GuiControl,, AokVerT, 2.0a
                CheckPatchMods(Dir, 2)
            Case "2555904":
                GuiControl,, 2.0b, 1
                GuiControl,, AokVerT, 2.0b
                CheckPatchMods(Dir, 3)
        }
    }
    GuiControl,, AocVer, 0
    GuiControl,, 1.0c, 0
    GuiControl,, 1.0e, 0
    GuiControl,, 1.1, 0
    GuiControl,, 1.5, 0

    If InStr(FileExist(Dir), "D") && FileExist(Dir "\age2_x1\age2_x1.exe") {
        FileGetSize, AocSize, % Dir "\age2_x1\age2_x1.exe"
        Switch AocSize {
            Case "2695213": 
                GuiControl,, AocVer, 1
                GuiControl,, AocVerT, 1.0
                CheckPatchMods(Dir, 1)
            Case "2699309":
                If !FileExist(Dir "\age2_x1\on.ini") {
                    GuiControl,, 1.0c, 1
                    GuiControl,, AocVerT, 1.0c
                } Else {
                    GuiControl,, 1.0e, 1
                    GuiControl,, AocVerT, 1.0e
                }
                CheckPatchMods(Dir, 2)
            Case "2969600":
                GuiControl,, 1.1, 1
                GuiControl,, AocVerT, 1.1
                CheckPatchMods(Dir, 4)
            Case "3145728":
                GuiControl,, 1.5, 1
                GuiControl,, AocVerT, 1.5
                CheckPatchMods(Dir, 5)
        }
    }
}

ConnectedToInternet(flag := 0x40) {
    Return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag,"Int",0)
}