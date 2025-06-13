
#include-once
#include <Array.au3>
#include <Icons.au3>
#include <Bass.au3>
#include <TreeViewRCHM.au3>
#include <File.au3>
#include <Lang.au3>
#include <_GDIPlus_StripProgressbar.au3>
Opt('GUICloseOnESC', 0)
Opt('TrayMenuMode', 1)
Opt('MustDeclareVars', 1)

Global $oSNW[]
Global $oMod[]
Global $stoppr, $sNameMod[0], $flhide, $UpIdC = 0
Global $WOTP, $Title, $Mini, $Close, $tmphtv, $objw, $objc, $CurGui = 0, $volume = 100
Global $wkdir = @TempDir & '\wkdirjmp3', $pidwr, $curani = $wkdir & '\arrow.ani', $curc = $wkdir & '\arrow.cur', $force_a = $wkdir & '\force.ani', $force_c = $wkdir & '\force.cur'
Global $curtv, $tmpcurtv, $flpathgame, $flchpathgm
Global $flfunc = '', $flclmods, $flclresmods, $flbackup = 0, $infstinst, $flclmrm = 0, $flclcash = 0
Global $ALLTTF[0], $aALLAU, $aModsC, $flhide, $idpic, $idtxt = 0, $backlight = 0, $curidpos = 0
Global $nExistsTV = -1, $imgbackw = $wkdir & '\bck0.png', $aLoadTV[0][2], $nflagsetimgtv = 0
Global $setpathgame = '', $flagpath = 0, $playbck = $wkdir & '\bckau.mp3', $flinstset = 0, $clip = '', $setunmod = 0, $exmods[0], $endex = 0, $tmprcld = 0, $prcall = 0
Global $itmpFileName = '', $sNameG = '', $g_hCursor = 0, $g_hCursorLight = 0, $setcur = 0, $actcur = 0, $VerGameInst = ''
Global $FlashGui, $tmpiWRSZF, $iTMPProc, $iPrwrf, $tmpDest, $aWrex, $sBackupFiles
Global $nbackauset = 4, $nausetmod = 4, $MusicHandleBck, $MusicHandleMod, $Song_Length
Global $7zaPath = $wkdir & '\7za.exe'
Global $aIco[4] = [$wkdir & '\chk.ico', $wkdir & '\unchk.ico', $wkdir & '\rd.ico', $wkdir & '\unrd.ico']
Global $backlightcolor, $flpgtv, $flpg
Global $iPercData, $iPercId, $hHBmp_BG, $WPerc, $HPerc, $BgColorGui, $FgBGColor, $BGColor, $TextBGColor, $sFontProgress, $iVisPerc
Global $PathSFX = @ScriptFullPath
Global $Blitz_Packs = '', $GetPathExe = '', $sListModsF = '', $iCHLangPJ = 1, $sListExtParam = ''
Global $aFontInstRes, $FONT_PRIVATE = 0x10
$aFontInstRes = _FileListToArray($wkdir, '*.jmpf', 1, 1)
If Not @error Then
	For $i = 1 To $aFontInstRes[0]
		_WinAPI_AddFont($aFontInstRes[$i], $FONT_PRIVATE)
	Next
EndIf
TraySetIcon($PathSFX)
$nFlagSelect = 1
$UnchkUp = 1


_Getinilang()

Func _Getinilang()
	Local $getinilang
	If FileExists(@ScriptDir & '\lang.txt') Then
		$getinilang = IniReadSection(@ScriptDir & '\lang.txt', 'INSTALL')
		If Not @error Then
			If UBound($Instjmplang) = $getinilang[0][0] Then
				For $i = 1 To $getinilang[0][0]
					$Instjmplang[$i - 1] = $getinilang[$i][1]
				Next
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_Getinilang

Func _PageCreate(ByRef $mMap, $vKey)
	Local $mMap1[]
	Local $mMap2[]
	Local $aMap[2] = [$mMap1, $mMap2]
	_mCreateKey($mMap, $vKey, $aMap)
EndFunc   ;==>_PageCreate

Func _ANSIToOEM($strText)
	Local $sBUFFER = DllStructCreate("char[" & StringLen($strText) + 1 & "]")
	Local $aRet = DllCall("User32.dll", "int", "CharToOem", "str", $strText, "ptr", DllStructGetPtr($sBUFFER))
	If Not IsArray($aRet) Then Return SetError(1, 0, '')
	If $aRet[0] = 0 Then Return SetError(2, $aRet[0], '')
	Return DllStructGetData($sBUFFER, 1)
EndFunc   ;==>_ANSIToOEM

Func _OEM2ANSI($strText)
	Local $sBUFFER = DllStructCreate("char[" & StringLen($strText) + 1 & "]")
	Local $aRet = DllCall("User32.dll", "int", "OemToChar", "str", $strText, "ptr", DllStructGetPtr($sBUFFER))
	If Not IsArray($aRet) Then Return SetError(1, 0, '') ; DLL error
	If $aRet[0] = 0 Then Return SetError(2, $aRet[0], '') ; Function error
	Return DllStructGetData($sBUFFER, 1)
EndFunc   ;==>_OEM2ANSI

Func _CGW($NameExe, $GameCompany)
	Local $all_key[3]
	$all_key[0] = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
	$all_key[1] = "HKEY_LOCAL_MACHINE64\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
	$all_key[2] = 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall'
	Local $AppKey_all = '', $gtprname = '', $PathNameExe = '', $n_Count_Step
	For $i = 0 To 2
		$n_Count_Step = 1
		While 1
			$AppKey_all = RegEnumKey($all_key[$i], $n_Count_Step)
			If @error Then ExitLoop
			$PathNameExe = StringReplace(StringStripWS(RegRead($all_key[$i] & "\" & $AppKey_all, "InstallLocation"), 3), '"', '')
			If $PathNameExe <> '' Then
				If StringRight($PathNameExe, 1) = '\' Then $PathNameExe = StringTrimRight($PathNameExe, 1)
				If FileExists($PathNameExe & '\' & $NameExe) And FileExists($PathNameExe & '\Data') Then
					Switch $GameCompany
						Case 'Wargaming Blitz' ;'WarGaming.net'
							$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
							If $gtprname = 'WarGaming.net' Then
								$PathNameExe = StringStripWS($PathNameExe, 3)
								If FileExists($PathNameExe) Then Return $PathNameExe
							EndIf
						Case 'Lesta Blitz' ;'Lesta Games'
							$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
							If $gtprname = 'Lesta Games' Then
								$PathNameExe = StringStripWS($PathNameExe, 3)
								If FileExists($PathNameExe) Then Return $PathNameExe
							EndIf
					EndSwitch
				EndIf
			EndIf
			$n_Count_Step += 1
		WEnd
	Next
	Local $PathWG[3]
	$PathWG[0] = 'HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache'
	$PathWG[1] = 'HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache'
	$PathWG[2] = 'HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
	For $i = 0 To 2
		$n_Count_Step = 1
		While 1
			$AppKey_all = RegEnumVal($PathWG[$i], $n_Count_Step)
			If @error Then ExitLoop
			If StringStripWS($AppKey_all, 3) <> '' Then
				If StringInStr($AppKey_all, $NameExe) Then
					$PathNameExe = StringLeft($AppKey_all, StringInStr($AppKey_all, '\', 0, -1) - 1)
					If FileExists($PathNameExe & '\' & $NameExe) And FileExists($PathNameExe & '\Data') Then
						Switch $GameCompany
							Case 'Wargaming Blitz' ;'WarGaming.net'
								$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
								If $gtprname = 'WarGaming.net' Then
									$PathNameExe = StringStripWS($PathNameExe, 3)
									If FileExists($PathNameExe) Then Return $PathNameExe
								EndIf
							Case 'Lesta Blitz' ;'Lesta Games'
								$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
								If $gtprname = 'Lesta Games' Then
									$PathNameExe = StringStripWS($PathNameExe, 3)
									If FileExists($PathNameExe) Then Return $PathNameExe
								EndIf
						EndSwitch
					EndIf
				EndIf
			EndIf
			$n_Count_Step += 1
		WEnd
	Next
	Return ''
EndFunc   ;==>_CGW

Func _ChooseLang()
	Local $NMSG, $nIndexLang = 1
	Local $sIniLangInst = @TempDir & '\wkdirjmp3\IniLangInst.txt'
	Local $sBackImgInst = @TempDir & '\wkdirjmp3\backimginst.jpg'
	If Not FileExists($sIniLangInst) Then Return $nIndexLang
	Local $aReadTitle = IniReadSection($sIniLangInst, 'title')
	If @error Then Return $nIndexLang
	Local $aReadLang = IniReadSection($sIniLangInst, 'lang')
	If @error Then Return $nIndexLang
	Local $aReadText = IniReadSection($sIniLangInst, 'text')
	If @error Then Return $nIndexLang
	Local $sStringLang = ''
	For $i = 1 To $aReadLang[0][0]
		$sStringLang &= $aReadLang[$i][1] & '|'
	Next
	$sStringLang = StringTrimRight($sStringLang, 1)
	Local $hSelInstLang = GUICreate($aReadTitle[1][1], 400, 150, -1, -1, -1, 0x10000)
	GUISetIcon(@TempDir & '\wkdirjmp3\jmpack.ico')
	GUISetFont(12, 400, 0, 'Georgia')
	GUISetBkColor(0x808080)
	Local $iPicInstLang = GUICtrlCreatePic($sBackImgInst, 0, 0, 400, 150)
	GUICtrlSetState(-1, 128)
	Local $iComboLangInst = GUICtrlCreateCombo('', 35, 65, 210, -1, 0x3)
	GUICtrlSetData(-1, $sStringLang, $aReadLang[1][1])
	Local $iButtLangInst = GUICtrlCreateButton($aReadText[1][1], 280, 65, 80, 25)
	GUICtrlSetBkColor(-1, 0x808080)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUISetState(@SW_SHOW, $hSelInstLang)

	While 1
		$NMSG = GUIGetMsg()
		Switch $NMSG
			Case -3
				_StopSound()
				Run('cmd.exe /C rmdir /S /Q "' & @TempDir & '\wkdirjmp3' & '"', '', @SW_HIDE)
				Exit
			Case $iButtLangInst
				$nIndexLang = GUICtrlSendMsg($iComboLangInst, 0x147, 0, 0) + 1
				ExitLoop
			Case $iComboLangInst
				$nIndexLang = GUICtrlSendMsg($iComboLangInst, 0x147, 0, 0) + 1
				WinSetTitle($hSelInstLang, '', $aReadTitle[$nIndexLang][1])
				GUICtrlSetData($iButtLangInst, $aReadText[$nIndexLang][1])
		EndSwitch
	WEnd
	GUIDelete($hSelInstLang)
	Return $nIndexLang
EndFunc   ;==>_ChooseLang

Func _WinAPI_AddFont($sFont, $iFlag = 0, $bNotify = False)
	Local $aCall = DllCall('gdi32.dll', 'int', 'AddFontResourceExW', 'wstr', $sFont, 'dword', $iFlag, 'ptr', 0)
	If @error Or Not $aCall[0] Then Return SetError(@error, @extended, 0)
	; If Not $aCall[0] Then Return SetError(1000, 0, 0)
	If $bNotify Then
		Local Const $WM_FONTCHANGE = 0x001D
		Local Const $HWND_BROADCAST = 0xFFFF
		DllCall('user32.dll', 'lresult', 'SendMessage', 'hwnd', $HWND_BROADCAST, 'uint', $WM_FONTCHANGE, 'wparam', 0, _
				'lparam', 0)
	EndIf
	Return $aCall[0]
EndFunc   ;==>_WinAPI_AddFont

Func _Array_Add(ByRef $aArray, $vValue)
	If Not IsArray($aArray) Then Return SetError(1, 0, -1)
	Local $iDim = UBound($aArray, 1)
	ReDim $aArray[$iDim + 1]
	$aArray[$iDim] = $vValue
EndFunc   ;==>_Array_Add

Func _StopSound()
	_BASS_StreamFree($MusicHandleMod)
	_BASS_StreamFree($MusicHandleBck)
	_BASS_Stop()
	_BASS_Free()
EndFunc   ;==>_StopSound

Func _SetNewSong($sPath)
	_BASS_ChannelPause($MusicHandleBck)
	_BASS_StreamFree($MusicHandleMod)
	$MusicHandleMod = _BASS_StreamCreateFile(False, $sPath, 0, 0, 0)
	_BASS_ChannelPlay($MusicHandleMod, 1)
EndFunc   ;==>_SetNewSong

Func _ResetStopS()
	If $nausetmod = 4 Then _BASS_StreamFree($MusicHandleMod)
	If $nbackauset = 4 Then _BASS_ChannelPlay($MusicHandleBck, 0)
EndFunc   ;==>_ResetStopS

