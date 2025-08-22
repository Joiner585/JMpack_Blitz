#RequireAdmin
Opt('MustDeclareVars', 1)
Global Const $GDIP_PXF32ARGB = 0x0026200A
Global Const $GDIP_INTERPOLATIONMODE_HIGHQUALITYBICUBIC = 7
Global Const $GDIP_PIXELOFFSETMODE_HIGHQUALITY = 2
Global Enum $GDIP_WrapModeTile, $GDIP_WrapModeTileFlipX, $GDIP_WrapModeTileFlipY, $GDIP_WrapModeTileFlipXY, $GDIP_WrapModeClamp
Global Const $tagPOINT = "struct;long X;long Y;endstruct"
Global Const $tagRECT = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $tagSIZE = "struct;long X;long Y;endstruct"
Global Const $tagNMHDR = "struct;hwnd hWndFrom;uint_ptr IDFrom;INT Code;endstruct"
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagTVITEM = "struct;uint Mask;handle hItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & "int Children;lparam Param;endstruct"
Global Const $tagTVITEMEX = "struct;" & $tagTVITEM & ";int Integral;uint uStateEx;hwnd hwnd;int iExpandedImage;int iReserved;endstruct"
Global Const $tagTVHITTESTINFO = $tagPOINT & ";uint Flags;handle Item"
Global Const $tagBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $CREATE_NEW = 1
Global Const $CREATE_ALWAYS = 2
Global Const $OPEN_EXISTING = 3
Global Const $OPEN_ALWAYS = 4
Global Const $TRUNCATE_EXISTING = 5
Global Const $FILE_ATTRIBUTE_READONLY = 0x00000001
Global Const $FILE_ATTRIBUTE_HIDDEN = 0x00000002
Global Const $FILE_ATTRIBUTE_SYSTEM = 0x00000004
Global Const $FILE_ATTRIBUTE_ARCHIVE = 0x00000020
Global Const $FILE_SHARE_READ = 0x00000001
Global Const $FILE_SHARE_WRITE = 0x00000002
Global Const $FILE_SHARE_DELETE = 0x00000004
Global Const $GENERIC_EXECUTE = 0x20000000
Global Const $GENERIC_WRITE = 0x40000000
Global Const $GENERIC_READ = 0x80000000
Global Const $FLTA_FILESFOLDERS = 0
Global Const $IMAGE_BITMAP = 0
Global Const $IMAGE_ICON = 1
Func _WinAPI_GetDlgCtrlID($hWnd)
	Local $aCall = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hWnd)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetDlgCtrlID
Func _WinAPI_ReadFile($hFile, $pBuffer, $iToRead, ByRef $iRead, $tOverlapped = 0)
	Local $aCall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hFile, "struct*", $pBuffer, "dword", $iToRead, "dword*", 0, "struct*", $tOverlapped)
	If @error Then Return SetError(@error, @extended, False)
	$iRead = $aCall[4]
	Return $aCall[0]
EndFunc   ;==>_WinAPI_ReadFile
Global Const $STR_ENTIRESPLIT = 1
Global Const $STR_NOCOUNT = 2
Func _WinAPI_HiWord($iLong)
	Return BitShift($iLong, 16)
EndFunc   ;==>_WinAPI_HiWord
Func _WinAPI_LoWord($iLong)
	Return BitAND($iLong, 0xFFFF)
EndFunc   ;==>_WinAPI_LoWord
Func _WinAPI_ScreenToClient($hWnd, ByRef $tPoint)
	Local $aCall = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $hWnd, "struct*", $tPoint)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_ScreenToClient
Func _WinAPI_SwapDWord($iValue)
	Local $tStruct1 = DllStructCreate('dword;dword')
	Local $tStruct2 = DllStructCreate('byte[4];byte[4]', DllStructGetPtr($tStruct1))
	DllStructSetData($tStruct1, 1, $iValue)
	For $i = 1 To 4
		DllStructSetData($tStruct2, 2, DllStructGetData($tStruct2, 1, 5 - $i), $i)
	Next
	Return DllStructGetData($tStruct1, 2)
EndFunc   ;==>_WinAPI_SwapDWord
Func _WinAPI_SwapWord($iValue)
	Local $tStruct1 = DllStructCreate('word;word')
	Local $tStruct2 = DllStructCreate('byte[2];byte[2]', DllStructGetPtr($tStruct1))
	DllStructSetData($tStruct1, 1, $iValue)
	For $i = 1 To 2
		DllStructSetData($tStruct2, 2, DllStructGetData($tStruct2, 1, 3 - $i), $i)
	Next
	Return DllStructGetData($tStruct1, 2)
EndFunc   ;==>_WinAPI_SwapWord
Global Const $FR_NOT_ENUM = 0x20
Func _WinAPI_GetLastError(Const $_iCallerError = @error, Const $_iCallerExtended = @extended)
	Local $aCall = DllCall("kernel32.dll", "dword", "GetLastError")
	Return SetError($_iCallerError, $_iCallerExtended, $aCall[0])
EndFunc   ;==>_WinAPI_GetLastError
Func _WinAPI_SetLastError($iErrorCode, Const $_iCallerError = @error, Const $_iCallerExtended = @extended)
	DllCall("kernel32.dll", "none", "SetLastError", "dword", $iErrorCode)
	Return SetError($_iCallerError, $_iCallerExtended, Null)
EndFunc   ;==>_WinAPI_SetLastError
Func _WinAPI_CloseHandle($hObject)
	Local $aCall = DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hObject)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_CloseHandle
Func _WinAPI_DeleteObject($hObject)
	Local $aCall = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hObject)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_DeleteObject
Func _WinAPI_SelectObject($hDC, $hGDIObj)
	Local $aCall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hGDIObj)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_SelectObject
Func _WinAPI_GetMousePos($bToClient = False, $hWnd = 0)
	Local $iMode = Opt("MouseCoordMode", 1)
	Local $aPos = MouseGetPos()
	Opt("MouseCoordMode", $iMode)
	Local $tPoint = DllStructCreate($tagPOINT)
	DllStructSetData($tPoint, "X", $aPos[0])
	DllStructSetData($tPoint, "Y", $aPos[1])
	If $bToClient And Not _WinAPI_ScreenToClient($hWnd, $tPoint) Then Return SetError(@error + 20, @extended, 0)
	Return $tPoint
EndFunc   ;==>_WinAPI_GetMousePos
Func _WinAPI_RedrawWindow($hWnd, $tRECT = 0, $hRegion = 0, $iFlags = 5)
	Local $aCall = DllCall("user32.dll", "bool", "RedrawWindow", "hwnd", $hWnd, "struct*", $tRECT, "handle", $hRegion, "uint", $iFlags)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_RedrawWindow
Func _WinAPI_CreateCompatibleDC($hDC)
	Local $aCall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hDC)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_CreateCompatibleDC
Func _WinAPI_DeleteDC($hDC)
	Local $aCall = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hDC)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_DeleteDC
Func _WinAPI_GetDC($hWnd)
	Local $aCall = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hWnd)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetDC
Func _WinAPI_ReleaseDC($hWnd, $hDC)
	Local $aCall = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "handle", $hDC)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_ReleaseDC
Func _WinAPI_DestroyIcon($hIcon)
	Local $aCall = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $hIcon)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_DestroyIcon
Func _WinAPI_ExtractIconEx($sFilePath, $iIndex, $paLarge, $paSmall, $iIcons)
	Local $aCall = DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $sFilePath, "int", $iIndex, "struct*", $paLarge, "struct*", $paSmall, "uint", $iIcons)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_ExtractIconEx
Func _WinAPI_AddFontResourceEx($sFont, $iFlag = 0, $bNotify = False)
	Local $aCall = DllCall('gdi32.dll', 'int', 'AddFontResourceExW', 'wstr', $sFont, 'dword', $iFlag, 'ptr', 0)
	If @error Or Not $aCall[0] Then Return SetError(@error, @extended, 0)
	If $bNotify Then
		Local Const $WM_FONTCHANGE = 0x001D
		Local Const $HWND_BROADCAST = 0xFFFF
		DllCall('user32.dll', 'lresult', 'SendMessage', 'hwnd', $HWND_BROADCAST, 'uint', $WM_FONTCHANGE, 'wparam', 0, 'lparam', 0)
	EndIf
	Return $aCall[0]
EndFunc   ;==>_WinAPI_AddFontResourceEx
Func _WinAPI_GetFontResourceInfo($sFont, $bForce = False, $iFlag = Default)
	If $iFlag = Default Then
		If $bForce Then
			If Not _WinAPI_AddFontResourceEx($sFont, $FR_NOT_ENUM) Then Return SetError(@error + 20, @extended, '')
		EndIf
		Local $iError = 0
		Local $aRet = DllCall('gdi32.dll', 'bool', 'GetFontResourceInfoW', 'wstr', $sFont, 'dword*', 4096, 'wstr', '', 'dword', 0x01)
		If @error Or Not $aRet[0] Then $iError = @error + 10
		If $bForce Then
			_WinAPI_RemoveFontResourceEx($sFont, $FR_NOT_ENUM)
		EndIf
		If $iError Then Return SetError($iError, 0, '')
		Return $aRet[3]
	Else
		If Not FileExists($sFont) Then
			$sFont = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Fonts") & "\" & $sFont
			If Not FileExists($sFont) Then Return SetError(31, 0, "")
		EndIf
		Local Const $hFile = _WinAPI_CreateFile($sFont, 2, 2, 2)
		If Not $hFile Then Return SetError(32, _WinAPI_GetLastError(), "")
		Local Const $iFile = FileGetSize($sFont)
		Local Const $tBuffer = DllStructCreate("byte[" & $iFile + 1 & "]")
		Local Const $pFile = DllStructGetPtr($tBuffer)
		Local $iRead
		_WinAPI_ReadFile($hFile, $pFile, $iFile, $iRead)
		_WinAPI_CloseHandle($hFile)
		Local $sTTFName = _WinAPI_GetFontMemoryResourceInfo($pFile, $iFlag)
		If @error Then
			If @error = 1 Then
				$sTTFName = _WinAPI_GetFontResourceInfo($sFont, True)
				Return SetError(@error, @extended, $sTTFName)
			EndIf
			Return SetError(33, @error, "")
		EndIf
		Return $sTTFName
	EndIf
EndFunc   ;==>_WinAPI_GetFontResourceInfo
Func _WinAPI_GetFontMemoryResourceInfo($pMemory, $iFlag = 1)
	Local Const $tagTT_OFFSET_TABLE = "USHORT uMajorVersion;USHORT uMinorVersion;USHORT uNumOfTables;USHORT uSearchRange;USHORT uEntrySelector;USHORT uRangeShift"
	Local Const $tagTT_TABLE_DIRECTORY = "char szTag[4];ULONG uCheckSum;ULONG uOffset;ULONG uLength"
	Local Const $tagTT_NAME_TABLE_HEADER = "USHORT uFSelector;USHORT uNRCount;USHORT uStorageOffset"
	Local Const $tagTT_NAME_RECORD = "USHORT uPlatformID;USHORT uEncodingID;USHORT uLanguageID;USHORT uNameID;USHORT uStringLength;USHORT uStringOffset"
	Local $tTTOffsetTable = DllStructCreate($tagTT_OFFSET_TABLE, $pMemory)
	Local $iNumOfTables = _WinAPI_SwapWord(DllStructGetData($tTTOffsetTable, "uNumOfTables"))
	If Not (_WinAPI_SwapWord(DllStructGetData($tTTOffsetTable, "uMajorVersion")) = 1 And _WinAPI_SwapWord(DllStructGetData($tTTOffsetTable, "uMinorVersion")) = 0) Then Return SetError(1, 0, "")
	Local $iTblDirSize = DllStructGetSize(DllStructCreate($tagTT_TABLE_DIRECTORY))
	Local $bFound = False, $iOffset, $tTblDir
	For $i = 0 To $iNumOfTables - 1
		$tTblDir = DllStructCreate($tagTT_TABLE_DIRECTORY, $pMemory + DllStructGetSize($tTTOffsetTable) + $i * $iTblDirSize)
		If StringLeft(DllStructGetData($tTblDir, "szTag"), 4) = "name" Then
			$bFound = True
			$iOffset = _WinAPI_SwapDWord(DllStructGetData($tTblDir, "uOffset"))
			ExitLoop
		EndIf
	Next
	If Not $bFound Then Return SetError(2, 0, "")
	Local $tNTHeader = DllStructCreate($tagTT_NAME_TABLE_HEADER, $pMemory + $iOffset)
	Local $iNTHeaderSize = DllStructGetSize($tNTHeader)
	Local $iNRCount = _WinAPI_SwapWord(DllStructGetData($tNTHeader, "uNRCount"))
	Local $iStorageOffset = _WinAPI_SwapWord(DllStructGetData($tNTHeader, "uStorageOffset"))
	Local $iTTRecordSize = DllStructGetSize(DllStructCreate($tagTT_NAME_RECORD))
	Local $tResult, $sResult, $iStringLength = 0, $iStringOffset, $iEncodingID, $tTTRecord
	For $i = 0 To $iNRCount - 1
		$tTTRecord = DllStructCreate($tagTT_NAME_RECORD, $pMemory + $iOffset + $iNTHeaderSize + $i * $iTTRecordSize)
		If @error Then ContinueLoop
		If _WinAPI_SwapWord($tTTRecord.uNameID) = $iFlag Then
			$iStringLength = _WinAPI_SwapWord(DllStructGetData($tTTRecord, "uStringLength"))
			$iStringOffset = _WinAPI_SwapWord(DllStructGetData($tTTRecord, "uStringOffset"))
			$iEncodingID = _WinAPI_SwapWord(DllStructGetData($tTTRecord, "uEncodingID"))
			Local $sWchar = "char"
			If $iEncodingID = 1 Then
				$sWchar = "word"
				$iStringLength /= 2
			EndIf
			If Not $iStringLength Then
				$sResult = ""
				ContinueLoop
			EndIf
			$tResult = DllStructCreate($sWchar & " szTTFName[" & $iStringLength & "]", $pMemory + $iOffset + $iStringOffset + $iStorageOffset)
			If $iEncodingID = 1 Then
				$sResult = ""
				For $j = 1 To $iStringLength
					$sResult &= ChrW(_WinAPI_SwapWord(DllStructGetData($tResult, 1, $j)))
				Next
			Else
				$sResult = $tResult.szTTFName
			EndIf
			If StringLen($sResult) > 0 Then ExitLoop
		EndIf
	Next
	Return $sResult
EndFunc   ;==>_WinAPI_GetFontMemoryResourceInfo
Func _WinAPI_RemoveFontResourceEx($sFont, $iFlag = 0, $bNotify = False)
	Local $aCall = DllCall('gdi32.dll', 'bool', 'RemoveFontResourceExW', 'wstr', $sFont, 'dword', $iFlag, 'ptr', 0)
	If @error Or Not $aCall[0] Then Return SetError(@error, @extended, False)
	If $bNotify Then
		Local Const $WM_FONTCHANGE = 0x001D
		Local Const $HWND_BROADCAST = 0xFFFF
		DllCall('user32.dll', 'none', 'SendMessage', 'hwnd', $HWND_BROADCAST, 'uint', $WM_FONTCHANGE, 'wparam', 0, 'lparam', 0)
	EndIf
	Return $aCall[0]
EndFunc   ;==>_WinAPI_RemoveFontResourceEx
Global $__g_hGDIPDll = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Func _GDIPlus_BitmapCreateFromFile($sFileName)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateBitmapFromFile", "wstr", $sFileName, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_BitmapCreateFromFile
Func _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight, $iPixelFormat = $GDIP_PXF32ARGB, $iStride = 0, $pScan0 = 0)
	Local $aCall = DllCall($__g_hGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iStride, "int", $iPixelFormat, "struct*", $pScan0, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[6]
EndFunc   ;==>_GDIPlus_BitmapCreateFromScan0
Func _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap, $iARGB = 0xFF000000)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateHBITMAPFromBitmap", "handle", $hBitmap, "handle*", 0, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_BitmapCreateHBITMAPFromBitmap
Func _GDIPlus_BitmapDispose($hBitmap)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDisposeImage", "handle", $hBitmap)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_BitmapDispose
Func _GDIPlus_GraphicsDispose($hGraphics)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeleteGraphics", "handle", $hGraphics)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsDispose
Func _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, $nSrcX, $nSrcY, $nSrcWidth, $nSrcHeight, $nDstX, $nDstY, $nDstWidth, $nDstHeight, $pAttributes = 0, $iUnit = 2)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDrawImageRectRect", "handle", $hGraphics, "handle", $hImage, "float", $nDstX, "float", $nDstY, "float", $nDstWidth, "float", $nDstHeight, "float", $nSrcX, "float", $nSrcY, "float", $nSrcWidth, "float", $nSrcHeight, "int", $iUnit, "handle", $pAttributes, "ptr", 0, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRect
Func _GDIPlus_GraphicsSetInterpolationMode($hGraphics, $iInterpolationMode)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipSetInterpolationMode", "handle", $hGraphics, "int", $iInterpolationMode)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsSetInterpolationMode
Func _GDIPlus_GraphicsSetPixelOffsetMode($hGraphics, $iPixelOffsetMode)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipSetPixelOffsetMode", "handle", $hGraphics, "int", $iPixelOffsetMode)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsSetPixelOffsetMode
Func _GDIPlus_ImageAttributesCreate()
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateImageAttributes", "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[1]
EndFunc   ;==>_GDIPlus_ImageAttributesCreate
Func _GDIPlus_ImageAttributesDispose($hImageAttributes)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDisposeImageAttributes", "handle", $hImageAttributes)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_ImageAttributesDispose
Func _GDIPlus_ImageDispose($hImage)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDisposeImage", "handle", $hImage)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_ImageDispose
Func _GDIPlus_ImageGetGraphicsContext($hImage)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipGetImageGraphicsContext", "handle", $hImage, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_ImageGetGraphicsContext
Func _GDIPlus_ImageGetHeight($hImage)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipGetImageHeight", "handle", $hImage, "uint*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aCall[0] Then Return SetError(10, $aCall[0], -1)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_ImageGetHeight
Func _GDIPlus_ImageGetWidth($hImage)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipGetImageWidth", "handle", $hImage, "uint*", -1)
	If @error Then Return SetError(@error, @extended, -1)
	If $aCall[0] Then Return SetError(10, $aCall[0], -1)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_ImageGetWidth
Func _GDIPlus_ImageLoadFromFile($sFileName)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipLoadImageFromFile", "wstr", $sFileName, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_ImageLoadFromFile
Func __GDIPlus_ImageAttributesSetImageWrapMode($hImageAttributes, $iWrapMode = $GDIP_WrapModeTileFlipXY, $iColor = 0xFF000000)
	Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetImageAttributesWrapMode", "handle", $hImageAttributes, "long", $iWrapMode, "uint", $iColor, "bool", False)
	If @error Then Return SetError(@error, @extended, False)
	If $aResult[0] Then Return SetError(10, $aResult[0], False)
	Return True
EndFunc   ;==>__GDIPlus_ImageAttributesSetImageWrapMode
Func _GDIPlus_ImageResize($hImage, $iNewWidth, $iNewHeight, $iInterpolationMode = $GDIP_INTERPOLATIONMODE_HIGHQUALITYBICUBIC)
	Local $iWidth = _GDIPlus_ImageGetWidth($hImage)
	If @error Then Return SetError(1, 0, 0)
	Local $iHeight = _GDIPlus_ImageGetHeight($hImage)
	If @error Then Return SetError(2, 0, 0)
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iNewWidth, $iNewHeight)
	If @error Then Return SetError(3, 0, 0)
	Local $hBmpCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetInterpolationMode($hBmpCtxt, $iInterpolationMode)
	_GDIPlus_GraphicsSetPixelOffsetMode($hBmpCtxt, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)
	Local $hIA = _GDIPlus_ImageAttributesCreate()
	__GDIPlus_ImageAttributesSetImageWrapMode($hIA)
	If @error Then
		_GDIPlus_ImageAttributesDispose($hIA)
		_GDIPlus_GraphicsDispose($hBmpCtxt)
		_GDIPlus_BitmapDispose($hBitmap)
		Return SetError(4, 0, 0)
	EndIf
	_GDIPlus_GraphicsDrawImageRectRect($hBmpCtxt, $hImage, 0, 0, $iWidth, $iHeight, 0, 0, $iNewWidth, $iNewHeight, $hIA)
	_GDIPlus_GraphicsDispose($hBmpCtxt)
	Return $hBitmap
EndFunc   ;==>_GDIPlus_ImageResize
Func _GDIPlus_Shutdown()
	If $__g_hGDIPDll = 0 Then Return SetError(-1, -1, False)
	$__g_iGDIPRef -= 1
	If $__g_iGDIPRef = 0 Then
		DllCall($__g_hGDIPDll, "none", "GdiplusShutdown", "ulong_ptr", $__g_iGDIPToken)
		DllClose($__g_hGDIPDll)
		$__g_hGDIPDll = 0
	EndIf
	Return True
EndFunc   ;==>_GDIPlus_Shutdown
Func _GDIPlus_Startup($sGDIPDLL = Default, $bRetDllHandle = False)
	$__g_iGDIPRef += 1
	If $__g_iGDIPRef > 1 Then Return True
	If $sGDIPDLL = Default Then $sGDIPDLL = "gdiplus.dll"
	$__g_hGDIPDll = DllOpen($sGDIPDLL)
	If $__g_hGDIPDll = -1 Then
		$__g_iGDIPRef = 0
		Return SetError(1, 2, False)
	EndIf
	Local $sVer = FileGetVersion($sGDIPDLL)
	$sVer = StringSplit($sVer, ".")
	If $sVer[1] > 5 Then $__g_bGDIP_V1_0 = False
	Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
	Local $tToken = DllStructCreate("ulong_ptr Data")
	DllStructSetData($tInput, "Version", 1)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	$__g_iGDIPToken = DllStructGetData($tToken, "Data")
	If $bRetDllHandle Then Return $__g_hGDIPDll
	Return SetExtended($sVer[1], True)
EndFunc   ;==>_GDIPlus_Startup
Global Enum $ARRAYFILL_FORCE_DEFAULT, $ARRAYFILL_FORCE_SINGLEITEM, $ARRAYFILL_FORCE_INT, $ARRAYFILL_FORCE_NUMBER, $ARRAYFILL_FORCE_PTR, $ARRAYFILL_FORCE_HWND, $ARRAYFILL_FORCE_STRING, $ARRAYFILL_FORCE_BOOLEAN
Func _ArrayAdd(ByRef $aArray, $vValue, $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYFILL_FORCE_DEFAULT)
	If $iStart = Default Then $iStart = 0
	If $sDelim_Item = Default Then $sDelim_Item = "|"
	If $sDelim_Row = Default Then $sDelim_Row = @CRLF
	If $iForce = Default Then $iForce = $ARRAYFILL_FORCE_DEFAULT
	If Not IsArray($aArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
	Local $hDataType = 0
	Switch $iForce
		Case $ARRAYFILL_FORCE_INT
			$hDataType = Int
		Case $ARRAYFILL_FORCE_NUMBER
			$hDataType = Number
		Case $ARRAYFILL_FORCE_PTR
			$hDataType = Ptr
		Case $ARRAYFILL_FORCE_HWND
			$hDataType = Hwnd
		Case $ARRAYFILL_FORCE_STRING
			$hDataType = String
		Case $ARRAYFILL_FORCE_BOOLEAN
			$hDataType = "Boolean"
	EndSwitch
	Switch UBound($aArray, $UBOUND_DIMENSIONS)
		Case 1
			If $iForce = $ARRAYFILL_FORCE_SINGLEITEM Then
				ReDim $aArray[$iDim_1 + 1]
				$aArray[$iDim_1] = $vValue
				Return $iDim_1
			EndIf
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
				$hDataType = 0
			Else
				Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				If UBound($aTmp, $UBOUND_ROWS) = 1 Then
					$aTmp[0] = $vValue
				EndIf
				$vValue = $aTmp
			EndIf
			Local $iAdd = UBound($vValue, $UBOUND_ROWS)
			ReDim $aArray[$iDim_1 + $iAdd]
			For $i = 0 To $iAdd - 1
				If String($hDataType) = "Boolean" Then
					Switch $vValue[$i]
						Case "True", "1"
							$aArray[$iDim_1 + $i] = True
						Case "False", "0", ""
							$aArray[$iDim_1 + $i] = False
					EndSwitch
				ElseIf IsFunc($hDataType) Then
					$aArray[$iDim_1 + $i] = $hDataType($vValue[$i])
				Else
					$aArray[$iDim_1 + $i] = $vValue[$i]
				EndIf
			Next
			Return $iDim_1 + $iAdd - 1
		Case 2
			Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
			If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(4, 0, -1)
			Local $iValDim_1, $iValDim_2 = 0, $iColCount
			If IsArray($vValue) Then
				If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(5, 0, -1)
				$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
				$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
				$hDataType = 0
			Else
				Local $aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
				$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
				Local $aTmp[$iValDim_1][0], $aSplit_2
				For $i = 0 To $iValDim_1 - 1
					$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
					$iColCount = UBound($aSplit_2)
					If $iColCount > $iValDim_2 Then
						$iValDim_2 = $iColCount
						ReDim $aTmp[$iValDim_1][$iValDim_2]
					EndIf
					For $j = 0 To $iColCount - 1
						$aTmp[$i][$j] = $aSplit_2[$j]
					Next
				Next
				$vValue = $aTmp
			EndIf
			If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($aArray, $UBOUND_COLUMNS) Then Return SetError(3, 0, -1)
			ReDim $aArray[$iDim_1 + $iValDim_1][$iDim_2]
			For $iWriteTo_Index = 0 To $iValDim_1 - 1
				For $j = 0 To $iDim_2 - 1
					If $j < $iStart Then
						$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
					ElseIf $j - $iStart > $iValDim_2 - 1 Then
						$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
					Else
						If String($hDataType) = "Boolean" Then
							Switch $vValue[$iWriteTo_Index][$j - $iStart]
								Case "True", "1"
									$aArray[$iWriteTo_Index + $iDim_1][$j] = True
								Case "False", "0", ""
									$aArray[$iWriteTo_Index + $iDim_1][$j] = False
							EndSwitch
						ElseIf IsFunc($hDataType) Then
							$aArray[$iWriteTo_Index + $iDim_1][$j] = $hDataType($vValue[$iWriteTo_Index][$j - $iStart])
						Else
							$aArray[$iWriteTo_Index + $iDim_1][$j] = $vValue[$iWriteTo_Index][$j - $iStart]
						EndIf
					EndIf
				Next
			Next
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch
	Return UBound($aArray, $UBOUND_ROWS) - 1
EndFunc   ;==>_ArrayAdd
Func _ArrayConcatenate(ByRef $aArrayTarget, Const ByRef $aArraySource, $iStart = 0)

	If $iStart = Default Then $iStart = 0
	If Not IsArray($aArrayTarget) Then Return SetError(1, 0, -1)
	If Not IsArray($aArraySource) Then Return SetError(2, 0, -1)
	Local $iDim_Total_Tgt = UBound($aArrayTarget, $UBOUND_DIMENSIONS)
	Local $iDim_Total_Src = UBound($aArraySource, $UBOUND_DIMENSIONS)
	Local $iDim_1_Tgt = UBound($aArrayTarget, $UBOUND_ROWS)
	Local $iDim_1_Src = UBound($aArraySource, $UBOUND_ROWS)
	If $iStart < 0 Or $iStart > $iDim_1_Src - 1 Then Return SetError(6, 0, -1)
	Switch $iDim_Total_Tgt
		Case 1
			If $iDim_Total_Src <> 1 Then Return SetError(4, 0, -1)
			ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart]
			For $i = $iStart To $iDim_1_Src - 1
				$aArrayTarget[$iDim_1_Tgt + $i - $iStart] = $aArraySource[$i]
			Next
		Case 2
			If $iDim_Total_Src <> 2 Then Return SetError(4, 0, -1)
			Local $iDim_2_Tgt = UBound($aArrayTarget, $UBOUND_COLUMNS)
			If UBound($aArraySource, $UBOUND_COLUMNS) <> $iDim_2_Tgt Then Return SetError(5, 0, -1)
			ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart][$iDim_2_Tgt]
			For $i = $iStart To $iDim_1_Src - 1
				For $j = 0 To $iDim_2_Tgt - 1
					$aArrayTarget[$iDim_1_Tgt + $i - $iStart][$j] = $aArraySource[$i][$j]
				Next
			Next
		Case Else
			Return SetError(3, 0, -1)
	EndSwitch
	Return UBound($aArrayTarget, $UBOUND_ROWS)
EndFunc   ;==>_ArrayConcatenate
Func _ArrayDelete(ByRef $aArray, $vRange)
	If Not IsArray($aArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
	If IsArray($vRange) Then
		If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
	Else
		Local $iNumber, $aSplit_1, $aSplit_2
		$vRange = StringStripWS($vRange, 8)
		$aSplit_1 = StringSplit($vRange, ";")
		$vRange = ""
		For $i = 1 To $aSplit_1[0]
			If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
			$aSplit_2 = StringSplit($aSplit_1[$i], "-")
			Switch $aSplit_2[0]
				Case 1
					$vRange &= $aSplit_2[1] & ";"
				Case 2
					If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
						$iNumber = $aSplit_2[1] - 1
						Do
							$iNumber += 1
							$vRange &= $iNumber & ";"
						Until $iNumber = $aSplit_2[2]
					EndIf
			EndSwitch
		Next
		$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
	EndIf
	For $i = 1 To $vRange[0]
		$vRange[$i] = Number($vRange[$i])
	Next
	If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
	Local $iCopyTo_Index = 0
	Switch UBound($aArray, $UBOUND_DIMENSIONS)
		Case 1
			For $i = 1 To $vRange[0]
				$aArray[$vRange[$i]] = ChrW(0xFAB1)
			Next
			For $iReadFrom_Index = 0 To $iDim_1
				If $aArray[$iReadFrom_Index] == ChrW(0xFAB1) Then
					ContinueLoop
				Else
					If $iReadFrom_Index <> $iCopyTo_Index Then
						$aArray[$iCopyTo_Index] = $aArray[$iReadFrom_Index]
					EndIf
					$iCopyTo_Index += 1
				EndIf
			Next
			ReDim $aArray[$iDim_1 - $vRange[0] + 1]
		Case 2
			Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
			For $i = 1 To $vRange[0]
				$aArray[$vRange[$i]][0] = ChrW(0xFAB1)
			Next
			For $iReadFrom_Index = 0 To $iDim_1
				If $aArray[$iReadFrom_Index][0] == ChrW(0xFAB1) Then
					ContinueLoop
				Else
					If $iReadFrom_Index <> $iCopyTo_Index Then
						For $j = 0 To $iDim_2
							$aArray[$iCopyTo_Index][$j] = $aArray[$iReadFrom_Index][$j]
						Next
					EndIf
					$iCopyTo_Index += 1
				EndIf
			Next
			ReDim $aArray[$iDim_1 - $vRange[0] + 1][$iDim_2 + 1]
		Case Else
			Return SetError(2, 0, False)
	EndSwitch
	Return UBound($aArray, $UBOUND_ROWS)
EndFunc   ;==>_ArrayDelete
Func _ArrayToString(Const ByRef $aArray, $sDelim_Col = "|", $iStart_Row = Default, $iEnd_Row = Default, $sDelim_Row = @CRLF, $iStart_Col = Default, $iEnd_Col = Default)
	If $sDelim_Col = Default Then $sDelim_Col = "|"
	If $sDelim_Row = Default Then $sDelim_Row = @CRLF
	If $iStart_Row = Default Then $iStart_Row = -1
	If $iEnd_Row = Default Then $iEnd_Row = -1
	If $iStart_Col = Default Then $iStart_Col = -1
	If $iEnd_Col = Default Then $iEnd_Col = -1
	If Not IsArray($aArray) Then Return SetError(1, 0, -1)
	Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
	If $iDim_1 = -1 Then Return ""
	If $iStart_Row = -1 Then $iStart_Row = 0
	If $iEnd_Row = -1 Then $iEnd_Row = $iDim_1
	If $iStart_Row < -1 Or $iEnd_Row < -1 Then Return SetError(3, 0, -1)
	If $iStart_Row > $iDim_1 Or $iEnd_Row > $iDim_1 Then Return SetError(3, 0, "")
	If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
	Local $sRet = ""
	Switch UBound($aArray, $UBOUND_DIMENSIONS)
		Case 1
			For $i = $iStart_Row To $iEnd_Row
				$sRet &= $aArray[$i] & $sDelim_Col
			Next
			Return StringTrimRight($sRet, StringLen($sDelim_Col))
		Case 2
			Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
			If $iDim_2 = -1 Then Return ""
			If $iStart_Col = -1 Then $iStart_Col = 0
			If $iEnd_Col = -1 Then $iEnd_Col = $iDim_2
			If $iStart_Col < -1 Or $iEnd_Col < -1 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iDim_2 Or $iEnd_Col > $iDim_2 Then Return SetError(5, 0, -1)
			If $iStart_Col > $iEnd_Col Then Return SetError(6, 0, -1)
			Local $iDelimColLen = StringLen($sDelim_Col)
			For $i = $iStart_Row To $iEnd_Row
				For $j = $iStart_Col To $iEnd_Col
					$sRet &= $aArray[$i][$j] & $sDelim_Col
				Next
				$sRet = StringTrimRight($sRet, $iDelimColLen) & $sDelim_Row
			Next
			Return StringTrimRight($sRet, StringLen($sDelim_Row))
		Case Else
			Return SetError(2, 0, -1)
	EndSwitch
	Return 1
EndFunc   ;==>_ArrayToString
Func _WinAPI_CreateFile($sFileName, $iCreation, $iAccess = 4, $iShare = 0, $iAttributes = 0, $tSecurity = 0)
	Local $iDA = 0, $iSM = 0, $iCD = 0, $iFA = 0
	If BitAND($iAccess, 1) <> 0 Then $iDA = BitOR($iDA, 0x20000000)
	If BitAND($iAccess, 2) <> 0 Then $iDA = BitOR($iDA, 0x80000000)
	If BitAND($iAccess, 4) <> 0 Then $iDA = BitOR($iDA, 0x40000000)
	If BitAND($iShare, 1) <> 0 Then $iSM = BitOR($iSM, 0x00000004)
	If BitAND($iShare, 2) <> 0 Then $iSM = BitOR($iSM, 0x00000001)
	If BitAND($iShare, 4) <> 0 Then $iSM = BitOR($iSM, 0x00000002)
	Switch $iCreation
		Case 0
			$iCD = 1
		Case 1
			$iCD = 2
		Case 2
			$iCD = 3
		Case 3
			$iCD = 4
		Case 4
			$iCD = 5
	EndSwitch
	If BitAND($iAttributes, 1) <> 0 Then $iFA = BitOR($iFA, $FILE_ATTRIBUTE_ARCHIVE)
	If BitAND($iAttributes, 2) <> 0 Then $iFA = BitOR($iFA, $FILE_ATTRIBUTE_HIDDEN)
	If BitAND($iAttributes, 4) <> 0 Then $iFA = BitOR($iFA, $FILE_ATTRIBUTE_READONLY)
	If BitAND($iAttributes, 8) <> 0 Then $iFA = BitOR($iFA, $FILE_ATTRIBUTE_SYSTEM)
	Local $aCall = DllCall("kernel32.dll", "handle", "CreateFileW", "wstr", $sFileName, "dword", $iDA, "dword", $iSM, "struct*", $tSecurity, "dword", $iCD, "dword", $iFA, "ptr", 0)
	If @error Or ($aCall[0] = Ptr(-1)) Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_CreateFile
Global Const $MEM_COMMIT = 0x00001000
Global Const $MEM_RESERVE = 0x00002000
Global Const $PAGE_READWRITE = 0x00000004
Global Const $MEM_RELEASE = 0x00008000
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_PRIVILEGE_ENABLED = 0x00000002
Global Enum $SECURITYANONYMOUS = 0, $SECURITYIDENTIFICATION, $SECURITYIMPERSONATION, $SECURITYDELEGATION
Global Const $TOKEN_QUERY = 0x00000008
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x00000020
Func _Security__AdjustTokenPrivileges($hToken, $bDisableAll, $tNewState, $iBufferLen, $tPrevState = 0, $pRequired = 0)
	Local $aCall = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $hToken, "bool", $bDisableAll, "struct*", $tNewState, "dword", $iBufferLen, "struct*", $tPrevState, "struct*", $pRequired)
	If @error Then Return SetError(@error, @extended, False)
	Return Not ($aCall[0] = 0)
EndFunc   ;==>_Security__AdjustTokenPrivileges
Func _Security__ImpersonateSelf($iLevel = $SECURITYIMPERSONATION)
	Local $aCall = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $iLevel)
	If @error Then Return SetError(@error, @extended, False)
	Return Not ($aCall[0] = 0)
EndFunc   ;==>_Security__ImpersonateSelf
Func _Security__LookupPrivilegeValue($sSystem, $sName)
	Local $aCall = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "wstr", $sSystem, "wstr", $sName, "int64*", 0)
	If @error Or Not $aCall[0] Then Return SetError(@error + 10, @extended, 0)
	Return $aCall[3]
EndFunc   ;==>_Security__LookupPrivilegeValue
Func _Security__OpenThreadToken($iAccess, $hThread = 0, $bOpenAsSelf = False)
	Local $aCall
	If $hThread = 0 Then
		$aCall = DllCall("kernel32.dll", "handle", "GetCurrentThread")
		If @error Then Return SetError(@error + 20, @extended, 0)
		$hThread = $aCall[0]
	EndIf
	$aCall = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $hThread, "dword", $iAccess, "bool", $bOpenAsSelf, "handle*", 0)
	If @error Or Not $aCall[0] Then Return SetError(@error + 10, @extended, 0)
	Return $aCall[4]
EndFunc   ;==>_Security__OpenThreadToken
Func _Security__OpenThreadTokenEx($iAccess, $hThread = 0, $bOpenAsSelf = False)
	Local $hToken = _Security__OpenThreadToken($iAccess, $hThread, $bOpenAsSelf)
	If $hToken = 0 Then
		Local Const $ERROR_NO_TOKEN = 1008
		If _WinAPI_GetLastError() <> $ERROR_NO_TOKEN Then Return SetError(20, _WinAPI_GetLastError(), 0)
		If Not _Security__ImpersonateSelf() Then Return SetError(@error + 10, _WinAPI_GetLastError(), 0)
		$hToken = _Security__OpenThreadToken($iAccess, $hThread, $bOpenAsSelf)
		If $hToken = 0 Then Return SetError(@error, _WinAPI_GetLastError(), 0)
	EndIf
	Return $hToken
EndFunc   ;==>_Security__OpenThreadTokenEx
Func _Security__SetPrivilege($hToken, $sPrivilege, $bEnable)
	Local $iLUID = _Security__LookupPrivilegeValue("", $sPrivilege)
	If $iLUID = 0 Then Return SetError(@error + 10, @extended, False)
	Local Const $tagTOKEN_PRIVILEGES = "dword Count;align 4;int64 LUID;dword Attributes"
	Local $tCurrState = DllStructCreate($tagTOKEN_PRIVILEGES)
	Local $iCurrState = DllStructGetSize($tCurrState)
	Local $tPrevState = DllStructCreate($tagTOKEN_PRIVILEGES)
	Local $iPrevState = DllStructGetSize($tPrevState)
	Local $tRequired = DllStructCreate("int Data")
	DllStructSetData($tCurrState, "Count", 1)
	DllStructSetData($tCurrState, "LUID", $iLUID)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $tCurrState, $iCurrState, $tPrevState, $tRequired) Then Return SetError(2, @error, False)
	DllStructSetData($tPrevState, "Count", 1)
	DllStructSetData($tPrevState, "LUID", $iLUID)
	Local $iAttributes = DllStructGetData($tPrevState, "Attributes")
	If $bEnable Then
		$iAttributes = BitOR($iAttributes, $SE_PRIVILEGE_ENABLED)
	Else
		$iAttributes = BitAND($iAttributes, BitNOT($SE_PRIVILEGE_ENABLED))
	EndIf
	DllStructSetData($tPrevState, "Attributes", $iAttributes)
	If Not _Security__AdjustTokenPrivileges($hToken, False, $tPrevState, $iPrevState, $tCurrState, $tRequired) Then Return SetError(3, @error, False)
	Return True
EndFunc   ;==>_Security__SetPrivilege
Func _WinAPI_LoadCursorFromFile($sFilePath)
	Local $aCall = DllCall('user32.dll', 'handle', 'LoadCursorFromFileW', 'wstr', $sFilePath)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_LoadCursorFromFile
Func _WinAPI_SetCursor($hCursor)
	Local $aCall = DllCall("user32.dll", "handle", "SetCursor", "handle", $hCursor)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_SetCursor
Global Const $CSIDL_FONTS = 0x0014
Func _WinAPI_ShellGetSpecialFolderPath($iCSIDL, $bCreate = False)
	Local $aCall = DllCall('shell32.dll', 'bool', 'SHGetSpecialFolderPathW', 'hwnd', 0, 'wstr', '', 'int', $iCSIDL, 'bool', $bCreate)
	If @error Or Not $aCall[0] Then Return SetError(@error + 10, @extended, '')
	Return $aCall[2]
EndFunc   ;==>_WinAPI_ShellGetSpecialFolderPath
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $ULW_ALPHA = 0x02
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
	Local $aCall = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
	If @error Then Return SetError(@error, @extended, "")
	If $iReturn >= 0 And $iReturn <= 4 Then Return $aCall[$iReturn]
	Return $aCall
EndFunc   ;==>_SendMessage
Global $__g_aInProcess_WinAPI[64][2] = [[0, 0]]
Global Const $GW_HWNDNEXT = 2
Global Const $GW_HWNDPREV = 3
Global Const $GWL_STYLE = 0xFFFFFFF0
Func _WinAPI_DestroyWindow($hWnd)
	Local $aCall = DllCall("user32.dll", "bool", "DestroyWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_DestroyWindow
Func _WinAPI_GetParent($hWnd)
	Local $aCall = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hWnd)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetParent
Func _WinAPI_GetWindow($hWnd, $iCmd)
	Local $aCall = DllCall("user32.dll", "hwnd", "GetWindow", "hwnd", $hWnd, "uint", $iCmd)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetWindow
Func _WinAPI_GetWindowLong($hWnd, $iIndex)
	Local $sFuncName = "GetWindowLongW"
	If @AutoItX64 Then $sFuncName = "GetWindowLongPtrW"
	Local $aCall = DllCall("user32.dll", "long_ptr", $sFuncName, "hwnd", $hWnd, "int", $iIndex)
	If @error Or Not $aCall[0] Then Return SetError(@error + 10, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetWindowLong
Func _WinAPI_GetWindowThreadProcessId($hWnd, ByRef $iPID)
	Local $aCall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$iPID = $aCall[2]
	Return $aCall[0]
EndFunc   ;==>_WinAPI_GetWindowThreadProcessId
Func _WinAPI_InProcess($hWnd, ByRef $hLastWnd)
	If $hWnd = $hLastWnd Then Return True
	For $iI = $__g_aInProcess_WinAPI[0][0] To 1 Step -1
		If $hWnd = $__g_aInProcess_WinAPI[$iI][0] Then
			If $__g_aInProcess_WinAPI[$iI][1] Then
				$hLastWnd = $hWnd
				Return True
			Else
				Return False
			EndIf
		EndIf
	Next
	Local $iPID
	_WinAPI_GetWindowThreadProcessId($hWnd, $iPID)
	Local $iCount = $__g_aInProcess_WinAPI[0][0] + 1
	If $iCount >= 64 Then $iCount = 1
	$__g_aInProcess_WinAPI[0][0] = $iCount
	$__g_aInProcess_WinAPI[$iCount][0] = $hWnd
	$__g_aInProcess_WinAPI[$iCount][1] = ($iPID = @AutoItPID)
	Return $__g_aInProcess_WinAPI[$iCount][1]
EndFunc   ;==>_WinAPI_InProcess
Func _WinAPI_InvalidateRect($hWnd, $tRECT = 0, $bErase = True)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Local $aCall = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $hWnd, "struct*", $tRECT, "bool", $bErase)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_InvalidateRect
Func _WinAPI_MoveWindow($hWnd, $iX, $iY, $iWidth, $iHeight, $bRepaint = True)
	Local $aCall = DllCall("user32.dll", "bool", "MoveWindow", "hwnd", $hWnd, "int", $iX, "int", $iY, "int", $iWidth, "int", $iHeight, "bool", $bRepaint)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_MoveWindow
Func _WinAPI_UpdateWindow($hWnd)
	Local $aCall = DllCall("user32.dll", "bool", "UpdateWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_UpdateWindow
Func _WinAPI_SetLayeredWindowAttributes($hWnd, $iTransColor, $iTransGUI = 255, $iFlags = 0x03, $bColorRef = False)
	If $iFlags = Default Or $iFlags = "" Or $iFlags < 0 Then $iFlags = 0x03
	If Not $bColorRef Then
		$iTransColor = Int(BinaryMid($iTransColor, 3, 1) & BinaryMid($iTransColor, 2, 1) & BinaryMid($iTransColor, 1, 1))
	EndIf
	Local $aCall = DllCall("user32.dll", "bool", "SetLayeredWindowAttributes", "hwnd", $hWnd, "INT", $iTransColor, "byte", $iTransGUI, "dword", $iFlags)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_SetLayeredWindowAttributes
Func _WinAPI_SetWindowLong($hWnd, $iIndex, $iValue)
	_WinAPI_SetLastError(0)
	Local $sFuncName = "SetWindowLongW"
	If @AutoItX64 Then $sFuncName = "SetWindowLongPtrW"
	Local $aCall = DllCall("user32.dll", "long_ptr", $sFuncName, "hwnd", $hWnd, "int", $iIndex, "long_ptr", $iValue)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_SetWindowLong
Func _WinAPI_UpdateLayeredWindow($hWnd, $hDestDC, $tPTDest, $tSize, $hSrcDC, $tPTSrce, $iRGB, $tBlend, $iFlags)
	Local $aCall = DllCall("user32.dll", "bool", "UpdateLayeredWindow", "hwnd", $hWnd, "handle", $hDestDC, "struct*", $tPTDest, "struct*", $tSize, "handle", $hSrcDC, "struct*", $tPTSrce, "dword", $iRGB, "struct*", $tBlend, "dword", $iFlags)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_WinAPI_UpdateLayeredWindow
Global Const $PROCESS_VM_OPERATION = 0x00000008
Global Const $PROCESS_VM_READ = 0x00000010
Global Const $PROCESS_VM_WRITE = 0x00000020
Global $__g_hGDIPDll = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_LAYERED = 0x00080000
Global Const $WS_EX_MDICHILD = 0x00000040
Global Const $WS_EX_TOOLWINDOW = 0x00000080
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WM_SETCURSOR = 0x0020
Global Const $WM_NOTIFY = 0x004E
Global Const $WM_COMMAND = 0x0111
Global Const $NM_FIRST = 0
Global Const $NM_CLICK = $NM_FIRST - 2
Global Const $NM_RCLICK = $NM_FIRST - 5
Global Const $WM_MOUSEWHEEL = 0x020A
Global Const $__SS_BITMAP = 0x0E
Global Const $__SS_ICON = 0x03
Global Const $__STM_SETIMAGE = 0x0172
Global Const $__STM_GETIMAGE = 0x0173
Func _SetImage($hWnd, ByRef $sImage, $sSW, $sSH, $hOverlap = 0)
	$hWnd = _Icons_Control_CheckHandle($hWnd)
	If $hWnd = 0 Then
		Return SetError(1, 0, 0)
	EndIf
	Local $Result, $hBitmap, $hFit, $hImage, $hBitmap_Scaled
	_GDIPlus_Startup()
	$hImage = _GDIPlus_BitmapCreateFromFile($sImage)
	$hBitmap_Scaled = _GDIPlus_ImageResize($hImage, $sSW, $sSH)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap_Scaled)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_ImageDispose($hBitmap_Scaled)
	_GDIPlus_Shutdown()
	If Not ($hOverlap < 0) Then
		$hOverlap = _Icons_Control_CheckHandle($hOverlap)
	EndIf
	$Result = _Icons_Control_SetImage($hWnd, $hBitmap, $IMAGE_BITMAP, $hOverlap)
	If $Result Then
		$hImage = _SendMessage($hWnd, $__STM_GETIMAGE, $IMAGE_BITMAP, 0)
		If (@error) Or ($hBitmap = $hImage) Then
			$hBitmap = 0
		EndIf
	EndIf
	If $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf
	Return SetError(1 - $Result, 0, $Result)
EndFunc   ;==>_SetImage
Func _Icons_Control_CheckHandle($hWnd)
	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If $hWnd = 0 Then
			Return 0
		EndIf
	EndIf
	Return $hWnd
EndFunc   ;==>_Icons_Control_CheckHandle
Func _Icons_Control_Enum($hWnd, $iDirection)
	Local $iWnd, $Count = 0, $aWnd[50] = [$hWnd]
	If $iDirection Then
		$iDirection = $GW_HWNDNEXT
	Else
		$iDirection = $GW_HWNDPREV
	EndIf
	While 1
		$iWnd = _WinAPI_GetWindow($aWnd[$Count], $iDirection)
		If Not $iWnd Then
			ExitLoop
		EndIf
		$Count += 1
		If $Count = UBound($aWnd) Then
			ReDim $aWnd[$Count + 50]
		EndIf
		$aWnd[$Count] = $iWnd
	WEnd
	ReDim $aWnd[$Count + 1]
	Return $aWnd
EndFunc   ;==>_Icons_Control_Enum
Func _Icons_Control_GetRect($hWnd)
	Local $Pos = ControlGetPos($hWnd, '', '')
	If (@error) Or ($Pos[2] = 0) Or ($Pos[3] = 0) Then
		Return 0
	EndIf
	Local $tRECT = DllStructCreate($tagRECT)
	DllStructSetData($tRECT, 1, $Pos[0])
	DllStructSetData($tRECT, 2, $Pos[1])
	DllStructSetData($tRECT, 3, $Pos[0] + $Pos[2])
	DllStructSetData($tRECT, 4, $Pos[1] + $Pos[3])
	Return $tRECT
EndFunc   ;==>_Icons_Control_GetRect
Func _Icons_Control_Invalidate($hWnd)
	Local $tRECT = _Icons_Control_GetRect($hWnd)
	If IsDllStruct($tRECT) Then
		_WinAPI_InvalidateRect(_WinAPI_GetParent($hWnd), $tRECT)
	EndIf
EndFunc   ;==>_Icons_Control_Invalidate
Func _Icons_Control_SetImage($hWnd, $hImage, $iType, $hOverlap)
	Local $Static, $Style, $tRECT, $hPrev
	Switch $iType
		Case $IMAGE_BITMAP
			$Static = $__SS_BITMAP
		Case $IMAGE_ICON
			$Static = $__SS_ICON
		Case Else
			Return 0
	EndSwitch
	$Style = _WinAPI_GetWindowLong($hWnd, $GWL_STYLE)
	If @error Then
		Return 0
	EndIf
	_WinAPI_SetWindowLong($hWnd, $GWL_STYLE, BitOR($Style, $Static))
	If @error Then
		Return 0
	EndIf
	$tRECT = _Icons_Control_GetRect($hWnd)
	$hPrev = _SendMessage($hWnd, $__STM_SETIMAGE, $iType, $hImage)
	If @error Then
		Return 0
	EndIf
	If $hPrev Then
		If $iType = $IMAGE_BITMAP Then
			_WinAPI_DeleteObject($hPrev)
		Else
			_WinAPI_DestroyIcon($hPrev)
		EndIf
	EndIf
	If (Not $hImage) And (IsDllStruct($tRECT)) Then
		_WinAPI_MoveWindow($hWnd, DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 2), DllStructGetData($tRECT, 3) - DllStructGetData($tRECT, 1), DllStructGetData($tRECT, 4) - DllStructGetData($tRECT, 2), 0)
	EndIf
	If $hOverlap Then
		If Not IsHWnd($hOverlap) Then
			$hOverlap = 0
		EndIf
		_Icons_Control_Update($hWnd, $hOverlap)
	Else
		_Icons_Control_Invalidate($hWnd)
	EndIf
	Return 1
EndFunc   ;==>_Icons_Control_SetImage
Func _Icons_Control_Update($hWnd, $hOverlap)
	Local $tBack, $tFront = _Icons_Control_GetRect($hWnd)
	If $tFront = 0 Then
		Return
	EndIf
	Local $aNext = _Icons_Control_Enum($hWnd, 1)
	Local $aPrev = _Icons_Control_Enum($hWnd, 0)
	If UBound($aPrev) = 1 Then
		_WinAPI_InvalidateRect(_WinAPI_GetParent($hWnd), $tFront)
		Return
	EndIf
	Local $aWnd[UBound($aNext) + UBound($aPrev - 1)]
	Local $tIntersect = DllStructCreate($tagRECT), $pIntersect = DllStructGetPtr($tIntersect)
	Local $iWnd, $Ret, $XOffset, $YOffset, $Count = 0, $Update = 0
	For $i = UBound($aPrev) - 1 To 1 Step -1
		$aWnd[$Count] = $aPrev[$i]
		$Count += 1
	Next
	For $i = 0 To UBound($aNext) - 1
		$aWnd[$Count] = $aNext[$i]
		$Count += 1
	Next
	For $i = 0 To $Count - 1
		If $aWnd[$i] = $hWnd Then
			_WinAPI_InvalidateRect($hWnd)
		Else
			If (Not $hOverlap) Or ($aWnd[$i] = $hOverlap) Then
				$tBack = _Icons_Control_GetRect($aWnd[$i])
				$Ret = DllCall('user32.dll', 'int', 'IntersectRect', 'ptr', $pIntersect, 'ptr', DllStructGetPtr($tFront), 'ptr', DllStructGetPtr($tBack))
				If (Not @error) And ($Ret[0]) Then
					$Ret = DllCall('user32.dll', 'int', 'IsRectEmpty', 'ptr', $pIntersect)
					If (Not @error) And (Not $Ret[0]) Then
						$XOffset = DllStructGetData($tBack, 1)
						$YOffset = DllStructGetData($tBack, 2)
						$Ret = DllCall('user32.dll', 'int', 'OffsetRect', 'ptr', $pIntersect, 'int', -$XOffset, 'int', -$YOffset)
						If (Not @error) And ($Ret[0]) Then
							_WinAPI_InvalidateRect($aWnd[$i], $tIntersect)
							$Update += 1
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Next
	If Not $Update Then
		_WinAPI_InvalidateRect(_WinAPI_GetParent($hWnd), $tFront)
	EndIf
EndFunc   ;==>_Icons_Control_Update
Global Const $BASS_SAMPLE_LOOP = 4
Global Const $BASS_UNICODE = 0x80000000
Func _VersionCompare($sVersion1, $sVersion2)
	If $sVersion1 = $sVersion2 Then Return 0
	Local $sSubVersion1 = "", $sSubVersion2 = ""
	If StringIsAlpha(StringRight($sVersion1, 1)) Then
		$sSubVersion1 = StringRight($sVersion1, 1)
		$sVersion1 = StringTrimRight($sVersion1, 1)
	EndIf
	If StringIsAlpha(StringRight($sVersion2, 1)) Then
		$sSubVersion2 = StringRight($sVersion2, 1)
		$sVersion2 = StringTrimRight($sVersion2, 1)
	EndIf
	Local $aVersion1 = StringSplit($sVersion1, ".,"), $aVersion2 = StringSplit($sVersion2, ".,")
	Local $iPartDifference = ($aVersion1[0] - $aVersion2[0])
	If $iPartDifference < 0 Then
		ReDim $aVersion1[UBound($aVersion2)]
		$aVersion1[0] = UBound($aVersion1) - 1
		For $i = (UBound($aVersion1) - Abs($iPartDifference)) To $aVersion1[0]
			$aVersion1[$i] = "0"
		Next
	ElseIf $iPartDifference > 0 Then
		ReDim $aVersion2[UBound($aVersion1)]
		$aVersion2[0] = UBound($aVersion2) - 1
		For $i = (UBound($aVersion2) - Abs($iPartDifference)) To $aVersion2[0]
			$aVersion2[$i] = "0"
		Next
	EndIf
	For $i = 1 To $aVersion1[0]
		If StringIsDigit($aVersion1[$i]) And StringIsDigit($aVersion2[$i]) Then
			If Number($aVersion1[$i]) > Number($aVersion2[$i]) Then
				Return SetExtended(2, 1)
			ElseIf Number($aVersion1[$i]) < Number($aVersion2[$i]) Then
				Return SetExtended(2, -1)
			ElseIf $i = $aVersion1[0] Then
				If $sSubVersion1 > $sSubVersion2 Then
					Return SetExtended(3, 1)
				ElseIf $sSubVersion1 < $sSubVersion2 Then
					Return SetExtended(3, -1)
				EndIf
			EndIf
		Else
			If $aVersion1[$i] > $aVersion2[$i] Then
				Return SetExtended(1, 1)
			ElseIf $aVersion1[$i] < $aVersion2[$i] Then
				Return SetExtended(1, -1)
			EndIf
		EndIf
	Next
	Return SetExtended(Abs($iPartDifference), 0)
EndFunc   ;==>_VersionCompare
Global $_ghBassDll = -1
Global $_gbBASSULONGLONGFIXED = _VersionCompare(@AutoItVersion, "3.3.0.0") = 1
Global $BASS_DLL_UDF_VER = "2.4.5.0"
Global $BASS_ERR_DLL_NO_EXIST = -1
Global $BASS_STARTUP_BYPASS_VERSIONCHECK = 0
Func _BASS_Startup($sBassDLL = "bass.dll")
	If $_ghBassDll <> -1 Then Return True
	If Not FileExists($sBassDLL) Then Return SetError($BASS_ERR_DLL_NO_EXIST, 0, False)
	If $BASS_STARTUP_BYPASS_VERSIONCHECK Then
		If _VersionCompare(FileGetVersion($sBassDLL), $BASS_DLL_UDF_VER) = -1 Then
			MsgBox(0, "ERROR", "This version of BASS.au3 is made for Bass.dll V" & $BASS_DLL_UDF_VER & ".  Please update")
			Exit
		EndIf
	EndIf
	$_ghBassDll = DllOpen($sBassDLL)
	Return $_ghBassDll <> -1
EndFunc   ;==>_BASS_Startup
Func _BASS_ErrorGetCode()
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_ErrorGetCode")
	If @error Then Return SetError(1, 0, -1)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_ErrorGetCode
Func _BASS_Init($flags, $device = -1, $freq = 44100, $win = 0, $clsid = "")
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_Init", "int", $device, "dword", $freq, "dword", $flags, "hwnd", $win, "hwnd", $clsid)
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_Init
Func _BASS_Free()
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_Free")
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_Free
Func _BASS_Stop()
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_Stop")
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_Stop
Func _BASS_StreamCreateFile($mem, $file, $offset, $length, $flags)
	Local $tpFile = "ptr"
	If IsString($file) Then $tpFile = "wstr"
	Local $BASS_ret_ = DllCall($_ghBassDll, "dword", "BASS_StreamCreateFile", "int", $mem, $tpFile, $file, "uint64", $offset, "uint64", $length, "DWORD", BitOR($flags, $BASS_UNICODE))
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_StreamCreateFile
Func _BASS_StreamFree($handle)
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_StreamFree", "dword", $handle)
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_StreamFree
Func _BASS_ChannelPlay($handle, $restart)
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_ChannelPlay", "DWORD", $handle, "int", $restart)
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_ChannelPlay
Func _BASS_ChannelPause($handle)
	Local $BASS_ret_ = DllCall($_ghBassDll, "int", "BASS_ChannelPause", "DWORD", $handle)
	If @error Then Return SetError(1, 1, 0)
	If $BASS_ret_[0] = 0 Then Return SetError(_BASS_ErrorGetCode(), 0, 0)
	Return $BASS_ret_[0]
EndFunc   ;==>_BASS_ChannelPause
Global Const $tagMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _MemFree(ByRef $tMemMap)
	Local $pMemory = DllStructGetData($tMemMap, "Mem")
	Local $hProcess = DllStructGetData($tMemMap, "hProc")
	Local $bResult = _MemVirtualFreeEx($hProcess, $pMemory, 0, $MEM_RELEASE)
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hProcess)
	If @error Then Return SetError(@error, @extended, False)
	Return $bResult
EndFunc   ;==>_MemFree
Func _MemInit($hWnd, $iSize, ByRef $tMemMap)
	Local $aCall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hWnd, "dword*", 0)
	If @error Then Return SetError(@error + 10, @extended, 0)
	Local $iProcessID = $aCall[2]
	If $iProcessID = 0 Then Return SetError(1, 0, 0)
	Local $iAccess = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
	Local $hProcess = __Mem_OpenProcess($iAccess, False, $iProcessID, True)
	Local $iAlloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
	Local $pMemory = _MemVirtualAllocEx($hProcess, 0, $iSize, $iAlloc, $PAGE_READWRITE)
	If $pMemory = 0 Then Return SetError(2, 0, 0)
	$tMemMap = DllStructCreate($tagMEMMAP)
	DllStructSetData($tMemMap, "hProc", $hProcess)
	DllStructSetData($tMemMap, "Size", $iSize)
	DllStructSetData($tMemMap, "Mem", $pMemory)
	Return $pMemory
EndFunc   ;==>_MemInit
Func _MemRead(ByRef $tMemMap, $pSrce, $pDest, $iSize)
	Local $aCall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), "ptr", $pSrce, "struct*", $pDest, "ulong_ptr", $iSize, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_MemRead
Func _MemWrite(ByRef $tMemMap, $pSrce, $pDest = 0, $iSize = 0, $sSrce = "struct*")
	If $pDest = 0 Then $pDest = DllStructGetData($tMemMap, "Mem")
	If $iSize = 0 Then $iSize = DllStructGetData($tMemMap, "Size")
	Local $aCall = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($tMemMap, "hProc"), "ptr", $pDest, $sSrce, $pSrce, "ulong_ptr", $iSize, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_MemWrite
Func _MemVirtualAllocEx($hProcess, $pAddress, $iSize, $iAllocation, $iProtect)
	Local $aCall = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iAllocation, "dword", $iProtect)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_MemVirtualAllocEx
Func _MemVirtualFreeEx($hProcess, $pAddress, $iSize, $iFreeType)
	Local $aCall = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hProcess, "ptr", $pAddress, "ulong_ptr", $iSize, "dword", $iFreeType)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0]
EndFunc   ;==>_MemVirtualFreeEx
Func __Mem_OpenProcess($iAccess, $bInherit, $iPID, $bDebugPriv = False)
	Local $aCall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $bInherit, "dword", $iPID)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return $aCall[0]
	If Not $bDebugPriv Then Return SetError(100, 0, 0)
	Local $hToken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then Return SetError(@error + 10, @extended, 0)
	_Security__SetPrivilege($hToken, $SE_DEBUG_NAME, True)
	Local $iError = @error
	Local $iExtended = @extended
	Local $iRet = 0
	If Not @error Then
		$aCall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iAccess, "bool", $bInherit, "dword", $iPID)
		$iError = @error
		$iExtended = @extended
		If $aCall[0] Then $iRet = $aCall[0]
		_Security__SetPrivilege($hToken, $SE_DEBUG_NAME, False)
		If @error Then
			$iError = @error + 20
			$iExtended = @extended
		EndIf
	Else
		$iError = @error + 30
	EndIf
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hToken)
	Return SetError($iError, $iExtended, $iRet)
EndFunc   ;==>__Mem_OpenProcess
Global $__g_hGUICtrl_LastWnd
Func __GUICtrl_SendMsg($hWnd, $iMsg, $iIndex, ByRef $tItem, $tBuffer = 0, $bRetItem = False, $iElement = -1, $bRetBuffer = False, $iElementMax = $iElement)
	If $iElement > 0 Then
		DllStructSetData($tItem, $iElement, DllStructGetPtr($tBuffer))
		If $iElement = $iElementMax Then DllStructSetData($tItem, $iElement + 1, DllStructGetSize($tBuffer))
	EndIf
	Local $iRet
	If IsHWnd($hWnd) Then
		If _WinAPI_InProcess($hWnd, $__g_hGUICtrl_LastWnd) Then
			$iRet = DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, "wparam", $iIndex, "struct*", $tItem)[0]
		Else
			Local $iItem = DllStructGetSize($tItem)
			Local $tMemMap, $pText
			Local $iBuffer = 0
			If ($iElement > 0) Or ($iElementMax = 0) Then $iBuffer = DllStructGetSize($tBuffer)
			Local $pMemory = _MemInit($hWnd, $iItem + $iBuffer, $tMemMap)
			If $iBuffer Then
				$pText = $pMemory + $iItem
				If $iElementMax Then
					DllStructSetData($tItem, $iElement, $pText)
				Else
					$iIndex = $pText
				EndIf
				_MemWrite($tMemMap, $tBuffer, $pText, $iBuffer)
			EndIf
			_MemWrite($tMemMap, $tItem, $pMemory, $iItem)
			$iRet = DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, "wparam", $iIndex, "ptr", $pMemory)[0]
			If $iBuffer And $bRetBuffer Then _MemRead($tMemMap, $pText, $tBuffer, $iBuffer)
			If $bRetItem Then _MemRead($tMemMap, $pMemory, $tItem, $iItem)
			_MemFree($tMemMap)
		EndIf
	Else
		$iRet = GUICtrlSendMsg($hWnd, $iMsg, $iIndex, DllStructGetPtr($tItem))
	EndIf
	Return $iRet
EndFunc   ;==>__GUICtrl_SendMsg
Global Const $ILC_MASK = 0x00000001
Global Const $ILC_COLOR = 0x00000000
Global Const $ILC_COLORDDB = 0x000000FE
Global Const $ILC_COLOR4 = 0x00000004
Global Const $ILC_COLOR8 = 0x00000008
Global Const $ILC_COLOR16 = 0x00000010
Global Const $ILC_COLOR24 = 0x00000018
Global Const $ILC_COLOR32 = 0x00000020
Global Const $ILC_MIRROR = 0x00002000
Global Const $ILC_PERITEMMIRROR = 0x00008000
Global Const $ILCF_SWAP = 0x1
Func _GUIImageList_AddIcon($hWnd, $sFilePath, $iIndex = 0, $bLarge = False)
	Local $iRet, $tIcon = DllStructCreate("handle Handle")
	If $bLarge Then
		$iRet = _WinAPI_ExtractIconEx($sFilePath, $iIndex, $tIcon, 0, 1)
	Else
		$iRet = _WinAPI_ExtractIconEx($sFilePath, $iIndex, 0, $tIcon, 1)
	EndIf
	If $iRet <= 0 Then Return SetError(-1, $iRet, -1)
	Local $hIcon = DllStructGetData($tIcon, "Handle")
	$iRet = _GUIImageList_ReplaceIcon($hWnd, -1, $hIcon)
	_WinAPI_DestroyIcon($hIcon)
	If $iRet = -1 Then Return SetError(-2, $iRet, -1)
	Return $iRet
EndFunc   ;==>_GUIImageList_AddIcon
Func _GUIImageList_Create($iCX = 16, $iCY = 16, $iColor = 4, $iOptions = 0, $iInitial = 4, $iGrow = 4)
	Local Const $aColor[7] = [$ILC_COLOR, $ILC_COLOR4, $ILC_COLOR8, $ILC_COLOR16, $ILC_COLOR24, $ILC_COLOR32, $ILC_COLORDDB]
	Local $iFlags = 0
	If BitAND($iOptions, 1) <> 0 Then $iFlags = BitOR($iFlags, $ILC_MASK)
	If BitAND($iOptions, 2) <> 0 Then $iFlags = BitOR($iFlags, $ILC_MIRROR)
	If BitAND($iOptions, 4) <> 0 Then $iFlags = BitOR($iFlags, $ILC_PERITEMMIRROR)
	$iFlags = BitOR($iFlags, $aColor[$iColor])
	Local $aCall = DllCall("comctl32.dll", "handle", "ImageList_Create", "int", $iCX, "int", $iCY, "uint", $iFlags, "int", $iInitial, "int", $iGrow)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_GUIImageList_Create
Func _GUIImageList_Destroy($hWnd)
	Local $aCall = DllCall("comctl32.dll", "bool", "ImageList_Destroy", "handle", $hWnd)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0] <> 0
EndFunc   ;==>_GUIImageList_Destroy
Func _GUIImageList_GetImageCount($hWnd)
	Local $aCall = DllCall("comctl32.dll", "int", "ImageList_GetImageCount", "handle", $hWnd)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aCall[0]
EndFunc   ;==>_GUIImageList_GetImageCount
Func _GUIImageList_ReplaceIcon($hWnd, $iIndex, $hIcon)
	Local $aCall = DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", "handle", $hWnd, "int", $iIndex, "handle", $hIcon)
	If @error Then Return SetError(@error, @extended, -1)
	Return $aCall[0]
EndFunc   ;==>_GUIImageList_ReplaceIcon
Func _GUIImageList_Swap($hWnd, $iSource, $iDestination)
	Local $aCall = DllCall("comctl32.dll", "bool", "ImageList_Copy", "handle", $hWnd, "int", $iDestination, "handle", $hWnd, "int", $iSource, "uint", $ILCF_SWAP)
	If @error Then Return SetError(@error, @extended, False)
	Return $aCall[0] <> 0
EndFunc   ;==>_GUIImageList_Swap
Global Const $TVS_HASBUTTONS = 0x00000001
Global Const $TVS_HASLINES = 0x00000002
Global Const $TVS_LINESATROOT = 0x00000004
Global Const $TVS_DISABLEDRAGDROP = 0x00000010
Global Const $TVS_NOTOOLTIPS = 0x00000080
Global Const $TVS_NOHSCROLL = 0x00008000
Global Const $TVGN_ROOT = 0x00000000
Global Const $TVGN_NEXT = 0x00000001
Global Const $TVGN_PREVIOUS = 0x00000002
Global Const $TVGN_PARENT = 0x00000003
Global Const $TVGN_CHILD = 0x00000004
Global Const $TVGN_FIRSTVISIBLE = 0x00000005
Global Const $TVGN_CARET = 0x00000009
Global Const $TVI_ROOT = 0xFFFF0000
Global Const $TVI_FIRST = 0xFFFF0001
Global Const $TVI_LAST = 0xFFFF0002
Global Const $TVIF_TEXT = 0x00000001
Global Const $TVIF_IMAGE = 0x00000002
Global Const $TVIF_PARAM = 0x00000004
Global Const $TVIF_STATE = 0x00000008
Global Const $TVIF_HANDLE = 0x00000010
Global Const $TVIF_SELECTEDIMAGE = 0x00000020
Global Const $TVSIL_STATE = 2
Global Const $TVIS_SELECTED = 0x00000002
Global Const $TVIS_EXPANDED = 0x00000020
Global Const $TVIS_STATEIMAGEMASK = 0x0000F000
Global Const $TVNA_ADD = 1
Global Const $TVNA_ADDFIRST = 2
Global Const $TVNA_ADDCHILD = 3
Global Const $TVNA_ADDCHILDFIRST = 4
Global Const $TVTA_ADDFIRST = 1
Global Const $TVTA_ADD = 2
Global Const $TVTA_INSERT = 3
Global Const $TV_FIRST = 0x1100
Global Const $TVM_INSERTITEMA = $TV_FIRST + 0
Global Const $TVM_DELETEITEM = $TV_FIRST + 1
Global Const $TVM_GETCOUNT = $TV_FIRST + 5
Global Const $TVM_SETIMAGELIST = $TV_FIRST + 9
Global Const $TVM_GETNEXTITEM = $TV_FIRST + 10
Global Const $TVM_GETITEMA = $TV_FIRST + 12
Global Const $TVM_SETITEMA = $TV_FIRST + 13
Global Const $TVM_GETVISIBLECOUNT = $TV_FIRST + 16
Global Const $TVM_HITTEST = $TV_FIRST + 17
Global Const $TVM_ENSUREVISIBLE = $TV_FIRST + 20
Global Const $TVM_ENDEDITLABELNOW = $TV_FIRST + 22
Global Const $TVM_GETITEMHEIGHT = $TV_FIRST + 28
Global Const $TVM_INSERTITEMW = $TV_FIRST + 50
Global Const $TVM_GETITEMW = $TV_FIRST + 62
Global Const $TVM_SETITEMW = $TV_FIRST + 63
Global Const $TVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $TVN_FIRST = -400
Global Const $TVN_SELCHANGEDA = $TVN_FIRST - 2
Global Const $TVN_DELETEITEMA = $TVN_FIRST - 9
Global Const $TVN_ENDLABELEDITA = $TVN_FIRST - 11
Global Const $TVN_KEYDOWN = $TVN_FIRST - 12
Global Const $TVN_SELCHANGEDW = $TVN_FIRST - 51
Global Const $TVN_DELETEITEMW = $TVN_FIRST - 58
Global Const $TVN_ENDLABELEDITW = $TVN_FIRST - 60
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global $__g_aUDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1]
Func __UDF_FreeGlobalID($hWnd, $iGlobalID)
	If $iGlobalID - $_UDF_STARTID < 0 Or $iGlobalID - $_UDF_STARTID > $_UDF_GlobalID_MAX_IDS Then Return SetError(-1, 0, False)
	For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
		If $__g_aUDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
			For $x = $_UDF_GlobalIDs_OFFSET To UBound($__g_aUDF_GlobalIDs_Used, $UBOUND_COLUMNS) - 1
				If $__g_aUDF_GlobalIDs_Used[$iIndex][$x] = $iGlobalID Then
					$__g_aUDF_GlobalIDs_Used[$iIndex][$x] = 0
					Return True
				EndIf
			Next
			Return SetError(-3, 0, False)
		EndIf
	Next
	Return SetError(-2, 0, False)
EndFunc   ;==>__UDF_FreeGlobalID
Global $__g_tTVBuffer, $__g_tTVBufferANSI
Global $__g_tTVItemEx = DllStructCreate($tagTVITEMEX)
Global Const $__TREEVIEWCONSTANT_WM_SETREDRAW = 0x000B
Global Const $tagTVINSERTSTRUCT = "struct; handle Parent;handle InsertAfter;" & $tagTVITEMEX & " ;endstruct"
Func _GUICtrlTreeView_AddChild($hWnd, $hParent, $sText, $iImage = -1, $iSelImage = -1)
	Return __GUICtrlTreeView_AddItem($hWnd, $hParent, $sText, $TVNA_ADDCHILD, $iImage, $iSelImage)
EndFunc   ;==>_GUICtrlTreeView_AddChild
Func __GUICtrlTreeView_AddItem($hWnd, $hRelative, $sText, $iMethod, $iImage = -1, $iSelImage = -1, $iParam = 0)
	Local $iAddMode
	Switch $iMethod
		Case $TVNA_ADD, $TVNA_ADDCHILD
			$iAddMode = $TVTA_ADD
		Case $TVNA_ADDFIRST, $TVNA_ADDCHILDFIRST
			$iAddMode = $TVTA_ADDFIRST
		Case Else
			$iAddMode = $TVTA_INSERT
	EndSwitch
	Local $hItem, $hItemID = 0
	If $hRelative <> 0x00000000 Then
		Switch $iMethod
			Case $TVNA_ADD, $TVNA_ADDFIRST
				$hItem = _GUICtrlTreeView_GetParentHandle($hWnd, $hRelative)
			Case $TVNA_ADDCHILD, $TVNA_ADDCHILDFIRST
				$hItem = $hRelative
			Case Else
				$hItem = _GUICtrlTreeView_GetParentHandle($hWnd, $hRelative)
				$hItemID = _GUICtrlTreeView_GetPrevSibling($hWnd, $hRelative)
				If $hItemID = 0x00000000 Then $iAddMode = $TVTA_ADDFIRST
		EndSwitch
	EndIf
	Local $tBuffer, $iMsg
	If _GUICtrlTreeView_GetUnicodeFormat($hWnd) Then
		$tBuffer = $__g_tTVBuffer
		$iMsg = $TVM_INSERTITEMW
	Else
		$tBuffer = $__g_tTVBufferANSI
		$iMsg = $TVM_INSERTITEMA
	EndIf
	Local $tInsert = DllStructCreate($tagTVINSERTSTRUCT)
	Switch $iAddMode
		Case $TVTA_ADDFIRST
			DllStructSetData($tInsert, "InsertAfter", $TVI_FIRST)
		Case $TVTA_ADD
			DllStructSetData($tInsert, "InsertAfter", $TVI_LAST)
		Case $TVTA_INSERT
			DllStructSetData($tInsert, "InsertAfter", $hItemID)
	EndSwitch
	Local $iMask = BitOR($TVIF_TEXT, $TVIF_PARAM)
	If $iImage >= 0 Then $iMask = BitOR($iMask, $TVIF_IMAGE)
	If $iSelImage >= 0 Then $iMask = BitOR($iMask, $TVIF_SELECTEDIMAGE)
	DllStructSetData($tBuffer, "Text", $sText)
	DllStructSetData($tInsert, "Parent", $hItem)
	DllStructSetData($tInsert, "Mask", $iMask)
	DllStructSetData($tInsert, "Image", $iImage)
	DllStructSetData($tInsert, "SelectedImage", $iSelImage)
	DllStructSetData($tInsert, "Param", $iParam)
	Local $hResult = Ptr(__GUICtrl_SendMsg($hWnd, $iMsg, 0, $tInsert, $tBuffer, False, 7))
	Return $hResult
EndFunc   ;==>__GUICtrlTreeView_AddItem
Func _GUICtrlTreeView_BeginUpdate($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $__TREEVIEWCONSTANT_WM_SETREDRAW, False) = 0
EndFunc   ;==>_GUICtrlTreeView_BeginUpdate
Func _GUICtrlTreeView_DeleteAll($hWnd)
	Local $iCount = 0
	If IsHWnd($hWnd) Then
		_SendMessage($hWnd, $TVM_DELETEITEM, 0, $TVI_ROOT)
		$iCount = _GUICtrlTreeView_GetCount($hWnd)
		If $iCount Then Return GUICtrlSendMsg($hWnd, $TVM_DELETEITEM, 0, $TVI_ROOT) <> 0
		Return True
	Else
		GUICtrlSendMsg($hWnd, $TVM_DELETEITEM, 0, $TVI_ROOT)
		$iCount = _GUICtrlTreeView_GetCount($hWnd)
		If $iCount Then Return _SendMessage($hWnd, $TVM_DELETEITEM, 0, $TVI_ROOT) <> 0
		Return True
	EndIf
EndFunc   ;==>_GUICtrlTreeView_DeleteAll
Func _GUICtrlTreeView_Destroy(ByRef $hWnd)
	Local $iDestroyed = 0
	If IsHWnd($hWnd) Then
		If _WinAPI_InProcess($hWnd, $__g_hGUICtrl_LastWnd) Then
			Local $nCtrlID = _WinAPI_GetDlgCtrlID($hWnd)
			Local $hParent = _WinAPI_GetParent($hWnd)
			$iDestroyed = _WinAPI_DestroyWindow($hWnd)
			Local $iRet = __UDF_FreeGlobalID($hParent, $nCtrlID)
			If Not $iRet Then
			EndIf
		Else
			Return SetError(1, 0, False)
		EndIf
	Else
		$iDestroyed = GUICtrlDelete($hWnd)
	EndIf
	If $iDestroyed Then $hWnd = 0
	Return $iDestroyed <> 0
EndFunc   ;==>_GUICtrlTreeView_Destroy
Func _GUICtrlTreeView_EndEdit($hWnd, $bCancel = False)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_ENDEDITLABELNOW, $bCancel) <> 0
EndFunc   ;==>_GUICtrlTreeView_EndEdit
Func _GUICtrlTreeView_EndUpdate($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $__TREEVIEWCONSTANT_WM_SETREDRAW, True) = 0
EndFunc   ;==>_GUICtrlTreeView_EndUpdate
Func _GUICtrlTreeView_EnsureVisible($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_ENSUREVISIBLE, 0, $hItem, 0, "wparam", "handle") <> 0
EndFunc   ;==>_GUICtrlTreeView_EnsureVisible
Func _GUICtrlTreeView_GetCount($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETCOUNT)
EndFunc   ;==>_GUICtrlTreeView_GetCount
Func _GUICtrlTreeView_GetFirstChild($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CHILD, $hItem, 0, "wparam", "handle", "handle")
EndFunc   ;==>_GUICtrlTreeView_GetFirstChild
Func _GUICtrlTreeView_GetFirstItem($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_ROOT, 0, 0, "wparam", "lparam", "handle")
EndFunc   ;==>_GUICtrlTreeView_GetFirstItem
Func _GUICtrlTreeView_GetFirstVisible($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_FIRSTVISIBLE, 0, 0, "wparam", "lparam", "handle")
EndFunc   ;==>_GUICtrlTreeView_GetFirstVisible
Func _GUICtrlTreeView_GetHeight($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETITEMHEIGHT)
EndFunc   ;==>_GUICtrlTreeView_GetHeight
Func _GUICtrlTreeView_GetItemHandle($hWnd, $hItem = Null)
	If IsHWnd($hWnd) Then
		If $hItem = Null Then $hItem = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_ROOT, 0, 0, "wparam", "lparam", "handle")
	Else
		If $hItem = Null Then
			$hItem = Ptr(GUICtrlSendMsg($hWnd, $TVM_GETNEXTITEM, $TVGN_ROOT, 0))
		Else
			Local $hTempItem = GUICtrlGetHandle($hItem)
			If $hTempItem And Not IsPtr($hItem) Then
				$hItem = $hTempItem
			Else
				SetExtended(1)
			EndIf
		EndIf
	EndIf
	Return $hItem
EndFunc   ;==>_GUICtrlTreeView_GetItemHandle
Func _GUICtrlTreeView_GetItemParam($hWnd, $hItem = Null)
	Local $tItem = $__g_tTVItemEx
	DllStructSetData($tItem, "Mask", $TVIF_PARAM)
	DllStructSetData($tItem, "Param", 0)
	Local $iMsg
	If _GUICtrlTreeView_GetUnicodeFormat($hWnd) Then
		$iMsg = $TVM_GETITEMW
	Else
		$iMsg = $TVM_GETITEMA
	EndIf
	If IsHWnd($hWnd) Then
		If $hItem = Null Then $hItem = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CARET, 0, 0, "wparam", "lparam", "handle")
		If $hItem = 0x00000000 Then Return 0
		DllStructSetData($tItem, "hItem", $hItem)
		If _SendMessage($hWnd, $iMsg, 0, $tItem, 0, "wparam", "struct*") = 0 Then Return 0
	Else
		If $hItem = Null Then
			$hItem = Ptr(GUICtrlSendMsg($hWnd, $TVM_GETNEXTITEM, $TVGN_CARET, 0))
		Else
			Local $hTempItem = GUICtrlGetHandle($hItem)
			If $hTempItem And Not IsPtr($hItem) Then
				$hItem = $hTempItem
			Else
				SetExtended(1)
			EndIf
		EndIf
		If $hItem = 0x00000000 Then Return 0
		DllStructSetData($tItem, "hItem", $hItem)
		If GUICtrlSendMsg($hWnd, $iMsg, 0, DllStructGetPtr($tItem)) = 0 Then Return 0
	EndIf
	Return DllStructGetData($tItem, "Param")
EndFunc   ;==>_GUICtrlTreeView_GetItemParam
Func _GUICtrlTreeView_GetLastChild($hWnd, $hItem)
	Local $hResult = _GUICtrlTreeView_GetFirstChild($hWnd, $hItem)
	If $hResult <> 0x00000000 Then
		Local $hNext = $hResult
		Do
			$hResult = $hNext
			$hNext = _GUICtrlTreeView_GetNextSibling($hWnd, $hNext)
		Until $hNext = 0x00000000
	EndIf
	Return $hResult
EndFunc   ;==>_GUICtrlTreeView_GetLastChild
Func _GUICtrlTreeView_GetNext($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	Local $hResult = 0
	If $hItem <> 0x00000000 Then
		Local $hNext = _GUICtrlTreeView_GetFirstChild($hWnd, $hItem)
		If $hNext = 0x00000000 Then
			$hNext = _GUICtrlTreeView_GetNextSibling($hWnd, $hItem)
		EndIf
		Local $hParent = $hItem
		While ($hNext = 0x00000000) And ($hParent <> 0x00000000)
			$hParent = _GUICtrlTreeView_GetParentHandle($hWnd, $hParent)
			If $hParent = 0x00000000 Then
				$hNext = Ptr(0)
				ExitLoop
			EndIf
			$hNext = _GUICtrlTreeView_GetNextSibling($hWnd, $hParent)
		WEnd
		$hResult = $hNext
	EndIf
	Return $hResult
EndFunc   ;==>_GUICtrlTreeView_GetNext
Func _GUICtrlTreeView_GetNextChild($hWnd, $hItem)
	Return _GUICtrlTreeView_GetNextSibling($hWnd, $hItem)
EndFunc   ;==>_GUICtrlTreeView_GetNextChild
Func _GUICtrlTreeView_GetNextSibling($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_NEXT, $hItem, 0, "wparam", "handle", "handle")
EndFunc   ;==>_GUICtrlTreeView_GetNextSibling
Func _GUICtrlTreeView_GetParentHandle($hWnd, $hItem = Null)
	If $hItem = Null Then
		If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
		$hItem = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_CARET, 0, 0, "wparam", "handle", "handle")
		If $hItem = 0x00000000 Then Return 0
	Else
		If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
		If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	EndIf
	Local $hParent = _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_PARENT, $hItem, 0, "wparam", "handle", "handle")
	Return $hParent
EndFunc   ;==>_GUICtrlTreeView_GetParentHandle
Func _GUICtrlTreeView_GetPrev($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	Local $hResult = _GUICtrlTreeView_GetPrevChild($hWnd, $hItem)
	If $hResult <> 0x00000000 Then
		Local $hPrev = $hResult
		Do
			$hResult = $hPrev
			$hPrev = _GUICtrlTreeView_GetLastChild($hWnd, $hPrev)
		Until $hPrev = 0x00000000
	Else
		$hResult = _GUICtrlTreeView_GetParentHandle($hWnd, $hItem)
	EndIf
	Return $hResult
EndFunc   ;==>_GUICtrlTreeView_GetPrev
Func _GUICtrlTreeView_GetPrevChild($hWnd, $hItem)
	Return _GUICtrlTreeView_GetPrevSibling($hWnd, $hItem)
EndFunc   ;==>_GUICtrlTreeView_GetPrevChild
Func _GUICtrlTreeView_GetPrevSibling($hWnd, $hItem)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETNEXTITEM, $TVGN_PREVIOUS, $hItem, 0, "wparam", "handle", "handle")
EndFunc   ;==>_GUICtrlTreeView_GetPrevSibling
Func _GUICtrlTreeView_GetText($hWnd, $hItem = Null)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	Local $tItem = $__g_tTVItemEx
	Local $tText, $iMsg
	Local $bUnicode = _GUICtrlTreeView_GetUnicodeFormat($hWnd)
	If $bUnicode Then
		$tText = $__g_tTVBuffer
		$iMsg = $TVM_GETITEMW
	Else
		$tText = $__g_tTVBufferANSI
		$iMsg = $TVM_GETITEMA
	EndIf
	DllStructSetData($tText, 1, "")
	DllStructSetData($tItem, "Mask", $TVIF_TEXT)
	DllStructSetData($tItem, "hItem", $hItem)
	__GUICtrl_SendMsg($hWnd, $iMsg, 0, $tItem, $tText, False, 5, True)
	Return DllStructGetData($tText, 1)
EndFunc   ;==>_GUICtrlTreeView_GetText
Func _GUICtrlTreeView_GetUnicodeFormat($hWnd)
	If Not IsDllStruct($__g_tTVBuffer) Then
		$__g_tTVBuffer = DllStructCreate("wchar Text[4096]")
		$__g_tTVBufferANSI = DllStructCreate("char Text[4096]", DllStructGetPtr($__g_tTVBuffer))
	EndIf
	If IsHWnd($hWnd) Then
		Return _SendMessage($hWnd, $TVM_GETUNICODEFORMAT) <> 0
	Else
		Return GUICtrlSendMsg($hWnd, $TVM_GETUNICODEFORMAT, 0, 0) <> 0
	EndIf
EndFunc   ;==>_GUICtrlTreeView_GetUnicodeFormat
Func _GUICtrlTreeView_GetVisibleCount($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_GETVISIBLECOUNT)
EndFunc   ;==>_GUICtrlTreeView_GetVisibleCount
Func _GUICtrlTreeView_HitTestEx($hWnd, $iX, $iY)
	Local $tHitTest = DllStructCreate($tagTVHITTESTINFO)
	DllStructSetData($tHitTest, "X", $iX)
	DllStructSetData($tHitTest, "Y", $iY)
	__GUICtrl_SendMsg($hWnd, $TVM_HITTEST, 0, $tHitTest, 0, True)
	Return $tHitTest
EndFunc   ;==>_GUICtrlTreeView_HitTestEx
Func _GUICtrlTreeView_HitTestItem($hWnd, $iX, $iY)
	Local $tHitTest = _GUICtrlTreeView_HitTestEx($hWnd, $iX, $iY)
	Return DllStructGetData($tHitTest, "Item")
EndFunc   ;==>_GUICtrlTreeView_HitTestItem
Func _GUICtrlTreeView_Level($hWnd, $hItem)
	Local $iRet = 0
	Local $hNext = _GUICtrlTreeView_GetParentHandle($hWnd, $hItem)
	While $hNext <> 0x00000000
		$iRet += 1
		$hNext = _GUICtrlTreeView_GetParentHandle($hWnd, $hNext)
	WEnd
	Return $iRet
EndFunc   ;==>_GUICtrlTreeView_Level
Func __GUICtrlTreeView_SetItem($hWnd, ByRef $tItem)
	Local $iMsg
	If _GUICtrlTreeView_GetUnicodeFormat($hWnd) Then
		$iMsg = $TVM_SETITEMW
	Else
		$iMsg = $TVM_SETITEMA
	EndIf
	Local $iRet = __GUICtrl_SendMsg($hWnd, $iMsg, 0, $tItem)
	Return $iRet <> 0
EndFunc   ;==>__GUICtrlTreeView_SetItem
Func _GUICtrlTreeView_SetItemParam($hWnd, $hItem, $iParam)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	Local $tItem = $__g_tTVItemEx
	DllStructSetData($tItem, "Mask", BitOR($TVIF_HANDLE, $TVIF_PARAM))
	DllStructSetData($tItem, "hItem", $hItem)
	DllStructSetData($tItem, "Param", $iParam)
	Local $bResult = __GUICtrlTreeView_SetItem($hWnd, $tItem)
	Return $bResult
EndFunc   ;==>_GUICtrlTreeView_SetItemParam
Func _GUICtrlTreeView_SetSelected($hWnd, $hItem, $bFlag = True)
	Return _GUICtrlTreeView_SetState($hWnd, $hItem, $TVIS_SELECTED, $bFlag)
EndFunc   ;==>_GUICtrlTreeView_SetSelected
Func _GUICtrlTreeView_SetState($hWnd, $hItem, $iState = 0, $bSetState = True)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	Local $tItem = $__g_tTVItemEx
	DllStructSetData($tItem, "Mask", $TVIF_STATE)
	DllStructSetData($tItem, "hItem", $hItem)
	If $bSetState Then
		DllStructSetData($tItem, "State", $iState)
	Else
		DllStructSetData($tItem, "State", BitAND($bSetState, $iState))
	EndIf
	DllStructSetData($tItem, "StateMask", $iState)
	If $bSetState Then DllStructSetData($tItem, "StateMask", BitOR($bSetState, $iState))
	Return __GUICtrlTreeView_SetItem($hWnd, $tItem)
EndFunc   ;==>_GUICtrlTreeView_SetState
Func _GUICtrlTreeView_SetStateImageIndex($hWnd, $hItem, $iIndex)
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If $iIndex < 0 Then
		Return SetError(1, 0, False)
	EndIf
	Local $tItem = $__g_tTVItemEx
	DllStructSetData($tItem, "Mask", $TVIF_STATE)
	DllStructSetData($tItem, "hItem", $hItem)
	DllStructSetData($tItem, "State", BitShift($iIndex, -12))
	DllStructSetData($tItem, "StateMask", $TVIS_STATEIMAGEMASK)
	Return __GUICtrlTreeView_SetItem($hWnd, $tItem)
EndFunc   ;==>_GUICtrlTreeView_SetStateImageIndex
Func _GUICtrlTreeView_SetStateImageList($hWnd, $hImageList)
	_GUIImageList_AddIcon($hImageList, "shell32.dll", 0)
	Local $iCount = _GUIImageList_GetImageCount($hImageList)
	For $x = $iCount - 1 To 1 Step -1
		_GUIImageList_Swap($hImageList, $x, $x - 1)
	Next
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Return _SendMessage($hWnd, $TVM_SETIMAGELIST, $TVSIL_STATE, $hImageList, 0, "wparam", "handle", "handle")
EndFunc   ;==>_GUICtrlTreeView_SetStateImageList
Func _GUICtrlTreeView_SetText($hWnd, $hItem = Null, $sText = "")
	If Not IsHWnd($hItem) Then $hItem = _GUICtrlTreeView_GetItemHandle($hWnd, $hItem)
	If @error Or $sText = "" Then Return SetError(@error + 10, 0, False)
	Local $tItem = $__g_tTVItemEx
	Local $tBuffer, $iMsg
	If _GUICtrlTreeView_GetUnicodeFormat($hWnd) Then
		$tBuffer = $__g_tTVBuffer
		$iMsg = $TVM_SETITEMW
	Else
		$tBuffer = $__g_tTVBufferANSI
		$iMsg = $TVM_SETITEMA
	EndIf
	DllStructSetData($tBuffer, "Text", $sText)
	DllStructSetData($tItem, "Mask", BitOR($TVIF_HANDLE, $TVIF_TEXT))
	DllStructSetData($tItem, "hItem", $hItem)
	Local $bResult = __GUICtrl_SendMsg($hWnd, $iMsg, 0, $tItem, $tBuffer, False, 5)
	Return $bResult <> 0
EndFunc   ;==>_GUICtrlTreeView_SetText
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_HIDE = 32

;~ ----------------------_GUITreeViewEx----------
Global $g_GTVEx_aTVData = 0 ; Дескриптор TreeView
Global $hModificationItemTV = 0 ; Дескриптор текущего выбранного пункта
Global $UnchkUp = 0, $fItemDelTV = 0
Global $MnTVs = 0, $sNewTxtItemTV = 0, $nNewTxtItemTV = 0, $nFlagKeyDn = 0, $nFlagSelect = 0
Global $oSNTV, $oSNTVEX
$oSNTV = ObjCreate('Scripting.Dictionary')
If @error Then
	MsgBox(16, '1', 'Сreation error Scripting.Dictionary')
Else
	$oSNTV.CompareMode = 1
EndIf

$oSNTVEX = ObjCreate('Scripting.Dictionary')
If @error Then
	MsgBox(16, '2', 'Creation error Scripting.Dictionary')
Else
	$oSNTVEX.CompareMode = 1
EndIf
;~ $sTvIniData - Путь к файлу сохранения
;~ $sSection - Имя секции
;~ $sKey - Имя параметра
;~ По умолчанию функция выводит в массив все пункты. Первая колонка - имя пункта, вторая - параметр пункта, третья - состояние пункта: 1 - пункт отмечен
;~ Если все параметры заполнены, то данные будут записаны в файл
;~ Параметр пункта может быть использован в функции _GUITreeViewEx_GetItemData

Func _GUITreeViewEx_SaveTV($hTVX, $sTvIniData = '', $sSection = '', $sKey = '')
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If Not _GUICtrlTreeView_GetCount($hTV) Then Return SetError(2)
	Local $z = 0, $c = 0
	Local $hHandle = _GUICtrlTreeView_GetFirstItem($hTV)
	Local $sDelimiter = '|', $sLevel = '~', $ParamItem, $valparam
	Local $sString = '', $sText, $sLevelCount, $StringParam, $ChkType
	Local $GetRes, $aCheckedTV[0][3]
	If Not ($sTvIniData Or $sSection Or $sKey) Then
		$GetRes = 0
	Else
		$GetRes = 1
	EndIf
	While 1
		$sLevelCount = ''
		For $i = 1 To _GUICtrlTreeView_Level($hTV, $hHandle)
			$sLevelCount &= $sLevel
		Next
		$sText = _GUICtrlTreeView_GetText($hTV, $hHandle)
		$ParamItem = _GUICtrlTreeView_GetItemParam($hTV, $hHandle)
		$valparam = $oSNTV.Item($ParamItem)
		If Not $GetRes Then
			$ChkType = Number($valparam[1])
			ReDim $aCheckedTV[$z + 1][3]
			$aCheckedTV[$c][0] = $sText
			$aCheckedTV[$c][1] = $ParamItem
			If $ChkType = 3 Or $ChkType = 1 Then $aCheckedTV[$c][2] = 1
			$z += 1
			$c += 1
		Else
			$StringParam = $ParamItem & '*' & _ArrayToString($valparam, '*')
			$sString &= $sLevelCount & $sText & '*' & $StringParam & $sDelimiter
		EndIf
		$hHandle = _GUICtrlTreeView_GetNext($hTV, $hHandle)
		If Not $hHandle Then ExitLoop
	WEnd
	Local $wrtv = 0
	If $sString Then
		$wrtv = IniWrite($sTvIniData, $sSection, $sKey, StringTrimRight($sString, 1))
		Return $wrtv
	Else
		Return $aCheckedTV
	EndIf
EndFunc   ;==>_GUITreeViewEx_SaveTV


;~ $sTvIniData - Путь к файлу сохранения
;~ $sSection - Имя секции
;~ $sKey - Имя параметра

Func _GUITreeViewEx_LoadTV($hTVX, $sTvIniData, $sSection, $sKey, $iCountLang = 1, $sSeparator = '{}')
	Local $hTV
	Local $setmedit
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If _GUICtrlTreeView_GetCount($hTV) Then _GUITreeViewEx_Delete($hTV, True)
	Local $sString = IniRead($sTvIniData, $sSection, $sKey, '')
	If Not $sString Then Return SetError(1)
	Local $sTVItem, $iLevel, $hChild, $infoparam, $ParamItem
	Local $sDelimiter = '|', $sLevel = '~'
	Local $aLevelParent[100] = [0]
	Local $aTVItems = StringSplit($sString, $sDelimiter)
	_GUICtrlTreeView_BeginUpdate($hTV)
	For $i = 1 To $aTVItems[0]
		$sTVItem = StringReplace($aTVItems[$i], $sLevel, '')
		$iLevel = @extended
		$infoparam = StringSplit($sTVItem, '*', 2)
		If UBound($infoparam) < 4 Then
			_GUITreeViewEx_Delete($hTV)
			Return SetError(2) ; данные в файле повреждены
		EndIf
		$sTVItem = $infoparam[4]
		$sTVItem = StringSplit($sTVItem, $sSeparator, 1)
		If $sTVItem[0] >= $iCountLang Then
			$setmedit = $sTVItem[$iCountLang]
		Else
			$setmedit = $sTVItem[1]
		EndIf
		$hChild = _GUICtrlTreeView_AddChild($hTV, $aLevelParent[$iLevel], $setmedit)
		_GUICtrlTreeView_SetState($hTV, $hChild, $TVIS_EXPANDED, 1)
		$aLevelParent[$iLevel + 1] = $hChild
		$ParamItem = Number($infoparam[1])
		_GUICtrlTreeView_SetItemParam($hTV, $hChild, $ParamItem)
		_ArrayDelete($infoparam, '0 - 1')
		$oSNTV.Add($ParamItem, $infoparam)
		_GUICtrlTreeView_SetStateImageIndex($hTV, $hChild, Number($infoparam[1]))
	Next
	_GUICtrlTreeView_EndUpdate($hTV)
EndFunc   ;==>_GUITreeViewEx_LoadTV

Func _GUITreeViewEx_GetItems($hTVX) ;Получить по порядку список параметров всех пунктов дерева
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If Not _GUICtrlTreeView_GetCount($hTV) Then Return SetError(1)
	Local $hHandle = _GUICtrlTreeView_GetFirstItem($hTV)
	Local $aAllItemsTV[0], $ParamItem
	While 1
		$ParamItem = _GUICtrlTreeView_GetItemParam($hTV, $hHandle)
		_ArrayAdd($aAllItemsTV, $ParamItem)
		$hHandle = _GUICtrlTreeView_GetNext($hTV, $hHandle)
		If Not $hHandle Then ExitLoop
	WEnd
	If UBound($aAllItemsTV) > 0 Then Return $aAllItemsTV
EndFunc   ;==>_GUITreeViewEx_GetItems

Func _GUITreeViewEx_GetItemsTVX()
	If IsObj($oSNTV) Then Return $oSNTV.Keys()
EndFunc   ;==>_GUITreeViewEx_GetItemsTVX

Func _GUITreeViewEx_GetTVX()
	If IsObj($oSNTVEX) Then Return $oSNTVEX.Keys()
EndFunc   ;==>_GUITreeViewEx_GetTVX

Func _GUITreeViewEx_DeleteTVX()
	Local $aKeysTVX = $oSNTVEX.Keys()
	For $i In $aKeysTVX
		_GUITreeViewEx_Delete(HWnd($i), False)
	Next
EndFunc   ;==>_GUITreeViewEx_DeleteTVX

;~ Параметр: 1 - удалить все пункты, 0 - удалить TreeView
Func _GUITreeViewEx_Delete($hTVX, $nPart = True)
	Local $hTvImg, $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	Local $aAllItemsTV
	If $nPart Then
		$aAllItemsTV = _GUITreeViewEx_GetItems($hTV)
		If Not @error Then
			For $i = 0 To UBound($aAllItemsTV) - 1
				$oSNTV.Remove($aAllItemsTV[$i])
			Next
			_GUICtrlTreeView_DeleteAll($hTV)
		EndIf
	Else
		$aAllItemsTV = _GUITreeViewEx_GetItems($hTV)
		If Not @error Then
			For $i = 0 To UBound($aAllItemsTV) - 1
				$oSNTV.Remove($aAllItemsTV[$i])
			Next
		EndIf
		If $oSNTVEX.Exists(String($hTV)) Then
			$hTvImg = $oSNTVEX.Item(String($hTV))
			$oSNTVEX.Remove(String($hTV))
			_GUIImageList_Destroy($hTvImg[0])
		EndIf
		_GUICtrlTreeView_DeleteAll($hTV)
		_GUICtrlTreeView_Destroy($hTV)
		If Not $oSNTVEX.Count() Then
			_GUITreeViewEx_CloseTV()
			Return
		EndIf
		$g_GTVEx_aTVData = 0
	EndIf
	$fItemDelTV = 0
	$UnchkUp = 0
	$hModificationItemTV = 0
EndFunc   ;==>_GUITreeViewEx_Delete

;~ $hTV - handle\id TreeView
;~ $aTvIco - массив, состоящий из четырех строк. в каждой строке путь к соответствующей иконке. смотри функцию _TvImg()
;~ Иконки произвольные, назначение иконок - визуальное поределение типа элемента
Func _GUITreeViewEx_InitTV($hTVX)
	If IsHWnd($hTVX) Then
		$g_GTVEx_aTVData = $hTVX
	Else
		$g_GTVEx_aTVData = GUICtrlGetHandle($hTVX)
		If Not $g_GTVEx_aTVData Then Return SetError(1)
	EndIf
	If Not $oSNTVEX.Count() Then GUIRegisterMsg($WM_NOTIFY, '_GUITreeViewEx')
	Local $aInfTv[2] = [0, 0]
	If Not $oSNTVEX.Exists(String($g_GTVEx_aTVData)) Then $oSNTVEX.Add(String($g_GTVEx_aTVData), $aInfTv)
EndFunc   ;==>_GUITreeViewEx_InitTV

Func _GUITreeViewEx_CloseTV()
	GUIRegisterMsg($WM_NOTIFY, '')
	$g_GTVEx_aTVData = 0
	$hModificationItemTV = 0
	$UnchkUp = 0
	$fItemDelTV = 0
	$MnTVs = 0
	$sNewTxtItemTV = 0
	$nNewTxtItemTV = 0
	$nFlagKeyDn = 0
	$nFlagSelect = 0
EndFunc   ;==>_GUITreeViewEx_CloseTV

Func _GUITreeViewEx_TvImg($hTVX, $aTvIco)
	If UBound($aTvIco) <> 4 Then Return SetError(1)
	For $i = 0 To UBound($aTvIco) - 1
		If Not FileExists($aTvIco[$i]) Then Return SetError(2)
	Next
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(3)
	EndIf
	Local $aInfTv
	Local $hTvImg = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hTvImg, $aTvIco[0]) ;'\chk.ico' - Checkbox с отметкой
	_GUIImageList_AddIcon($hTvImg, $aTvIco[1]) ;'\unchk.ico' - Checkbox без отметки
	_GUIImageList_AddIcon($hTvImg, $aTvIco[2]) ;'\rd.ico' - RadioButton с отметкой
	_GUIImageList_AddIcon($hTvImg, $aTvIco[3]) ;'\unrd.ico' - RadioButton без отметки
	_GUICtrlTreeView_SetStateImageList($hTV, $hTvImg)
	If $oSNTVEX.Exists(String($hTV)) Then
		$aInfTv = $oSNTVEX.Item(String($hTV))
		$aInfTv[0] = $hTvImg
		$oSNTVEX.Item(String($hTV)) = $aInfTv
	EndIf
EndFunc   ;==>_GUITreeViewEx_TvImg

Func _GUITreeViewEx_GetHItem()
	Local $tPoint = _WinAPI_GetMousePos(1, $g_GTVEx_aTVData)
	Local $tTVHTI = _GUICtrlTreeView_HitTestEx($g_GTVEx_aTVData, DllStructGetData($tPoint, 1, 1), DllStructGetData($tPoint, 2))
	Local $hItemTV = DllStructGetData($tTVHTI, 'Item')
	If $hItemTV Then
		Switch DllStructGetData($tTVHTI, 'Flags')
			Case 4, 64
				_TVAutoSetImg($hItemTV, $UnchkUp)
				Return $hItemTV
		EndSwitch
	EndIf
EndFunc   ;==>_GUITreeViewEx_GetHItem

Func _GUITreeViewEx($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $hItem, $nAction, $aInfTv
	Local $tStruct = DllStructCreate('struct;hwnd hWndFrom;uint_ptr IDFrom;INT Code;endstruct;' & _
			'uint Action;struct;uint OldMask;handle OldhItem;uint OldState;uint OldStateMask;' & _
			'ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;lparam OldParam;endstruct;' & _
			'struct;uint NewMask;handle NewhItem;uint NewState;uint NewStateMask;' & _
			'ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;lparam NewParam;endstruct;' & _
			'struct;long PointX;long PointY;endstruct', $lParam)
	Local $hWndFrom = DllStructGetData($tStruct, 'hWndFrom')
	If $oSNTVEX.Exists(String($hWndFrom)) Then
		$g_GTVEx_aTVData = $hWndFrom
		Switch DllStructGetData($tStruct, 'Code')
			Case $NM_RCLICK
				$MnTVs = 1
			Case $NM_CLICK
				$MnTVs = 0
			Case $TVN_DELETEITEMA, $TVN_DELETEITEMW
;~ 				$hItem = DllStructGetData($tStruct, 'NewParam')
				$fItemDelTV = 1
			Case $TVN_SELCHANGEDA, $TVN_SELCHANGEDW
				$hItem = DllStructGetData($tStruct, 'NewhItem')
				If Not $fItemDelTV Then
					If $hItem Then
						$aInfTv = $oSNTVEX.Item(String($hWndFrom))
						$aInfTv[1] = $hItem
						$oSNTVEX.Item(String($hWndFrom)) = $aInfTv
						$hModificationItemTV = $hItem
						If $nFlagSelect Then
							_GUICtrlTreeView_SetState($g_GTVEx_aTVData, $hItem, $TVIS_SELECTED, False)
						Else
							If DllStructGetData($tStruct, 'Action') <> 2 Then
								_TVAutoSetImg($hItem, $UnchkUp)
								$nFlagKeyDn = 1
							ElseIf DllStructGetData($tStruct, 'Action') = 2 Then
								$nFlagKeyDn = 1
							EndIf
						EndIf
					Else
						_GUICtrlTreeView_SetSelected($g_GTVEx_aTVData, $hItem, 0)
						$aInfTv = $oSNTVEX.Item(String($hWndFrom))
						$aInfTv[1] = 0
						$oSNTVEX.Item(String($hWndFrom)) = $aInfTv
						$hModificationItemTV = 0
						$fItemDelTV = 0
					EndIf
				EndIf
			Case $TVN_KEYDOWN
				If $hModificationItemTV Then
					If DllStructGetData($tStruct, 'Action') = 32 Then _TVAutoSetImg($hModificationItemTV, $UnchkUp)
				EndIf
			Case $TVN_ENDLABELEDITA, $TVN_ENDLABELEDITW
				Local $tInfo = DllStructCreate($tagNMHDR & ';' & $tagTVITEMEX, $lParam)
				If DllStructGetData($tInfo, 'Text') <> 0 Then
					Local $tBuffer = DllStructCreate('wchar Text[' & DllStructGetData($tInfo, 'TextMax') & ']', DllStructGetData($tInfo, 'Text'))
					If StringStripWS(DllStructGetData($tBuffer, 'Text'), 3) Then
						$sNewTxtItemTV = StringReplace(StringRegExpReplace(DllStructGetData($tBuffer, 'Text'), '[*~|#><]', ' '), '\', '')
						_GUICtrlTreeView_SetText($g_GTVEx_aTVData, $hModificationItemTV, $sNewTxtItemTV)
;~ 						_TextEndTV($g_GTVEx_aTVData)
					EndIf
				EndIf
		EndSwitch
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>_GUITreeViewEx

Func _ReactchangeCHK()
	$UnchkUp = Not $UnchkUp
EndFunc   ;==>_ReactchangeCHK

;~ Снимает отметки со всех пунктов TreeView
Func _GUITreeViewEx_UnCheckAll($hTVX)
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(-1)
	EndIf
	If Not _GUICtrlTreeView_GetCount($hTV) Then Return SetError(1)
	Local $ParamItem, $valparam
	Local $hHandle = _GUICtrlTreeView_GetFirstItem($hTV)
	While 1
		$ParamItem = _GUICtrlTreeView_GetItemParam($hTV, $hHandle)
		$valparam = $oSNTV.Item($ParamItem)
		Switch Number($valparam[1])
			Case 1
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hHandle, 2)
				$valparam[1] = 2
			Case 3
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hHandle, 4)
				$valparam[1] = 4
		EndSwitch
		$oSNTV.Item($ParamItem) = $valparam
		_GUICtrlTreeView_SetSelected($hTV, $hHandle, False)
		$hHandle = _GUICtrlTreeView_GetNext($hTV, $hHandle)
		If Not $hHandle Then ExitLoop
	WEnd
EndFunc   ;==>_GUITreeViewEx_UnCheckAll

Func _TVAutoSetImg($hItem, $UpUnchk)
	If Not $hItem Then Return
	Local $valparam, $vpp, $ptpm
	Local $getparam = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hItem)
	Local $hParent = _GUICtrlTreeView_GetParentHandle($g_GTVEx_aTVData, $hItem)
	If $hParent Then
		$ptpm = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hParent)
		$vpp = $oSNTV.Item($ptpm)
	EndIf
	$valparam = $oSNTV.Item($getparam)
	Switch Number($valparam[1])
		Case 1
			_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hItem, 2)
			$valparam[1] = 2
			$oSNTV.Item($getparam) = $valparam
;~ 			If $hParent Then
;~ 				If $UpUnchk Then _AutoUnCheckParents($hItem)
;~ 				__TVUnCheck($hItem, False)
;~ 			Else
			__TVUnCheck($hItem, False)
;~ 			EndIf
		Case 2
			_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hItem, 1)
			$valparam[1] = 1
			$oSNTV.Item($getparam) = $valparam
			If $hParent Then
				Switch Number($vpp[1])
					Case 2, 4
						_AutoCheckParents($hItem)
				EndSwitch
				If $UpUnchk Then __TVUnCheck($hItem, True, True)
			Else
				If $UpUnchk Then __TVUnCheck($hItem, True, True)
			EndIf
		Case 3
		Case 4
			_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hItem, 3)
			$valparam[1] = 3
			$oSNTV.Item($getparam) = $valparam
			If $hParent Then
				Switch Number($vpp[1])
					Case 2, 4
						_AutoCheckParents($hItem)
				EndSwitch
				If $UpUnchk Then __TVUnCheck($hItem, True, True)
			Else
				If $UpUnchk Then __TVUnCheck($hItem, True, True)
			EndIf
			If $hParent Then
				Local $ParamItem, $Child
				If Number($vpp[0]) Then
					$Child = _GUICtrlTreeView_GetFirstChild($g_GTVEx_aTVData, $hParent)
					If Not $Child Then Return
					While 1
						$ParamItem = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $Child)
						If StringCompare($getparam, $ParamItem) Then
							$valparam = $oSNTV.Item($ParamItem)
							Switch Number($valparam[1])
								Case 1
									$valparam[1] = 2
									$oSNTV.Item($ParamItem) = $valparam
									_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $Child, 2)
								Case 3
									$valparam[1] = 4
									$oSNTV.Item($ParamItem) = $valparam
									_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $Child, 4)
							EndSwitch
							__TVUnCheck($Child, False)
						EndIf
						$Child = _GUICtrlTreeView_GetNextChild($g_GTVEx_aTVData, $Child)
						If Not $Child Then ExitLoop
					WEnd
				EndIf
			EndIf
	EndSwitch
EndFunc   ;==>_TVAutoSetImg

;----------------------------------------------------------------------------------------------------------------------

Func _AutoUnCheckParents($hPassedItem)
	Local $hParent = _GUICtrlTreeView_GetParentHandle($g_GTVEx_aTVData, $hPassedItem)
	If Not $hParent Then Return
	Local $vch = __TVVerifyCheck($hParent)
	If Not $vch Then
		Local $ParamItem = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hParent)
		Local $valparam = $oSNTV.Item($ParamItem)
		Switch Number($valparam[1])
			Case 1
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hParent, 2)
				$valparam[1] = 2
			Case 3
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hParent, 4)
				$valparam[1] = 4
		EndSwitch
		$oSNTV.Item($ParamItem) = $valparam
		_AutoUnCheckParents($hParent)
	EndIf
EndFunc   ;==>_AutoUnCheckParents

Func __TVVerifyCheck($hPassedItem)
	Local $hChild = _GUICtrlTreeView_GetFirstChild($g_GTVEx_aTVData, $hPassedItem)
	If Not $hChild Then Return
	Local $ParamItem
	Local $vlpm
	While 1
		$ParamItem = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hChild)
		$vlpm = $oSNTV.Item($ParamItem)
		Switch Number($vlpm[1])
			Case 1, 3
				Return 1
		EndSwitch
		$hChild = _GUICtrlTreeView_GetNextChild($g_GTVEx_aTVData, $hChild)
		If Not $hChild Then ExitLoop
	WEnd
EndFunc   ;==>__TVVerifyCheck

;-----------------------------------------------------------------------------------------------------------------------


Func _AutoCheckParents($hPassedItem)
	Local $hParent = _GUICtrlTreeView_GetParentHandle($g_GTVEx_aTVData, $hPassedItem)
	If Not $hParent Then Return
	Local $ParamItem = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hParent)
	Local $valparam = $oSNTV.Item($ParamItem)
	Switch Number($valparam[1])
		Case 2
			_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hParent, 1)
			$valparam[1] = 1
		Case 4
			_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hParent, 3)
			$valparam[1] = 3
	EndSwitch
	$oSNTV.Item($ParamItem) = $valparam
	If Number($valparam[0]) Then _TVUnCheckOther($hPassedItem, $hParent)
	_AutoCheckParents($hParent)
EndFunc   ;==>_AutoCheckParents

Func _TVUnCheckOther($hPassedItem, $hParent)
	Local $ncompare = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hPassedItem)
	Local $Child, $ParamItem, $valparam
	$Child = _GUICtrlTreeView_GetFirstChild($g_GTVEx_aTVData, $hParent)
	If Not $Child Then Return
	While 1
		$ParamItem = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $Child)
		If StringCompare($ncompare, $ParamItem) Then
			$valparam = $oSNTV.Item($ParamItem)
			Switch Number($valparam[1])
				Case 1
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $Child, 2)
					$valparam[1] = 2
				Case 3
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $Child, 4)
					$valparam[1] = 4
			EndSwitch
			$oSNTV.Item($ParamItem) = $valparam
			__TVUnCheck($Child, False)
		EndIf
		$Child = _GUICtrlTreeView_GetNextChild($g_GTVEx_aTVData, $Child)
		If Not $Child Then ExitLoop
	WEnd
EndFunc   ;==>_TVUnCheckOther

Func __TVUnCheck($hPassedItem, $bState, $itemf = False)
	Local $checkpram, $valparam
	$checkpram = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hPassedItem)
	$valparam = $oSNTV.Item($checkpram)
	Switch Number($valparam[1])
		Case 1
			If Not $bState Then
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hPassedItem, 2)
				$valparam[1] = 2
			EndIf
		Case 2
			If $bState Then
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hPassedItem, 1)
				$valparam[1] = 1
			EndIf
		Case 3
			If Not $bState Then
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hPassedItem, 4)
				$valparam[1] = 4
			EndIf
		Case 4
			If $bState Then
				_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hPassedItem, 3)
				$valparam[1] = 3
			EndIf
	EndSwitch
	$oSNTV.Item($checkpram) = $valparam
	Local $hChild = _GUICtrlTreeView_GetFirstChild($g_GTVEx_aTVData, $hPassedItem)
	If Not $hChild Then Return
	While 1
		$checkpram = _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hChild)
		$valparam = $oSNTV.Item($checkpram)
		Switch Number($valparam[1])
			Case 1
				If Not $bState Then
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hChild, 2)
					$valparam[1] = 2
				EndIf
			Case 2
				If $bState Then
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hChild, 1)
					$valparam[1] = 1
				EndIf
			Case 3
				If Not $bState Then
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hChild, 4)
					$valparam[1] = 4
				EndIf
			Case 4
				If $bState Then
					_GUICtrlTreeView_SetStateImageIndex($g_GTVEx_aTVData, $hChild, 3)
					$valparam[1] = 3
				EndIf
		EndSwitch
		$oSNTV.Item($checkpram) = $valparam
		__TVUnCheck($hChild, $bState, $itemf)
		If Not $itemf Then
			$hChild = _GUICtrlTreeView_GetNextChild($g_GTVEx_aTVData, $hChild)
		Else
			$hChild = _GUICtrlTreeView_GetFirstChild($g_GTVEx_aTVData, $hChild)
		EndIf
		If Not $hChild Then ExitLoop
	WEnd
EndFunc   ;==>__TVUnCheck

;~ Дочерние подпункты первого уровня выбранного пункта будут иметь поведение RadioButton. то есть, будет возможен выбор только одного подпункта
;~ При повторной использовании функции для пункта его дочерним подпунктам возвращается исходное поведение - Checkbox
Func _GUITreeViewEx_ChooseOnlyOne($hTVX)
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	Local $hParent, $aInfTv
	$aInfTv = $oSNTVEX.Item(String($hTV))
	$hParent = $aInfTv[1]
	If Not $hParent Then Return
	Local $nameparent = _GUICtrlTreeView_GetItemParam($hTV, $hParent)
	Local $aDataItem = $oSNTV.Item($nameparent)
	If Not Number($aDataItem[0]) Then
		$aDataItem[0] = 1
		Switch Number($aDataItem[1])
			Case 1
				$aDataItem[1] = 2
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hParent, 2)
			Case 3
				$aDataItem[1] = 4
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hParent, 4)
		EndSwitch
		$oSNTV.Item($nameparent) = $aDataItem
		_TVCHRD($hTV, $hParent, 4)
		__TVUnCheck($hParent, False)
	ElseIf Number($aDataItem[0]) Then
		$aDataItem[0] = 0
		$oSNTV.Item($nameparent) = $aDataItem
		_TVCHRD($hTV, $hParent, 2)
		__TVUnCheck($hParent, False)
	EndIf
	_AutoUnCheckParents($hParent)
EndFunc   ;==>_GUITreeViewEx_ChooseOnlyOne

Func _TVCHRD($hTV, $hPassedItem, $chType)
	Local $checkpram, $valparam
	Local $hChild = _GUICtrlTreeView_GetFirstChild($hTV, $hPassedItem)
	If Not $hChild Then Return
	While 1
		$checkpram = _GUICtrlTreeView_GetItemParam($hTV, $hChild)
		$valparam = $oSNTV.Item($checkpram)
		Switch $chType
			Case 4
				$valparam[1] = 4
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hChild, 4)
			Case 2
				$valparam[1] = 2
				_GUICtrlTreeView_SetStateImageIndex($hTV, $hChild, 2)
		EndSwitch
		$oSNTV.Item($checkpram) = $valparam
		$hChild = _GUICtrlTreeView_GetNextChild($hTV, $hChild)
		If Not $hChild Then ExitLoop
	WEnd
EndFunc   ;==>_TVCHRD

;~ Возвращает массив данных текущего пункта, если не указан $ParamItem
Func _GUITreeViewEx_GetItemData($hTVX, $ParamItem = 0, $nTechData = 0)
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If Not $oSNTVEX.Exists(String($hTV)) Then Return SetError(-1)
	Local $aInfTv
	Local $CurrentParam = Number($ParamItem)
	If Not $CurrentParam Then
		$aInfTv = $oSNTVEX.Item(String($hTV))
		If Not $aInfTv[1] Then Return SetError(1)
		$CurrentParam = _GUICtrlTreeView_GetItemParam($hTV, $aInfTv[1])
	EndIf
	If Not $oSNTV.Exists($CurrentParam) Then Return SetError(2)
	Local $aDataItem = $oSNTV.Item($CurrentParam)
	If Not $nTechData Then _ArrayDelete($aDataItem, '0 - 1')
	If Not UBound($aDataItem) Then
		Return SetError(3)
	Else
		Return $aDataItem
	EndIf
EndFunc   ;==>_GUITreeViewEx_GetItemData

;~ Обновляет данные пункта. Данные заменются полностью
;~ $aUserData - Массив данных для обновления
;~ Данные обновляются в текущем пункте, если не указан $ParamItem
;~ Для записи многострочного текста заменяйте @CRLF или @LF на спецсимвол
Func _GUITreeViewEx_SetItemData($hTVX, $aUserData, $ParamItem = 0, $nTechData = 0)
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If Not $oSNTVEX.Exists(String($hTV)) Then Return SetError(-1)
	Local $aInfTv
	Local $checkarray = UBound($aUserData)
	If Not $checkarray Then Return SetError(1)
	Local $CurrentParam = Number($ParamItem)
	If Not $CurrentParam Then
		$aInfTv = $oSNTVEX.Item(String($hTV))
		If Not $aInfTv[1] Then Return SetError(2)
		$CurrentParam = _GUICtrlTreeView_GetItemParam($hTV, $aInfTv[1])
	EndIf
	If Not $oSNTV.Exists($CurrentParam) Then Return SetError(3)
	Local $aDataItem = $oSNTV.Item($CurrentParam)
	If Not $nTechData Then
		Local $aTechData[2] = [$aDataItem[0], $aDataItem[1]]
		_ArrayConcatenate($aTechData, $aUserData)
		If @error Then Return SetError(4)
		$oSNTV.Item($CurrentParam) = $aTechData
	Else
		$oSNTV.Item($CurrentParam) = $aUserData
	EndIf
EndFunc   ;==>_GUITreeViewEx_SetItemData

;~ Удаляет данные пункта
Func _GUITreeViewEx_DelItemData($hTVX, $ParamItem = 0, $nTechData = 0)
	Local $hTV
	If IsHWnd($hTVX) Then
		$hTV = $hTVX
	Else
		$hTV = GUICtrlGetHandle($hTVX)
		If Not $hTV Then Return SetError(1)
	EndIf
	If Not $oSNTVEX.Exists(String($hTV)) Then Return SetError(-1)
	Local $aInfTv
	Local $CurrentParam = Number($ParamItem)
	If Not $CurrentParam Then
		$aInfTv = $oSNTVEX.Item(String($hTV))
		If Not $aInfTv[1] Then Return SetError(1)
		$CurrentParam = _GUICtrlTreeView_GetItemParam($hTV, $aInfTv[1])
	EndIf
	If Not $oSNTV.Exists($CurrentParam) Then Return SetError(2)
	If Not $nTechData Then
		Local $aDataItem = $oSNTV.Item($CurrentParam)
		Local $aTechData[2] = [$aDataItem[0], $aDataItem[1]]
		$oSNTV.Item($CurrentParam) = $aTechData
	Else
		$oSNTV.Item($CurrentParam) = ''
	EndIf
EndFunc   ;==>_GUITreeViewEx_DelItemData
Func _FileListToArray($sFilePath, $sFilter = "*", $iFlag = $FLTA_FILESFOLDERS, $bReturnPath = False)
	Local $sDelimiter = "|", $sFileList = "", $sFileName = "", $sFullPath = ""
	$sFilePath = StringRegExpReplace($sFilePath, "[\\/]+$", "") & "\"
	If $iFlag = Default Then $iFlag = $FLTA_FILESFOLDERS
	If $bReturnPath Then $sFullPath = $sFilePath
	If $sFilter = Default Then $sFilter = "*"
	If Not FileExists($sFilePath) Then Return SetError(1, 0, 0)
	If StringRegExp($sFilter, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
	If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 0, 0)
	Local $hSearch = FileFindFirstFile($sFilePath & $sFilter)
	If @error Then Return SetError(4, 0, 0)
	While 1
		$sFileName = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If ($iFlag + @extended = 2) Then ContinueLoop
		$sFileList &= $sDelimiter & $sFullPath & $sFileName
	WEnd
	FileClose($hSearch)
	If $sFileList = "" Then Return SetError(4, 0, 0)
	Return StringSplit(StringTrimLeft($sFileList, 1), $sDelimiter)
EndFunc   ;==>_FileListToArray
Global Const $tagGDIPRECTF = "struct;float X;float Y;float Width;float Height;endstruct"
Global $__g_hGDIPBrush = 0
Global $__g_hGDIPDll = 0
Global $__g_hGDIPPen = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Func _GDIPlus_BrushCreateSolid($iARGB = 0xFF000000)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateSolidFill", "int", $iARGB, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[2]
EndFunc   ;==>_GDIPlus_BrushCreateSolid
Func _GDIPlus_BrushDispose($hBrush)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeleteBrush", "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_BrushDispose
Func _GDIPlus_FontCreate($hFamily, $fSize, $iStyle = 0, $iUnit = 3)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateFont", "handle", $hFamily, "float", $fSize, "int", $iStyle, "int", $iUnit, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[5]
EndFunc   ;==>_GDIPlus_FontCreate
Func _GDIPlus_FontDispose($hFont)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeleteFont", "handle", $hFont)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_FontDispose
Func _GDIPlus_FontFamilyCreate($sFamily, $pCollection = 0)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateFontFamilyFromName", "wstr", $sFamily, "ptr", $pCollection, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[3]
EndFunc   ;==>_GDIPlus_FontFamilyCreate
Func _GDIPlus_FontFamilyDispose($hFamily)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeleteFontFamily", "handle", $hFamily)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_FontFamilyDispose
Func _GDIPlus_GraphicsClear($hGraphics, $iARGB = 0xFF000000)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipGraphicsClear", "handle", $hGraphics, "dword", $iARGB)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsClear
Func _GDIPlus_GraphicsDrawLine($hGraphics, $nX1, $nY1, $nX2, $nY2, $hPen = 0)
	__GDIPlus_PenDefCreate($hPen)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDrawLine", "handle", $hGraphics, "handle", $hPen, "float", $nX1, "float", $nY1, "float", $nX2, "float", $nY2)
	__GDIPlus_PenDefDispose()
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsDrawLine
Func _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $tLayout, $hFormat, $hBrush)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDrawString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, "struct*", $tLayout, "handle", $hFormat, "handle", $hBrush)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsDrawStringEx
Func _GDIPlus_GraphicsFillRect($hGraphics, $nX, $nY, $nWidth, $nHeight, $hBrush = 0)
	__GDIPlus_BrushDefCreate($hBrush)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipFillRectangle", "handle", $hGraphics, "handle", $hBrush, "float", $nX, "float", $nY, "float", $nWidth, "float", $nHeight)
	__GDIPlus_BrushDefDispose()
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsFillRect
Func _GDIPlus_GraphicsSetTextRenderingHint($hGraphics, $iTextRenderingHint)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipSetTextRenderingHint", "handle", $hGraphics, "int", $iTextRenderingHint)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_GraphicsSetTextRenderingHint
Func _GDIPlus_PenCreate($iARGB = 0xFF000000, $nWidth = 1, $iUnit = 2)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreatePen1", "dword", $iARGB, "float", $nWidth, "int", $iUnit, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[4]
EndFunc   ;==>_GDIPlus_PenCreate
Func _GDIPlus_PenDispose($hPen)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeletePen", "handle", $hPen)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_PenDispose
Func _GDIPlus_RectFCreate($nX = 0, $nY = 0, $nWidth = 0, $nHeight = 0)
	Local $tRECTF = DllStructCreate($tagGDIPRECTF)
	DllStructSetData($tRECTF, "X", $nX)
	DllStructSetData($tRECTF, "Y", $nY)
	DllStructSetData($tRECTF, "Width", $nWidth)
	DllStructSetData($tRECTF, "Height", $nHeight)
	Return $tRECTF
EndFunc   ;==>_GDIPlus_RectFCreate
Func _GDIPlus_StringFormatCreate($iFormat = 0, $iLangID = 0)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateStringFormat", "int", $iFormat, "word", $iLangID, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[3]
EndFunc   ;==>_GDIPlus_StringFormatCreate
Func _GDIPlus_StringFormatDispose($hFormat)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipDeleteStringFormat", "handle", $hFormat)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_StringFormatDispose
Func _GDIPlus_StringFormatSetAlign($hStringFormat, $iFlag)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipSetStringFormatAlign", "handle", $hStringFormat, "int", $iFlag)
	If @error Then Return SetError(@error, @extended, False)
	If $aCall[0] Then Return SetError(10, $aCall[0], False)
	Return True
EndFunc   ;==>_GDIPlus_StringFormatSetAlign
Func _GDIPlus_TextureCreate($hImage, $iWrapMode = 0)
	Local $aCall = DllCall($__g_hGDIPDll, "int", "GdipCreateTexture", "handle", $hImage, "int", $iWrapMode, "handle*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If $aCall[0] Then Return SetError(10, $aCall[0], 0)
	Return $aCall[3]
EndFunc   ;==>_GDIPlus_TextureCreate
Func __GDIPlus_BrushDefCreate(ByRef $hBrush)
	If $hBrush = 0 Then
		$__g_hGDIPBrush = _GDIPlus_BrushCreateSolid()
		$hBrush = $__g_hGDIPBrush
	EndIf
EndFunc   ;==>__GDIPlus_BrushDefCreate
Func __GDIPlus_BrushDefDispose($iCurError = @error, $iCurExtended = @extended)
	If $__g_hGDIPBrush <> 0 Then
		_GDIPlus_BrushDispose($__g_hGDIPBrush)
		$__g_hGDIPBrush = 0
	EndIf
	Return SetError($iCurError, $iCurExtended)
EndFunc   ;==>__GDIPlus_BrushDefDispose
Func __GDIPlus_PenDefCreate(ByRef $hPen)
	If $hPen = 0 Then
		$__g_hGDIPPen = _GDIPlus_PenCreate()
		$hPen = $__g_hGDIPPen
	EndIf
EndFunc   ;==>__GDIPlus_PenDefCreate
Func __GDIPlus_PenDefDispose($iCurError = @error, $iCurExtended = @extended)
	If $__g_hGDIPPen <> 0 Then
		_GDIPlus_PenDispose($__g_hGDIPPen)
		$__g_hGDIPPen = 0
	EndIf
	Return SetError($iCurError, $iCurExtended)
EndFunc   ;==>__GDIPlus_PenDefDispose

;~ Код Lang.au3--------------------------------------------------------------------------------------------------------------

Global $Instjmplang[35]
$Instjmplang[0] = 'Игра не найдена. Воспользуйтесь выбором'
$Instjmplang[1] = 'Очистка кэша игры'
$Instjmplang[2] = 'Выберите папку с установленной игрой'
$Instjmplang[3] = 'Создание архива'
$Instjmplang[4] = 'Не выбрано ни одного пункта. Установка невозможна'
$Instjmplang[5] = 'Откат изменений'
$Instjmplang[6] = 'Установка прервана'
$Instjmplang[7] = 'Распаковка невозможна'
$Instjmplang[8] = 'Ошибка'
$Instjmplang[9] = 'Установка невозможна'
$Instjmplang[10] = 'Создание деинсталятора'
$Instjmplang[11] = 'Удалить'
$Instjmplang[12] = 'Установка завершена'
$Instjmplang[13] = 'Подготовка к установке'
$Instjmplang[14] = 'Составление списка файлов'
$Instjmplang[15] = 'Проверка файлов'
$Instjmplang[16] = 'Установка шрифтов'
$Instjmplang[17] = 'Настройка конфигурации модов'
$Instjmplang[18] = 'Ошибка чтения файла'
$Instjmplang[19] = 'Файл не найден'
$Instjmplang[20] = 'Ошибка записи файла'
$Instjmplang[21] = 'Удаление установленных модов'
$Instjmplang[22] = 'Удаление временных файлов'
$Instjmplang[23] = 'Критическая ошибка. Загрузка невозможна'
$Instjmplang[24] = 'Нет управляющих элементов на странице'
$Instjmplang[25] = 'Программа:'
$Instjmplang[26] = 'Строка ошибки:'
$Instjmplang[27] = 'Содержание ошибки:'
$Instjmplang[28] = 'Критическая ошибка'
$Instjmplang[29] = 'Продолжение работы программы невозможно'
$Instjmplang[30] = 'Код ошибки записан в:'
$Instjmplang[31] = 'Деинсталяция модпака'
$Instjmplang[32] = 'Удалить модпак'
$Instjmplang[33] = 'Выберите путь установки'
$Instjmplang[34] = 'Продолжить'

;~ Код MNOBJST.au3------------------------------------------------------------------------------------------------

Opt('GUICloseOnESC', 0)
Opt('TrayMenuMode', 1)
Global $oSNW = ObjCreate('Scripting.Dictionary')
Sleep(500)
If $oSNW = 0 Then
	MsgBox(16, '', 'Object Scripting.Dictionary.oSNW - error')
	Exit
EndIf
$oSNW.CompareMode = 1
Global $oMod = ObjCreate('Scripting.Dictionary')
Sleep(500)
If $oMod = 0 Then
	MsgBox(16, '', 'Object Scripting.Dictionary.oMod - error')
	Exit
EndIf
$oMod.CompareMode = 1
Global $stoppr, $sNameMod[0], $UpIdC = 0
Global $WOTP, $Title, $Mini, $Close, $tmphtv, $objw, $objc, $CurGui = 0, $volume = 100
Global $wkdir = @TempDir & '\wkdirjmp3', $pidwr, $curani = $wkdir & '\arrow.ani', $curc = $wkdir & '\arrow.cur', $force_a = $wkdir & '\force.ani', $force_c = $wkdir & '\force.cur'
Global $curtv, $tmpcurtv, $flpathgame, $flchpathgm
Global $flfunc = '', $flclmods, $flclresmods, $flbackup = 0, $infstinst, $flclmrm = 0, $flclcash = 0
Global $ALLTTF[0], $aALLAU, $aModsC, $flhide, $idpic, $idtxt = 0, $backlight = 0, $curidpos = 0
Global $nExistsTV = -1, $imgbackw = $wkdir & '\bck0.png', $aLoadTV[0][2], $nflagsetimgtv = 0
Global $setpathgame = '', $flagpath = 0, $playbck = $wkdir & '\bckau.mp3', $flinstset = 0, $clip = '', $setunmod = 0, $exmods[0], $endex = 0, $tmprcld = 0, $prcall = 0
Global $itmpFileName = '', $sNameG = '', $g_hCursor = 0, $g_hCursorLight = 0, $setcur = 0, $actcur = 0, $VerGameInst = ''
Global $FlashGui, $tmpiWRSZF, $iTMPProc, $iPrwrf, $tmpDest, $aWrex = '', $sBackupFiles
Global $nbackauset = 4, $nausetmod = 4, $MusicHandleBck, $MusicHandleMod, $Song_Length
Global $7zaPath = $wkdir & '\7za.exe'
Global $aIco[4] = [$wkdir & '\chk.ico', $wkdir & '\unchk.ico', $wkdir & '\rd.ico', $wkdir & '\unrd.ico']
Global $backlightcolor, $flpgtv, $flpg
Global $iPercData, $iPercId, $hHBmp_BG, $WPerc, $HPerc, $BgColorGui, $FgBGColor, $BGColor, $TextBGColor, $sFontProgress, $iVisPerc
Global $PathSFX = @ScriptFullPath
Global $Blitz_Packs = '', $GetPathExe = '', $sListModsF = '', $iCHLangPJ = 1
Global $aFontInstRes, $FONT_PRIVATE = 0x10, $SelectProgressbar = 0, $nDiffplayCtrl = 0, $PlayCheck = 0, $PlayPic = 0
Global $picauback = $wkdir & '\picauback.png', $picaubackST = $wkdir & '\picaubackST.png', $picaumod = $wkdir & '\picaumod.png', $picaumodST = $wkdir & '\picaumodST.png'
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
Func _PageCreate(ByRef $obj, $key)
	Local $one = ObjCreate('Scripting.Dictionary')
	Local $k
	Do
		If $k = 50 Then Return SetError(1)
		$k += 1
		Sleep(10)
	Until VarGetType($one) = 'Object'
	$one.CompareMode = 1
	Local $two = ObjCreate('Scripting.Dictionary')
	$k = 0
	Do
		If $k = 50 Then Return SetError(1)
		$k += 1
		Sleep(10)
	Until VarGetType($two) = 'Object'
	$two.CompareMode = 1
	Local $aObj[2] = [$one, $two]
	$obj.Add($key, $aObj)
EndFunc   ;==>_PageCreate
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
						Case 'Wargaming Blitz'
							$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
							If $gtprname = 'WarGaming.net' Then
								$PathNameExe = StringStripWS($PathNameExe, 3)
								If FileExists($PathNameExe) Then Return $PathNameExe
							EndIf
						Case 'Lesta Blitz'
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
							Case 'Wargaming Blitz'
								$gtprname = FileGetVersion($PathNameExe & '\' & $NameExe, 'CompanyName')
								If $gtprname = 'WarGaming.net' Then
									$PathNameExe = StringStripWS($PathNameExe, 3)
									If FileExists($PathNameExe) Then Return $PathNameExe
								EndIf
							Case 'Lesta Blitz'
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
	WinActivate($hSelInstLang)
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
	If $bNotify Then
		Local Const $WM_FONTCHANGE = 0x001D
		Local Const $HWND_BROADCAST = 0xFFFF
		DllCall('user32.dll', 'lresult', 'SendMessage', 'hwnd', $HWND_BROADCAST, 'uint', $WM_FONTCHANGE, 'wparam', 0, 'lparam', 0)
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

;~ Основной код инсталятора---------------------------------------------------------------------------------------------------------

_EXF()
_CurGui()
Func _WinExFF()
	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($wkdir & '\flash.png')
	If @error Then
		_GDIPlus_Shutdown()
		Return SetError(1)
	EndIf
	Local $XW = _GDIPlus_ImageGetWidth($hImage)
	Local $YH = _GDIPlus_ImageGetHeight($hImage)
	$FlashGui = GUICreate('', $XW, $YH, -1, -1, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_LAYERED, $WS_EX_TOPMOST))
	GUISetState()
	Local $hScrDC = _WinAPI_GetDC($FlashGui)
	Local $hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	Local $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	Local $hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	Local $tSize = DllStructCreate($tagSIZE)
	Local $pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, 'X', $XW)
	DllStructSetData($tSize, 'Y', $YH)
	Local $tSource = DllStructCreate($tagPOINT)
	Local $pSource = DllStructGetPtr($tSource)
	Local $tBlend = DllStructCreate($tagBLENDFUNCTION)
	Local $pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, 'Format', 1)
	For $i = 0 To 255 Step 5
		DllStructSetData($tBlend, 'Alpha', $i)
		_WinAPI_UpdateLayeredWindow($FlashGui, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
		Sleep(30)
	Next
	Sleep(2000)
	For $i = 255 To 0 Step -5
		DllStructSetData($tBlend, 'Alpha', $i)
		_WinAPI_UpdateLayeredWindow($FlashGui, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
		Sleep(30)
	Next
	GUIDelete($FlashGui)
	_GDIPlus_ImageDispose($hImage)
	_WinAPI_ReleaseDC($FlashGui, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)
	_GDIPlus_Shutdown()
EndFunc   ;==>_WinExFF
Func _EXF()
	_BASS_Startup($wkdir & '\bass.dll')
	_BASS_Init(0, -1, 44100, 0, '')
	If FileExists($playbck) Then
		$MusicHandleBck = _BASS_StreamCreateFile(False, $playbck, 0, 0, $BASS_SAMPLE_LOOP)
		_BASS_ChannelPlay($MusicHandleBck, 1)
	EndIf
	If FileExists($wkdir & '\flash.png') Then _WinExFF()
	$iCHLangPJ = _ChooseLang()
	_LOADPJT()
	If $PlayCheck = 1 And $PlayPic = 0 Then
		$nDiffplayCtrl = 1
	Else
		$nDiffplayCtrl = 0
	EndIf
EndFunc   ;==>_EXF
Func _CurGui()
	Local $getg = $objw.Item(0)
	$backlight = Number($getg[9])
	If $backlight = 3 Then $backlightcolor = Number($getg[10])
	If FileExists($curani) Then
		$setcur = $curani
	ElseIf FileExists($curc) Then
		$setcur = $curc
	EndIf
	If $setcur Then
		$g_hCursor = _WinAPI_LoadCursorFromFile($setcur)
		_WinAPI_SetCursor($g_hCursor)
	EndIf
	If FileExists($force_a) Then
		$actcur = $force_a
	ElseIf FileExists($force_c) Then
		$actcur = $force_c
	EndIf
	If $actcur Then $g_hCursorLight = _WinAPI_LoadCursorFromFile($actcur)
	If $nExistsTV > -1 Then
		_CreateTVLoad()
	Else
		$flpg = 1
	EndIf
	_WinAPI_SetLayeredWindowAttributes($WOTP, 50, 255)
	GUISetIcon($PathSFX, '', $WOTP)
	GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
	GUIRegisterMsg($WM_SETCURSOR, 'WM_SETCURSOR')
	GUIRegisterMsg($WM_MOUSEWHEEL, 'WM_MOUSEWHEEL')
	GUIRegisterMsg(0x0006, "WM_ACTIVATE")
	Local $sIniReadVer = IniRead($wkdir & '\page0.jmp3', 'Windows', '0', '')
	Local $aSPLinfo = StringSplit($sIniReadVer, '<>', 3)
	If UBound($aSPLinfo) <> 11 Then
		Exit MsgBox(16, 'Start', $Instjmplang[29])
	Else
		$sNameG = $aSPLinfo[7]
	EndIf
	Switch $sNameG
		Case 'Wargaming Blitz'
			$Blitz_Packs = @LocalAppDataDir & '\wotblitz'
			$GetPathExe = 'wotblitz.exe'
		Case 'Lesta Blitz'
			$Blitz_Packs = @MyDocumentsDir & '\TanksBlitz'
			$GetPathExe = 'tanksblitz.exe'
	EndSwitch
	$VerGameInst = $aSPLinfo[8]
	$setpathgame = _CGW($GetPathExe, $sNameG)
	If $setpathgame = '' Then MsgBox(64, 'Path', $Instjmplang[0])
	If $oMod.Exists('path') Then
		Local $stpath = $oMod.Item('path')
		GUICtrlSetData($stpath, $setpathgame)
	EndIf
	GUISetState(@SW_SHOW, $WOTP)
	WinActivate($WOTP)
	_WinAPI_RedrawWindow($WOTP)
	_WinAPI_UpdateWindow($WOTP)
	While 1
		If $nflagsetimgtv Then
			$nflagsetimgtv = 0
			_GUITreeViewEx_GetHItem()
		EndIf
		If $flfunc <> '' Then
			Switch String($flfunc)
				Case 'chpath'
					If Not $flinstset Then _CHPATH()
				Case 'inst'
					If Not $flinstset Then
						If $iPercId Then
							If Not $SelectProgressbar Then AdlibRegister('PlayAnim', 100)
						EndIf
						_INST()
					EndIf
				Case 'close'
					If Not $flinstset Then
						AdlibUnRegister('PlayAnim')
						GUIDelete($WOTP)
						_StopSound()
						Run('cmd.exe /C rmdir /S /Q "' & @TempDir & '\wkdirjmp3' & '"', '', @SW_HIDE)
						Exit
					EndIf
			EndSwitch
			$flfunc = ''
		EndIf
		Sleep(100)
	WEnd
EndFunc   ;==>_CurGui
Func _CHPATH()
	Local $odg = FileSelectFolder($Instjmplang[2], @HomeDrive, 0, '', $WOTP)
	If Not @error Then
		$setpathgame = $odg
		If $oMod.Exists('path') Then
			Local $stpath = $oMod.Item('path')
			GUICtrlSetData($stpath, $setpathgame)
		EndIf
	Else
		Return SetError(1)
	EndIf
EndFunc   ;==>_CHPATH
Func _GetInfoMod()
	$sListModsF = ''
	Local $getst, $gtm, $objc1
	Local $infpg = $oSNW.Keys()
	For $pg In $infpg
		$objc1 = $oSNW.Item($pg)[1]
		$gtm = $objc1.Keys()
		If Not IsArray($gtm) Then ContinueLoop
		For $i In $gtm
			$getst = $objc1.Item($i)
			Switch String($getst[0])
				Case 'mod'
					If $getst[23] = 1 Or GUICtrlRead($i) = 1 Then
						$clip &= $getst[14] & @CRLF
						If Not (String($getst[18]) == '0') Then
							_Array_Add($exmods, $getst[14] & '.7z')
							If FileExists($wkdir & '\' & $getst[14] & '.txt') Then $sListModsF &= FileRead($wkdir & '\' & $getst[14] & '.txt') & @LF
							_Array_Add($sNameMod, StringReplace(StringReplace($getst[1], '\n', @CRLF), '\h', ' '))
						EndIf
						If Not (String($getst[21]) == '0') Then
							If FileExists($wkdir & '\' & $getst[14] & '.ttf') Then
								_Array_Add($ALLTTF, $wkdir & '\' & $getst[14] & '.ttf')
							ElseIf FileExists($wkdir & '\' & $getst[14] & '.otf') Then
								_Array_Add($ALLTTF, $wkdir & '\' & $getst[14] & '.otf')
							EndIf
						EndIf
					EndIf
			EndSwitch
		Next
	Next
EndFunc   ;==>_GetInfoMod
Func _INST()
	If Not FileExists($setpathgame) Then
		Return MsgBox(64, '', $Instjmplang[0], 0, $WOTP)
	EndIf
	$flinstset = 1
	If $nExistsTV = -1 Then
		_GetInfoMod()
	Else
		_GetInfoModTV()
	EndIf
	If UBound($exmods) = 0 Then
		$flinstset = 0
		$clip = ''
		Dim $ALLTTF[0]
		Dim $sNameMod[0]
		Return MsgBox(64, '', $Instjmplang[4], 0, $WOTP)
	EndIf
	If $curidpos Then
		Local $setoldid = $objc.Item($curidpos)
		If UBound($setoldid) = 26 Then
			If $backlight = 2 Then
				Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
				Switch String($setoldid[0])
					Case 'label', 'checkbox'
						Local $setnewid = StringSplit($setoldid[8], '!')
						GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
				EndSwitch
				GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
			ElseIf $backlight = 3 Then
				Switch String($setoldid[0])
					Case 'label', 'checkbox'
						GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
				EndSwitch
			EndIf
		EndIf
		$curidpos = 0
	EndIf
	If $oSNW.Exists('page' & $CurGui + 1) Then _PAGEBN(1)
	_EXMOD()
	If @error Then
		Local $splw, $oneP, $delcurfule
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[5])
		Local $error = @error
		If $aWrex <> '' Then
			$splw = StringSplit($aWrex, @LF, 3)
			$delcurfule = UBound($splw)
			For $i = 0 To $delcurfule - 1
				$oneP += $i
				FileDelete($splw[$i])
				$iPercData = Floor($oneP / $delcurfule * 100)
				GUICtrlSetData($iPercId, $iPercData)
			Next
		EndIf
		If $sBackupFiles <> '' Then
			$splw = StringSplit($sBackupFiles, @LF, 3)
			$delcurfule = UBound($splw)
			For $i = 0 To $delcurfule - 1
				$oneP += $i
				FileMove($splw[$i], StringTrimRight($splw[$i], 4), 1)
				$iPercData = Floor($oneP / $delcurfule * 100)
				GUICtrlSetData($iPercId, $iPercData)
			Next
		EndIf
		If $oSNW.Exists('page' & $CurGui + 1) Then _PAGEBN(1)
		$iPercData = 0
		GUICtrlSetData($iPercId, $iPercData)
		AdlibUnRegister('PlayAnim')
		Switch $error
			Case -1, -2
				If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[6])
				$iPercData = 0
				GUICtrlSetData($iPercId, $iPercData)
				$flinstset = 0
				$clip = ''
				Dim $ALLTTF[0]
				Dim $exmods[0]
				Dim $sNameMod[0]
				Return MsgBox(16, '', $Instjmplang[7] & @CRLF & $Instjmplang[8] & ' - ' & $error, 0, $WOTP)
			Case 1
				If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[6])
				$iPercData = 0
				GUICtrlSetData($iPercId, $iPercData)
				$flinstset = 0
				$clip = ''
				Dim $ALLTTF[0]
				Dim $exmods[0]
				Dim $sNameMod[0]
				Return
		EndSwitch
	EndIf
	_COPYMODS()
	If @error Then
		Local $splw, $error = @error, $oneP, $delcurfule
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[5])
		If $aWrex <> '' Then
			$splw = StringSplit($aWrex, @LF, 3)
			$delcurfule = UBound($splw)
			For $i = 0 To $delcurfule - 1
				$oneP += $i
				FileDelete($splw[$i])
				$iPercData = Floor($oneP / $delcurfule * 100)
				GUICtrlSetData($iPercId, $iPercData)
			Next
		EndIf
		If $sBackupFiles <> '' Then
			$splw = StringSplit($sBackupFiles, @LF, 3)
			$delcurfule = UBound($splw)
			For $i = 0 To $delcurfule - 1
				$oneP += $i
				FileMove($splw[$i], StringTrimRight($splw[$i], 4), 1)
				$iPercData = Floor($oneP / $delcurfule * 100)
				GUICtrlSetData($iPercId, $iPercData)
			Next
		EndIf
		$iPercData = 0
		GUICtrlSetData($iPercId, $iPercData)
		If $oSNW.Exists('page' & $CurGui + 1) Then _PAGEBN(1)
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[6])
		AdlibUnRegister('PlayAnim')
		Switch $error
			Case -1, -2
				MsgBox(16, '', $Instjmplang[9] & @CRLF & $Instjmplang[8] & ' - ' & $error, 0, $WOTP)
		EndSwitch
	Else
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[10])
		Local $gtprname = StringStripWS(FileGetVersion($PathSFX, 'ProductName'), 3)
		Local $unmod, $unico
		If $gtprname = '' Then
			$unmod = $setpathgame & '\ModPack ' & $sNameG & ' ' & $VerGameInst
			If FileExists($unmod) Then DirRemove($unmod, 1)
			$gtprname = 'ModPack ' & $sNameG & ' ' & $VerGameInst
		Else
			$unmod = $setpathgame & '\' & $gtprname
			If FileExists($unmod) Then DirRemove($unmod, 1)
		EndIf
		DirCreate($unmod)
		FileCopy($wkdir & '\AutoIt3.exe', $unmod & '\AutoIt3.exe', 1)
		FileCopy($wkdir & '\unmod.a3x', $unmod & '\unmod.a3x', 1)
		FileCopy($wkdir & '\unmod.png', $unmod & '\unmod.png', 1)
		FileCopy($wkdir & '\lang.txt', $unmod & '\lang.txt', 1)
		Local $aver[3][2] = [['1', $setpathgame], ['2', $gtprname], ['3', $VerGameInst]]
		IniWriteSection($unmod & '\unmod.ini', 'pathgm', $aver, 0)
		If $aWrex <> '' Then
			FileWrite($unmod & '\Dfile.ini', $aWrex)
		EndIf
		If $sBackupFiles <> '' Then
			FileWrite($unmod & '\Bfile.ini', $sBackupFiles)
		EndIf
		If FileExists($wkdir & '\uninst.ico') Then
			FileCopy($wkdir & '\uninst.ico', $unmod & '\uninst.ico', 1)
			$unico = $unmod & '\uninst.ico'
		Else
			$unico = $unmod & '\AutoIt3.exe'
		EndIf
		FileCreateShortcut($unmod & '\AutoIt3.exe', @DesktopDir & '\' & $gtprname & '.lnk', $unmod, '"unmod.a3x"', $Instjmplang[11] & ' ' & $gtprname, $unico)
	EndIf
	AdlibUnRegister('PlayAnim')
	If $oSNW.Exists('page' & $CurGui + 1) Then _PAGEBN(1)
	If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[12])
	$iPercData = 0
	GUICtrlSetData($iPercId, $iPercData)
	$flinstset = 0
	$clip = ''
	Dim $ALLTTF[0]
	Dim $exmods[0]
	Dim $sNameMod[0]
EndFunc   ;==>_INST
;~ $aDataZipPos - array is written during compilation
Func _EXMOD()
	If UBound($exmods) = 0 Then Return
	If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[13])
	_ExtractFiles($exmods, $wkdir, $aDataZipPos, @ScriptFullPath)
	If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[14])
	$sListModsF = StringTrimRight($sListModsF, 1)
	Local $SplLf = StringSplit($sListModsF, @LF), $aszFileName, $GetCountPath, $sStringPathBlitz
	For $i = 1 To $SplLf[0]
		If StringInStr($SplLf[$i], 'Data\') Then
			$sStringPathBlitz &= $setpathgame & '\' & $SplLf[$i] & @LF
		ElseIf StringInStr($SplLf[$i], 'Packs\') Then
			$sStringPathBlitz &= $Blitz_Packs & '\' & $SplLf[$i] & @LF
		EndIf
		$iPercData = Floor($i / $SplLf[0] * 100)
		GUICtrlSetData($iPercId, $iPercData)
	Next
	$sStringPathBlitz = StringTrimRight($sStringPathBlitz, 1)
	$aszFileName = StringSplit($sStringPathBlitz, @LF, 3)
	If $aszFileName[0] = '' Then Return SetError(-5)
	If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[15])
	Local $nCountMvF = UBound($aszFileName) - 1
	For $i = 0 To $nCountMvF
		If $stoppr Then
			$stoppr = 0
			Return SetError(1)
		EndIf
		If FileExists($aszFileName[$i]) Then
			FileMove($aszFileName[$i], $aszFileName[$i] & 'jmp3', 1)
			$sBackupFiles &= $aszFileName[$i] & 'jmp3' & @LF
		EndIf
		$aWrex &= $aszFileName[$i] & @LF
		$iPercData = Floor($i / $nCountMvF * 100)
		GUICtrlSetData($iPercId, $iPercData)
	Next
	$iPercData = 100
	GUICtrlSetData($iPercId, $iPercData)
	Sleep(500)
EndFunc   ;==>_EXMOD
Func _COPYMODS()
	Local $aProgperc[UBound($exmods)], $allsizearc, $curmods
	For $i = 0 To UBound($exmods) - 1
		$allsizearc += FileGetSize($wkdir & '\' & $exmods[$i])
	Next
	Local $OneAllPerc = $allsizearc / 100
	For $i = 0 To UBound($exmods) - 1
		$curmods = FileGetSize($wkdir & '\' & $exmods[$i])
		$aProgperc[$i] = $curmods / $OneAllPerc
	Next
	Local $curentPerc = 0, $percpart
	$iPercData = 0
	GUICtrlSetData($iPercId, $iPercData)
	Local $pr7za, $7zRead, $7zproc
	For $i = 0 To UBound($exmods) - 1
		$percpart = 100 / $aProgperc[$i]
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $sNameMod[$i])
		$7zRead = ''
		$pr7za = Run($7zaPath & ' x -bsp2 -pshooting_at_slip "' & $wkdir & '\' & $exmods[$i] & '" -o"' & $setpathgame & '"' & ' -y -r- -aoa -i!Data', '', @SW_HIDE, 0x8)
		If @error Then Return SetError(-1)
		While Sleep(1)
			If $stoppr Then
				$stoppr = 0
				ProcessClose($pr7za)
				Return SetError(1)
			EndIf
			$7zRead = StdoutRead($pr7za)
			If @error Then
				ProcessClose($pr7za)
				ExitLoop 1
			EndIf
			If $7zRead <> '' Then
				If StringInStr($7zRead, 'System ERROR') Then
					FileWrite(@ScriptDir & '\Error7z.txt', 'copymod' & @CRLF & $7zRead & @CRLF & $7zaPath & ' ' & $exmods[$i] & ' "' & $setpathgame & '"' & @CRLF)
					Return SetError(-2)
				EndIf
				$7zproc = Number(StringRegExpReplace($7zRead, '(.*?)%.*', '\1'))
				If $7zproc > 0 Then
					$iPercData = $7zproc / $percpart + $curentPerc
					GUICtrlSetData($iPercId, $iPercData)
				EndIf
			EndIf
		WEnd
		$pr7za = Run($7zaPath & ' x -bsp2 -pshooting_at_slip "' & $wkdir & '\' & $exmods[$i] & '" -o"' & $Blitz_Packs & '"' & ' -y -r- -aoa -i!Packs', '', @SW_HIDE, 0x8)
		If @error Then Return SetError(-1)
		While Sleep(1)
			If $stoppr Then
				$stoppr = 0
				ProcessClose($pr7za)
				Return SetError(1)
			EndIf
			$7zRead = StdoutRead($pr7za)
			If @error Then
				ProcessClose($pr7za)
				ExitLoop 1
			EndIf
			If $7zRead <> '' Then
				If StringInStr($7zRead, 'System ERROR') Then
					FileWrite(@ScriptDir & '\Error7z.txt', 'copymod' & @CRLF & $7zRead & @CRLF & $7zaPath & ' ' & $exmods[$i] & ' "' & $Blitz_Packs & '"' & @CRLF)
					Return SetError(-2)
				EndIf
				$7zproc = Number(StringRegExpReplace($7zRead, '(.*?)%.*', '\1'))
				If $7zproc > 0 Then
					$iPercData = $7zproc / $percpart + $curentPerc
					GUICtrlSetData($iPercId, $iPercData)
				EndIf
			EndIf
		WEnd
		$curentPerc += $aProgperc[$i]
	Next
	$iPercData = 100
	GUICtrlSetData($iPercId, $iPercData)
	Sleep(500)
	If UBound($ALLTTF) > 0 Then
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[16])
		For $i = 0 To UBound($ALLTTF) - 1
			_FontInstall($ALLTTF[$i])
			$iPercData = Floor($i / (UBound($ALLTTF) - 1) * 100)
			GUICtrlSetData($iPercId, $iPercData)
		Next
		$iPercData = 100
		GUICtrlSetData($iPercId, $iPercData)
		Sleep(500)
	EndIf
	If FileExists($wkdir & '\rwconf.txt') Then
		If $oMod.Exists('info' & $CurGui) Then GUICtrlSetData($oMod.Item('info' & $CurGui), $Instjmplang[17])
		_RWCONF($clip)
		If @error Then Return SetError(@error)
	EndIf
EndFunc   ;==>_COPYMODS
Func _RWCONF($sCHK)
	$sCHK = StringTrimRight($sCHK, 2)
	If $sCHK == '' Then
		Return SetError(-1)
	EndIf
	Local $setconf = $wkdir & '\rwconf.txt'
	Local $aArrays[0][3], $rdcel, $rdpt, $flenc, $fo
	Local $flarsh, $rd, $d = 0
	Local $spls = StringSplit($sCHK, @CRLF, 3)
	For $i = 0 To UBound($spls) - 1
		$rdpt = IniRead($setconf, 'path', $spls[$i], '')
		If $rdpt <> '' Then
			If FileExists($setpathgame & '\' & $rdpt) Then
				For $s = 0 To UBound($aArrays) - 1
					If Not StringCompare($rdpt, $aArrays[$s][0]) Then $flarsh = 1
				Next
				If Not $flarsh Then
					$flenc = FileGetEncoding($setpathgame & '\' & $rdpt)
					$fo = FileOpen($setpathgame & '\' & $rdpt, $flenc)
					$rdcel = FileReadToArray($fo)
					FileClose($fo)
					If Not IsArray($rdcel) Then
						MsgBox(16, '1', $Instjmplang[18] & @CRLF & $setpathgame & '\' & $rdpt, 0, $WOTP)
						Return SetError(1)
					EndIf
					ReDim $aArrays[$rd + 1][3]
					$aArrays[$d][0] = $rdpt
					$aArrays[$d][1] = $flenc
					$aArrays[$d][2] = $rdcel
					$rd += 1
					$d += 1
				Else
					$flarsh = 0
				EndIf
			Else
				MsgBox(16, '2', $Instjmplang[19] & @CRLF & $setpathgame & '\' & $rdpt, 0, $WOTP)
				Return SetError(2)
			EndIf
		EndIf
	Next
	Local $rsfr, $arf, $cstr, $ind
	For $i = 0 To UBound($spls) - 1
		$rdpt = IniRead($setconf, 'path', $spls[$i], '')
		If $rdpt <> '' Then
			For $s = 0 To UBound($aArrays) - 1
				If Not StringCompare($rdpt, $aArrays[$s][0]) Then
					$ind = $s
					$arf = $aArrays[$s][2]
				EndIf
			Next
			$rsfr = IniReadSection($setconf, $spls[$i])
			If Not @error Then
				For $r = 1 To $rsfr[0][0]
					$cstr = StringTrimRight($rsfr[$r][1], 6)
					Switch StringRight($rsfr[$r][1], 1)
						Case '0'
							$arf[Number($rsfr[$r][0]) - 1] = $arf[Number($rsfr[$r][0]) - 1] & @CRLF & StringReplace($cstr, '&jmp&', @CRLF)
							$aArrays[$ind][2] = $arf
						Case '1'
							$arf[Number($rsfr[$r][0]) - 1] = StringReplace($cstr, '&jmp&', @CRLF)
							$aArrays[$ind][2] = $arf
					EndSwitch
				Next
			EndIf
		EndIf
	Next
	Local $newtxt
	For $i = 0 To UBound($aArrays) - 1
		$newtxt = _ArrayToString($aArrays[$i][2], @CRLF)
		$fo = FileOpen($setpathgame & '\' & $aArrays[$i][0], $aArrays[$i][1] + 2)
		If $fo = -1 Then
			MsgBox(16, '3', $Instjmplang[20] & @CRLF & $setpathgame & '\' & $aArrays[$i][0], 0, $WOTP)
			Return SetError(3)
		EndIf
		FileWrite($fo, $newtxt)
		FileClose($fo)
	Next
EndFunc   ;==>_RWCONF
Func _FontInstall($sFile)
	Local $Font, $sName, $Path
	$sName = _WinAPI_GetFontResourceInfo($sFile, 1)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	$sName &= ' (TrueType)'
	$Font = StringRegExpReplace($sFile, '^.*\\', '')
	If Not RegWrite('HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts', $sName, 'REG_SZ', $Font) Then
		Return SetError(2, 0, 0)
	EndIf
	$Path = _WinAPI_ShellGetSpecialFolderPath($CSIDL_FONTS)
	If Not FileCopy($sFile, $Path, 1) Then
		RegDelete('HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts', $sName)
		Return SetError(3, 0, 0)
	EndIf
	If Not _WinAPI_AddFontResourceEx($Path & '\' & $Font, 0, 1) Then
		Return SetError(4, 0, 0)
	EndIf
	Return 1
EndFunc   ;==>_FontInstall
Func _GUITreeViewEx_Scroll($nParam)
	Local $dvis, $Hit, $vc, $gt, $prch, $visf, $getparam, $sGV = ''
	Local $CursorInfoW = GUIGetCursorInfo($WOTP)
	If Not @error Then
		If $objc.Exists($CursorInfoW[4]) Then
			$getparam = $objc.Item($CursorInfoW[4])
			If IsArray($getparam) Then $sGV = String($getparam[1])
		EndIf
		If GUICtrlGetHandle($CursorInfoW[4]) = $g_GTVEx_aTVData Or $sGV == 'bck0' Then
			$visf = _GUICtrlTreeView_GetFirstVisible($g_GTVEx_aTVData)
			Switch $nParam
				Case 120
					$prch = _GUICtrlTreeView_GetPrev($g_GTVEx_aTVData, $visf)
					_GUICtrlTreeView_EnsureVisible($g_GTVEx_aTVData, $prch)
				Case -120
					$Hit = _GUICtrlTreeView_GetHeight($g_GTVEx_aTVData)
					$vc = _GUICtrlTreeView_GetVisibleCount($g_GTVEx_aTVData) * $Hit - 1
					$gt = _GUICtrlTreeView_HitTestItem($g_GTVEx_aTVData, 0, $vc)
					$dvis = _GUICtrlTreeView_GetNext($g_GTVEx_aTVData, $gt)
					If Not $dvis Then Return
					_GUICtrlTreeView_EnsureVisible($g_GTVEx_aTVData, $dvis)
			EndSwitch
		EndIf
	EndIf
EndFunc   ;==>_GUITreeViewEx_Scroll
Func WM_MOUSEWHEEL($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam
	Local $nParam = BitShift($wParam, 16)
	_GUITreeViewEx_Scroll($nParam)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_MOUSEWHEEL
Func _GetInfoModTV()
	$sListModsF = ''
	Local $aInfSetMod, $agettvx, $infpg
	$agettvx = _GUITreeViewEx_GetTVX()
	For $i = (UBound($agettvx) - 1) To 0 Step -1
		$infpg = _GUITreeViewEx_SaveTV(HWnd($agettvx[$i]))
		If @error Then ContinueLoop
		For $pg = 0 To UBound($infpg) - 1
			$aInfSetMod = _GUITreeViewEx_GetItemData(HWnd($agettvx[$i]), $infpg[$pg][1])
			If @error Then ContinueLoop
			Switch Number($infpg[$pg][2])
				Case 1
					$clip &= $infpg[$pg][1] & @CRLF
					If Not (String($aInfSetMod[18]) == '0') Then
						_Array_Add($exmods, $infpg[$pg][1] & '.7z')
						If FileExists($wkdir & '\' & $infpg[$pg][1] & '.txt') Then $sListModsF &= FileRead($wkdir & '\' & $infpg[$pg][1] & '.txt') & @LF
						_Array_Add($sNameMod, $infpg[$pg][0])
					EndIf
					If Not (String($aInfSetMod[21]) == '0') Then
						If FileExists($wkdir & '\' & $infpg[$pg][1] & '.ttf') Then
							_Array_Add($ALLTTF, $wkdir & '\' & $infpg[$pg][1] & '.ttf')
						ElseIf FileExists($wkdir & '\' & $infpg[$pg][1] & '.otf') Then
							_Array_Add($ALLTTF, $wkdir & '\' & $infpg[$pg][1] & '.otf')
						EndIf
					EndIf
			EndSwitch
		Next
	Next
EndFunc   ;==>_GetInfoModTV
Func _CreateTVLoad()
	Local $backwinpic, $aINFCTRL, $WoTchild, $hLoadTV, $aGetObj, $objcfp, $gf, $nATV = UBound($aLoadTV) - 1
	For $i = $nATV To 0 Step -1
		$aINFCTRL = $aLoadTV[$i][0]
		$backwinpic = GUICtrlCreatePic('', $aINFCTRL[2], $aINFCTRL[3], $aINFCTRL[4], $aINFCTRL[5])
		DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($backwinpic), 'wstr', '', 'wstr', '')
		_SetImage($backwinpic, $imgbackw, $aINFCTRL[4], $aINFCTRL[5], -1)
		GUICtrlSetPos($backwinpic, $aINFCTRL[2], $aINFCTRL[3], $aINFCTRL[4], $aINFCTRL[5])
		$aGetObj = $oSNW.Item('page' & $aLoadTV[$i][1])
		$objcfp = $aGetObj[1]
		$aINFCTRL[0] = 'pic'
		$aINFCTRL[1] = 'bck0'
		$aINFCTRL[9] = 64
		$objcfp.Add($backwinpic, $aINFCTRL)
		GUICtrlSetState($backwinpic, 64)
		If $aLoadTV[$i][1] > 0 Then GUICtrlSetState($backwinpic, $GUI_HIDE)
	Next
	For $i = $nATV To 0 Step -1
		$aINFCTRL = $aLoadTV[$i][0]
		$WoTchild = GUICreate("", $aINFCTRL[4], $aINFCTRL[5], $aINFCTRL[2], $aINFCTRL[3], $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $WOTP)
		GUISetBkColor(0x000000, $WoTchild)
		$hLoadTV = GUICtrlCreateTreeView(0, 0, $aINFCTRL[4] + 18, $aINFCTRL[5], BitOR($TVS_DISABLEDRAGDROP, $TVS_NOHSCROLL, $TVS_NOTOOLTIPS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_HASBUTTONS))
;~ 		DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($hLoadTV), 'wstr', '', 'wstr', '')
		$gf = StringSplit($aINFCTRL[8], '!')
		GUICtrlSetFont($hLoadTV, $gf[1], $gf[2], $gf[3], $gf[4])
		GUICtrlSetColor($hLoadTV, $aINFCTRL[10])
		GUICtrlSetBkColor($hLoadTV, 0x000000)
		$aGetObj = $oSNW.Item('page' & $aLoadTV[$i][1])
		$objcfp = $aGetObj[1]
		$aINFCTRL[0] = 'treeview'
		$aINFCTRL[1] = $WoTchild
		$aINFCTRL[2] = 0
		$aINFCTRL[3] = 0
		$aINFCTRL[9] = 64
		$objcfp.Add($hLoadTV, $aINFCTRL)
		_GUITreeViewEx_InitTV($hLoadTV)
		_GUITreeViewEx_TvImg($hLoadTV, $aIco)
		_GUITreeViewEx_LoadTV($hLoadTV, $wkdir & '\page' & $aLoadTV[$i][1] & '.jmp3', 'TV', 'TV', $iCHLangPJ, '{lang}')
		If $aLoadTV[$i][1] > 0 Then
			GUISetState(@SW_HIDE, $WoTchild)
		Else
			$flpgtv = 1
			GUISetState(@SW_SHOW, $WoTchild)
		EndIf
		_WinAPI_SetLayeredWindowAttributes($WoTchild, 0x000000, 255)
	Next
EndFunc   ;==>_CreateTVLoad
Func _LOADPJT()
	Local $agta, $win
	Local $medit, $aGetObj, $gtprc, $rdw, $rdc, $gf
	Local $setmedit, $asetmap[2]
	Local $aPage = _FFSearch($wkdir, 'jmp3', 3, 1, 2)
	If @error Then
		_StopSound()
		MsgBox(16, @error, $Instjmplang[23])
		Run('cmd.exe /C rmdir /S /Q "' & @TempDir & '\wkdirjmp3' & '"', '', @SW_HIDE)
		Exit
	EndIf
	For $i = 0 To UBound($aPage) - 1
		_PageCreate($oSNW, 'page' & $i)
		$aGetObj = $oSNW.Item('page' & $i)
		$objw = $aGetObj[0]
		$objc = $aGetObj[1]
		$rdw = IniReadSection($wkdir & '\page' & $i & '.jmp3', 'Windows')
		If Not @error Then
			For $r = 1 To $rdw[0][0]
				$agta = StringSplit($rdw[$r][1], '<>', 3)
				For $cw = 0 To 4
					$agta[$cw] = Number($agta[$cw])
				Next
				$objw.Add(Number($rdw[$r][0]), $agta)
			Next
		Else
			GUIDelete($WOTP)
			_StopSound()
			MsgBox(16, '10', $Instjmplang[23])
			Run('cmd.exe /C rmdir /S /Q "' & @TempDir & '\wkdirjmp3' & '"', '', @SW_HIDE)
			Exit
		EndIf
		If $i = 0 Then
			$win = $objw.Item(0)
			$WOTP = GUICreate('', $win[2], $win[3], -1, -1, $WS_POPUP, $WS_EX_LAYERED)
			GUISetBkColor($win[4], $WOTP)
			_WinAPI_SetLayeredWindowAttributes($WOTP, 50, 255)
		EndIf
		$rdc = IniReadSection($wkdir & '\page' & $i & '.jmp3', 'Controls')
		If Not @error Then
			For $c = 1 To $rdc[0][0]
				$agta = StringSplit($rdc[$c][1], '<>', 3)
				$agta[2] = Number($agta[2])
				$agta[3] = Number($agta[3])
				$agta[4] = Number($agta[4])
				$agta[5] = Number($agta[5])
				$agta[6] = Number($agta[6])
				$agta[7] = Number($agta[7])
				$agta[9] = Number($agta[9])
				$agta[10] = Number($agta[10])
				$agta[11] = Number($agta[11])
				If String($agta[12]) == '0' Then $agta[12] = 0
				$agta[13] = Number($agta[13])
				Switch String($agta[0])
					Case 'mod'
						$agta[14] = Number($agta[14])
					Case Else
						Switch String($agta[14])
							Case 'clmods'
								If Number($agta[15]) = 1 Then $flclmods = 1
							Case 'clresmods'
								If Number($agta[15]) = 1 Then $flclresmods = 1
							Case 'backup'
								If Number($agta[15]) = 1 Then $flbackup = 1
							Case 'clmrm'
								If Number($agta[15]) = 1 Then $flclmrm = 1
							Case '0'
								$agta[14] = 0
							Case 'chpage'
								$agta[15] = Number($agta[15])
						EndSwitch
				EndSwitch
				If $agta[16] == '0' Then $agta[16] = 0
				$agta[17] = Number($agta[17])
				If $agta[18] == '0' Then $agta[18] = 0
				If $agta[19] == '0' Then $agta[19] = 0
				If $agta[20] == '0' Then $agta[20] = 0
				If $agta[21] == '0' Then $agta[21] = 0
				If $agta[22] == '0' Then $agta[22] = 0
				$agta[23] = Number($agta[23])
				$agta[25] = Number($agta[25])
				Local $funcid = 0
				Switch String($agta[0])
					Case 'treeview'
						_ArrayAdd($aLoadTV, '')
						$aLoadTV[UBound($aLoadTV) - 1][0] = $agta
						$aLoadTV[UBound($aLoadTV) - 1][1] = $i
						$nExistsTV = $i
					Case 'label'
						$medit = StringReplace($agta[1], '\n', @CRLF)
						$medit = StringReplace($medit, '\h', ' ')
						$medit = StringSplit($medit, '{lang}', 1)
						If $medit[0] >= $iCHLangPJ Then
							$setmedit = $medit[$iCHLangPJ]
						Else
							$setmedit = $medit[1]
						EndIf
						$funcid = GUICtrlCreateLabel($setmedit, $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
						DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($funcid), 'wstr', '', 'wstr', '')
						If $agta[14] == 'txt' Then $oMod.Add('txt' & $i, $funcid)
						If $agta[14] == 'info' Then $oMod.Add('info' & $i, $funcid)
						If $agta[14] == 'path' Then $oMod.Add('path', $funcid)
						$gf = StringSplit($agta[8], '!')
						If $gf[0] > 1 Then GUICtrlSetFont($funcid, $gf[1], $gf[2], $gf[3], $gf[4])
						GUICtrlSetColor($funcid, $agta[10])
						GUICtrlSetBkColor($funcid, $agta[11])
					Case 'mod'
						$agta[15] = Number($agta[15])
						If $agta[15] Then
							Local $gettp = $oMod.Item($agta[15])
							$gettp = $objc.Item($gettp)
							If $gettp[17] Then
								$funcid = GUICtrlCreateRadio($agta[1], $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
								If StringRight($gettp[16], StringLen($agta[14])) = $agta[14] Then GUIStartGroup()
							Else
								$funcid = GUICtrlCreateCheckbox($agta[1], $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
								If StringRight($gettp[16], StringLen($agta[14])) = $agta[14] Then GUIStartGroup()
								If $agta[17] Then GUIStartGroup()
							EndIf
						Else
							$funcid = GUICtrlCreateCheckbox($agta[1], $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
							If $agta[17] Then GUIStartGroup()
						EndIf
						DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($funcid), 'wstr', '', 'wstr', '')
						$oMod.Add(Number($agta[14]), $funcid)
						GUICtrlSetState($funcid, $agta[23])
						GUICtrlSetState($funcid, $agta[25])
						$medit = StringReplace($agta[1], '\n', @CRLF)
						$medit = StringReplace($medit, '\h', ' ')
						$medit = StringSplit($medit, '{lang}', 1)
						If $medit[0] >= $iCHLangPJ Then
							$setmedit = $medit[$iCHLangPJ]
						Else
							$setmedit = $medit[1]
						EndIf
						$gf = StringSplit($agta[8], '!')
						If $gf[0] > 1 Then GUICtrlSetFont($funcid, $gf[1], $gf[2], $gf[3], $gf[4])
						GUICtrlSetData($funcid, $setmedit)
						GUICtrlSetColor($funcid, $agta[10])
						GUICtrlSetBkColor($funcid, $agta[11])
					Case 'checkbox'
						$funcid = GUICtrlCreateCheckbox($agta[1], $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
						DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($funcid), 'wstr', '', 'wstr', '')
						If Not ($agta[15] == '0') Then GUICtrlSetState($funcid, Number($agta[15]))
						GUICtrlSetState($funcid, $agta[25])
						$medit = StringReplace($agta[1], '\n', @CRLF)
						$medit = StringReplace($medit, '\h', ' ')
						$medit = StringSplit($medit, '{lang}', 1)
						If $medit[0] >= $iCHLangPJ Then
							$setmedit = $medit[$iCHLangPJ]
						Else
							$setmedit = $medit[1]
						EndIf
						GUICtrlSetData($funcid, $setmedit)
						$gf = StringSplit($agta[8], '!')
						If $gf[0] > 1 Then GUICtrlSetFont($funcid, $gf[1], $gf[2], $gf[3], $gf[4])
						GUICtrlSetColor($funcid, $agta[10])
						GUICtrlSetBkColor($funcid, $agta[11])
						Switch $agta[14]
							Case 'backauset', 'ausetmod'
								$PlayCheck = 1
						EndSwitch
					Case 'progress'
						Switch $agta[24]
							Case 'barA'
								$funcid = GUICtrlCreatePic('', $agta[2], $agta[3], $agta[4], $agta[5])
								GUICtrlSetColor($funcid, $agta[11])
								GUICtrlSetBkColor($funcid, $agta[10])
							Case 'barSC'
								$SelectProgressbar = 1
								$funcid = GUICtrlCreateProgress($agta[2], $agta[3], $agta[4], $agta[5])
								DllCall('UxTheme.dll', 'uint', 'SetWindowTheme', 'hwnd', GUICtrlGetHandle($funcid), 'wstr', '', 'wstr', '')
								GUICtrlSetColor($funcid, $agta[11])
								GUICtrlSetBkColor($funcid, $agta[10])
							Case 'barS'
								$SelectProgressbar = 1
								$funcid = GUICtrlCreateProgress($agta[2], $agta[3], $agta[4], $agta[5])
						EndSwitch
						$WPerc = $agta[4]
						$HPerc = $agta[5]
						$BgColorGui = $agta[10]
						$FgBGColor = $agta[11]
						$BGColor = Number($agta[12])
						$TextBGColor = $agta[7]
						$sFontProgress = $agta[8]
						$iVisPerc = $agta[6]
						$oMod.Add('perc', $funcid)
						$iPercId = $funcid
					Case 'pic'
						If $agta[14] == 'pic' Then
							$funcid = GUICtrlCreatePic('', $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
							$oMod.Add('pic' & $i, $funcid)
						Else
							Local $imsetp = $wkdir & '\' & $agta[12]
							If FileExists($wkdir & '\' & $agta[12]) Then
								$funcid = GUICtrlCreatePic('', $agta[2], $agta[3], $agta[4], $agta[5], $agta[6], $agta[7])
								_SetImage($funcid, $imsetp, $agta[4], $agta[5], -1)
								GUICtrlSetPos($funcid, $agta[2], $agta[3], $agta[4], $agta[5])
							EndIf
						EndIf
						Switch $agta[14]
							Case 'backauset', 'ausetmod'
								$PlayPic = 1
						EndSwitch
				EndSwitch
				If Not $funcid Then ContinueLoop
				GUICtrlSetResizing($funcid, $agta[13])
				Switch String($agta[14])
					Case 'backauset', 'ausetmod'
						If $oMod.Exists($agta[14]) Then
							$gtprc = $oMod.Item($agta[14])
							_ArrayAdd($gtprc, $funcid)
							$oMod.Item($agta[14]) = $gtprc
						Else
							Local $aperc[1] = [$funcid]
							$oMod.Add($agta[14], $aperc)
						EndIf
				EndSwitch
				If $agta[9] Then GUICtrlSetState($funcid, $agta[9])
				If $i > 0 Then GUICtrlSetState($funcid, $GUI_HIDE)
				$objc.Add($funcid, $agta)
			Next
		Else
			GUIDelete($WOTP)
			_StopSound()
			MsgBox(16, 'error', $Instjmplang[24])
			Run('cmd.exe /C rmdir /S /Q "' & @TempDir & '\wkdirjmp3' & '"', '', @SW_HIDE)
			Exit
		EndIf
		_WinAPI_SetLayeredWindowAttributes($WOTP, 50, 255)
	Next
	_WinAPI_RedrawWindow($WOTP)
	_WinAPI_UpdateWindow($WOTP)
	_Middle($WOTP, $win[2], $win[3])
	$CurGui = 0
	$objw = $oSNW.Item('page' & $CurGui)[0]
	$objc = $oSNW.Item('page' & $CurGui)[1]
EndFunc   ;==>_LOADPJT
Func _Middle($win, $wd, $ht)
	Local $y = (@DesktopHeight / 2) - ($ht / 2)
	Local $x = (@DesktopWidth / 2) - ($wd / 2)
	WinMove($win, '', $x, $y, $wd, $ht)
EndFunc   ;==>_Middle
Func _PAGEBN($FL = 0)
	Local $nPageC = $CurGui
	If $curidpos Then
		Local $setoldid = $objc.Item($curidpos)
		If $backlight = 2 Then
			Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
			Switch String($setoldid[0])
				Case 'label', 'checkbox'
					Local $setnewid = StringSplit($setoldid[8], '!')
					GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
			EndSwitch
			GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
		ElseIf $backlight = 3 Then
			If IsArray($setoldid) Then
				Switch String($setoldid[0])
					Case 'label', 'checkbox'
						GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
				EndSwitch
			EndIf
		EndIf
		$curidpos = 0
	EndIf
	Local $aKeys
	If $FL = 0 Then
		$CurGui -= 1
	ElseIf $FL = 1 Then
		$CurGui += 1
	EndIf
	Local $ctrlstate
	If $FL < 2 Then
		$aKeys = $objc.Keys()
		For $i In $aKeys
			$flpg = 0
			$ctrlstate = $objc.Item($i)
			If UBound($ctrlstate) = 26 Then
				If $ctrlstate[0] == 'treeview' Then
					$flpgtv = 0
					GUISetState(@SW_HIDE, $ctrlstate[1])
					ContinueLoop
				EndIf
				GUICtrlSetState($i, $GUI_HIDE)
			EndIf
		Next
	EndIf
	$objw = $oSNW.Item('page' & $CurGui)[0]
	$objc = $oSNW.Item('page' & $CurGui)[1]
	Local $win = $objw.Item(0)
	GUISetBkColor($win[4], $WOTP)
	Local $wpos = WinGetPos($WOTP)
	WinMove($WOTP, '', $wpos[0], $wpos[1], $win[2], $win[3])
	$aKeys = $objc.Keys()
	For $i In $aKeys
		$flpg = 1
		$ctrlstate = $objc.Item($i)
		If UBound($ctrlstate) = 26 Then
			If $ctrlstate[0] == 'treeview' Then
				_GUITreeViewEx_InitTV($i)
				$flpgtv = 1
				GUISetState(@SW_SHOW, $ctrlstate[1])
				ContinueLoop
			EndIf
			GUICtrlSetState($i, Number($ctrlstate[25]))
		EndIf
	Next
;~ 	_WinAPI_SetLayeredWindowAttributes($WOTP, 50, 255)
EndFunc   ;==>_PAGEBN
Func _PAGECH($cpg)
	Local $setoldid
	If $oSNW.Exists('page' & $cpg) Then
		If $CurGui <> $cpg Then
			If $curidpos Then
				$setoldid = $objc.Item($curidpos)
				If UBound($setoldid) = 26 Then
					If $backlight = 2 Then
						Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
						Switch String($setoldid[0])
							Case 'label', 'checkbox'
								Local $setnewid = StringSplit($setoldid[8], '!')
								GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
						EndSwitch
						GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
					ElseIf $backlight = 3 Then
						Switch String($setoldid[0])
							Case 'label', 'checkbox'
								GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
						EndSwitch
					EndIf
				EndIf
				$curidpos = 0
			EndIf
			Local $aKeys, $ctrlstate
			$aKeys = $objc.Keys()
			For $i In $aKeys
				$flpg = 0
				$ctrlstate = $objc.Item($i)
				If UBound($ctrlstate) = 26 Then
					If $ctrlstate[0] == 'treeview' Then
						$flpgtv = 0
						GUISetState(@SW_HIDE, $ctrlstate[1])
						ContinueLoop
					EndIf
					GUICtrlSetState($i, $GUI_HIDE)
				EndIf
			Next
			$objw = $oSNW.Item('page' & $cpg)[0]
			$objc = $oSNW.Item('page' & $cpg)[1]
			Local $win = $objw.Item(0)
			GUISetBkColor($win[4], $WOTP)
			Local $wpos = WinGetPos($WOTP)
			WinMove($WOTP, '', $wpos[0], $wpos[1], $win[2], $win[3])
			$aKeys = $objc.Keys()
			For $i In $aKeys
				$flpg = 1
				$ctrlstate = $objc.Item($i)
				If UBound($ctrlstate) = 26 Then
					If $ctrlstate[0] == 'treeview' Then
						_GUITreeViewEx_InitTV($i)
						$flpgtv = 1
						GUISetState(@SW_SHOW, $ctrlstate[1])
						ContinueLoop
					EndIf
					GUICtrlSetState($i, Number($ctrlstate[25]))
				EndIf
			Next
			$CurGui = $cpg
;~ 			_WinAPI_SetLayeredWindowAttributes($WOTP, 50, 255)
		EndIf
	EndIf
EndFunc   ;==>_PAGECH
Func WM_ACTIVATE($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $lParam
	Switch BitAND($wParam, 0xFFFF)
		Case 1
			_WinAPI_RedrawWindow($WOTP)
			_WinAPI_UpdateWindow($WOTP)
	EndSwitch
EndFunc   ;==>WM_ACTIVATE
Func WM_SETCURSOR($hWnd, $Msg, $wParam, $lParam)
	#forceref $hWnd, $Msg, $lParam
	Local $nID = _WinAPI_GetDlgCtrlID($wParam)
	Local $getparam = 0, $sgettype
	Switch _WinAPI_HiWord($lParam)
		Case 513
			Switch $wParam
				Case $WOTP
					If $backlight = 2 Then
						If $g_hCursor Then Return _WinAPI_SetCursor($g_hCursor)
					EndIf
				Case Else
					If $nID > 0 Then
						$getparam = $objc.Item($nID)
						If UBound($getparam) = 26 Then
							$UpIdC = $nID
							Switch String($getparam[14])
								Case 'cash', 'clmods', 'clresmods', 'backup', 'clmrm', 'stop', 'next', 'inst', 'back', 'chpath', 'close', 'chpage', 'mini', 'url', 'backauset', 'ausetmod'
									If $backlight = 1 Then
										If $g_hCursorLight Then Return _WinAPI_SetCursor($g_hCursorLight)
									ElseIf $backlight = 2 Then
										If $g_hCursor Then Return _WinAPI_SetCursor($g_hCursor)
									EndIf
							EndSwitch
						EndIf
					EndIf
			EndSwitch
		Case 514
			Switch $wParam
				Case $WOTP
				Case Else
					If $nID > 0 Then
						$getparam = $objc.Item($nID)
						If UBound($getparam) = 26 Then
							If $wParam = $g_GTVEx_aTVData Or $getparam[1] = 'bck0' Then $nflagsetimgtv = 1
							Switch String($getparam[0])
								Case 'pic', 'label'
									If $nID = $UpIdC Then
										Switch String($getparam[14])
											Case 'url'
												ShellExecute($getparam[15])
											Case 'stop'
												$stoppr = 1
											Case 'chpath'
												$flfunc = 'chpath'
											Case 'inst'
												$flfunc = 'inst'
											Case 'mini'
												GUISetState(@SW_MINIMIZE, $WOTP)
											Case 'close'
												$flfunc = 'close'
											Case 'next'
												If Not $flinstset Then
													If $oSNW.Exists('page' & $CurGui + 1) Then _PAGEBN(1)
												EndIf
											Case 'back'
												If Not $flinstset Then
													If $CurGui > 0 Then _PAGEBN()
												EndIf
											Case 'chpage'
												If Not $flinstset Then _PAGECH($getparam[15])
										EndSwitch
									EndIf
							EndSwitch
						EndIf
						$UpIdC = 0
					EndIf
			EndSwitch
		Case 512
			If $nExistsTV = -1 Then
				If $flpg Then _PICTXT($nID)
			Else
				If $flpgtv Then _PICTXTTV()
			EndIf
			If $backlight Then
				Local $setnewid, $setoldid
				Switch $wParam
					Case $WOTP
						If $backlight = 2 Then
							If $curidpos Then
								$setoldid = $objc.Item($curidpos)
								If UBound($setoldid) = 26 Then
									Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
									Switch String($setoldid[0])
										Case 'label', 'checkbox'
											$setnewid = StringSplit($setoldid[8], '!')
											GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
									EndSwitch
									GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
								EndIf
								$curidpos = 0
							EndIf
						EndIf
						If $backlight = 3 Then
							If $curidpos Then
								$setoldid = $objc.Item($curidpos)
								If UBound($setoldid) = 26 Then
									Switch String($setoldid[0])
										Case 'label', 'checkbox'
											GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
									EndSwitch
								EndIf
								$curidpos = 0
							EndIf
						EndIf
						If $g_hCursor Then Return _WinAPI_SetCursor($g_hCursor)
					Case Else
						If $nID > 0 Then
							$getparam = $objc.Item($nID)
							If UBound($getparam) = 26 Then
								Switch String($getparam[14])
									Case 'cash', 'clmods', 'clresmods', 'backup', 'clmrm', 'stop', 'next', 'inst', 'back', 'chpath', 'close', 'chpage', 'mini', 'url', 'backauset', 'ausetmod'
										If $backlight = 2 Then
											Local $gp = ControlGetPos($WOTP, '', $nID)
											Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
											If $curidpos <> $nID Then
												GUICtrlSetPos($nID, $gp[0] - 2, $gp[1] - 2, $gp[2] + 4, $gp[3] + 4)
												Switch String($getparam[0])
													Case 'label', 'checkbox'
														$setnewid = StringSplit($getparam[8], '!')
														GUICtrlSetFont($nID, $setnewid[1] + 2, $setnewid[2], $setnewid[3], $setnewid[4])
												EndSwitch
												If $curidpos Then
													$setoldid = $objc.Item($curidpos)
													If IsArray($setoldid) Then
														Switch String($setoldid[0])
															Case 'label', 'checkbox'
																$setnewid = StringSplit($setoldid[8], '!')
																GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
														EndSwitch
														GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
													EndIf
												EndIf
												$curidpos = $nID
											EndIf
										EndIf
										If $backlight = 3 Then
											If $curidpos <> $nID Then
												Switch String($getparam[0])
													Case 'label', 'checkbox'
														GUICtrlSetBkColor($nID, $backlightcolor)
												EndSwitch
												If $curidpos Then
													$setoldid = $objc.Item($curidpos)
													If UBound($setoldid) = 26 Then
														Switch String($setoldid[0])
															Case 'label', 'checkbox'
																GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
														EndSwitch
													EndIf
												EndIf
												$curidpos = $nID
											EndIf
										EndIf
										If $backlight = 1 Then
											If $g_hCursorLight Then Return _WinAPI_SetCursor($g_hCursorLight)
										EndIf
									Case Else
										If $backlight = 2 Then
											If $curidpos Then
												$setoldid = $objc.Item($curidpos)
												If UBound($setoldid) = 26 Then
													Local $gp1 = ControlGetPos($WOTP, '', $curidpos)
													Switch String($setoldid[0])
														Case 'label', 'checkbox'
															$setnewid = StringSplit($setoldid[8], '!')
															GUICtrlSetFont($curidpos, $setnewid[1], $setnewid[2], $setnewid[3], $setnewid[4])
													EndSwitch
													GUICtrlSetPos($curidpos, $gp1[0] + 2, $gp1[1] + 2, $gp1[2] - 4, $gp1[3] - 4)
												EndIf
												$curidpos = 0
											EndIf
										EndIf
										If $backlight = 3 Then
											If $curidpos Then
												$setoldid = $objc.Item($curidpos)
												If UBound($setoldid) = 26 Then
													Switch String($setoldid[0])
														Case 'label', 'checkbox'
															GUICtrlSetBkColor($curidpos, Number($setoldid[11]))
													EndSwitch
												EndIf
												$curidpos = 0
											EndIf
										EndIf
										If $g_hCursor Then Return _WinAPI_SetCursor($g_hCursor)
								EndSwitch
							EndIf
						EndIf
				EndSwitch
			EndIf
	EndSwitch
	If $g_hCursor Then
		Return _WinAPI_SetCursor($g_hCursor)
	Else
		Return $GUI_RUNDEFMSG
	EndIf
EndFunc   ;==>WM_SETCURSOR
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $ilParam
	Local $FSID, $gtprc, $RFsid, $getparam, $getposauctrl
	$FSID = _WinAPI_LoWord($iwParam)
	Switch $FSID
		Case $FSID > 0
			$getparam = $objc.Item($FSID)
			If IsArray($getparam) Then
				Switch String($getparam[0])
					Case 'mod'
						_CHKPARENT($FSID)
					Case 'checkbox'
						$RFsid = GUICtrlRead($FSID)
						Switch String($getparam[14])
							Case 'cash'
								If $RFsid = 1 Then
									$flclcash = 1
								Else
									$flclcash = 0
								EndIf
							Case 'clmods'
								If $RFsid = 1 Then
									$flclmods = 1
									$flclmrm = 0
								Else
									$flclmods = 0
								EndIf
							Case 'clresmods'
								If $RFsid = 1 Then
									$flclresmods = 1
									$flclmrm = 0
								Else
									$flclresmods = 0
								EndIf
							Case 'clmrm'
								If $RFsid = 1 Then
									$flclmrm = 1
									$flclresmods = 0
									$flclmods = 0
								Else
									$flclmrm = 0
								EndIf
							Case 'backup'
								If $RFsid = 1 Then
									$flbackup = 1
								Else
									$flbackup = 0
								EndIf
							Case 'backauset'
								If $nDiffplayCtrl = 1 Then
									Switch $RFsid
										Case 1
											_BASS_ChannelPause($MusicHandleBck)
										Case 4
											_BASS_ChannelPlay($MusicHandleBck, 0)
									EndSwitch
									$nbackauset = $RFsid
									If $oMod.Exists('backauset') Then
										$gtprc = $oMod.Item('backauset')
										For $i = 0 To UBound($gtprc) - 1
											GUICtrlSetState($gtprc[$i], $nbackauset)
										Next
									EndIf
								EndIf
							Case 'ausetmod'
								If $nDiffplayCtrl = 1 Then
									$nausetmod = $RFsid
									If $oMod.Exists('ausetmod') Then
										$gtprc = $oMod.Item('ausetmod')
										For $i = 0 To UBound($gtprc) - 1
											GUICtrlSetState($gtprc[$i], $nausetmod)
										Next
									EndIf
								EndIf
						EndSwitch
						$getparam[15] = $RFsid
						$objc.Item($FSID) = $getparam
					Case 'pic'
						If $nDiffplayCtrl = 0 Then
							Switch String($getparam[14])
								Case 'backauset'
									If $nbackauset = 1 Then
										$nbackauset = 4
										_BASS_ChannelPlay($MusicHandleBck, 0)
;~ 									_SetImage($FSID, $picauback, $getparam[4], $getparam[5], -1)
										If $oMod.Exists('backauset') Then
											$gtprc = $oMod.Item('backauset')
											For $i = 0 To UBound($gtprc) - 1
												$getposauctrl = ControlGetPos($WOTP, '', $gtprc[$i])
												_SetImage($gtprc[$i], $picauback, $getposauctrl[2], $getposauctrl[3], -1)
											Next
										EndIf
									Else
										$nbackauset = 1
										_BASS_ChannelPause($MusicHandleBck)
;~ 									_SetImage($FSID, $picaubackST, $getparam[4], $getparam[5], -1)
										If $oMod.Exists('backauset') Then
											$gtprc = $oMod.Item('backauset')
											For $i = 0 To UBound($gtprc) - 1
												$getposauctrl = ControlGetPos($WOTP, '', $gtprc[$i])
												_SetImage($gtprc[$i], $picaubackST, $getposauctrl[2], $getposauctrl[3], -1)
											Next
										EndIf
									EndIf
								Case 'ausetmod'
									If $nausetmod = 1 Then
										$nausetmod = 4
;~ 									_SetImage($FSID, $picaumod, $getparam[4], $getparam[5], -1)
										If $oMod.Exists('ausetmod') Then
											$gtprc = $oMod.Item('ausetmod')
											For $i = 0 To UBound($gtprc) - 1
												$getposauctrl = ControlGetPos($WOTP, '', $gtprc[$i])
												_SetImage($gtprc[$i], $picaumod, $getposauctrl[2], $getposauctrl[3], -1)
											Next
										EndIf
									Else
										$nausetmod = 1
;~ 									_SetImage($FSID, $picaumodST, $getparam[4], $getparam[5], -1)
										If $oMod.Exists('ausetmod') Then
											$gtprc = $oMod.Item('ausetmod')
											For $i = 0 To UBound($gtprc) - 1
												$getposauctrl = ControlGetPos($WOTP, '', $gtprc[$i])
												_SetImage($gtprc[$i], $picaumodST, $getposauctrl[2], $getposauctrl[3], -1)
											Next
										EndIf
									EndIf
							EndSwitch
						EndIf
				EndSwitch
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
;~ $picauback = $wkdir & '\picauback.png', $picaubackST = $wkdir & '\picaubackST.png', $picaumod = $wkdir & '\picaumod.png', $picaumodST = $wkdir & '\picaumodST.png'
Func _CHKPARENT($idchk)
	Local $ainfid = $objc.Item($idchk)
	If GUICtrlRead($idchk) = 4 Then
		$ainfid[23] = 4
		$objc.Item($idchk) = $ainfid
		If Not (String($ainfid[16]) == '0') Then _CHKDNDEL($ainfid[16])
	Else
		$ainfid[23] = 1
		$objc.Item($idchk) = $ainfid
		If $ainfid[15] Then
			_CHKUP($ainfid[15])
			_ONLY($ainfid[15], $ainfid[14])
		EndIf
		If Not (String($ainfid[16]) == '0') Then _CHKDN($ainfid[16])
	EndIf
EndFunc   ;==>_CHKPARENT

Func _ONLY($nmp, $nmit)
	Local $gtfol = $oMod.Item($nmp)
	Local $only = $objc.Item($gtfol)
	If $only[17] Then
		Local $recount = StringReplace($only[16], '#' & $nmit, '')
		If Not @extended Then
			$recount = StringReplace($only[16], $nmit & '#', '')
			If Not @extended Then
				$recount = StringReplace($only[16], $nmit, '')
				If Not @extended Then $recount = ''
			EndIf
		EndIf
		If Not ($recount == '') Then _CHKDNDEL($recount)
		If $only[15] Then
			_ONLY($only[15], $only[14])
		EndIf
	Else
		If $only[15] Then
			_ONLY($only[15], $only[14])
		EndIf
	EndIf
EndFunc   ;==>_ONLY

Func _CHKUP($idprt)
	Local $getchk, $getid = $idprt, $gtfol
	While 1
		$gtfol = $oMod.Item($getid)
		$getchk = $objc.Item($gtfol)
		If GUICtrlRead($getchk) = 1 Then
			ExitLoop
		Else
			GUICtrlSetState($gtfol, 1)
			$getchk[23] = 1
			$objc.Item($gtfol) = $getchk
			If Not Number($getchk[15]) Then ExitLoop
			$getid = Number($getchk[15])
		EndIf
	WEnd
EndFunc   ;==>_CHKUP

Func _CHKDN($idprt)
	Local $getchk, $getid = $idprt, $splfid, $gettmpid
	While 1
		$splfid = StringSplit($getid, '#')
		$gettmpid = $oMod.Item(Number($splfid[1]))
		$getchk = $objc.Item($gettmpid)
		GUICtrlSetState($gettmpid, 1)
		$getchk[23] = 1
		$objc.Item($gettmpid) = $getchk
		If String($getchk[16]) == '0' Then ExitLoop
		$getid = $getchk[16]
	WEnd
EndFunc   ;==>_CHKDN

Func _CHKDNDEL($idprt)
	Local $getchk
	Local $splfid, $gettmpid
	$splfid = StringSplit($idprt, '#')
	For $i = 1 To $splfid[0]
		$gettmpid = $oMod.Item(Number($splfid[$i]))
		$getchk = $objc.Item($gettmpid)
		GUICtrlSetState($gettmpid, 4)
		$getchk[23] = 4
		$objc.Item($gettmpid) = $getchk
		If String($getchk[16]) == '0' Then ContinueLoop
		_CHKDNDEL($getchk[16])
	Next
EndFunc   ;==>_CHKDNDEL

Func _PICTXTTV()
	Local $gtpic, $curpic
	Local $tPoint = _WinAPI_GetMousePos(1, $g_GTVEx_aTVData)
	Local $tTVHTI = _GUICtrlTreeView_HitTestEx($g_GTVEx_aTVData, DllStructGetData($tPoint, 1, 1), DllStructGetData($tPoint, 2))
	Local $hItemTV = DllStructGetData($tTVHTI, 'Item')
	If $hItemTV Then
		If $tmpcurtv = $hItemTV Then Return
		Switch DllStructGetData($tTVHTI, 'Flags')
			Case 4, 64
				$gtpic = _GUITreeViewEx_GetItemData($g_GTVEx_aTVData, _GUICtrlTreeView_GetItemParam($g_GTVEx_aTVData, $hItemTV))
				If Not IsArray($gtpic) Then
					_UpDateVTV()
					Return
				EndIf
				If FileExists($wkdir & '\' & $gtpic[14] & StringRight($gtpic[19], 4)) Then
					$idpic = $oMod.Item('pic' & $CurGui)
					If $idpic Then
						Local $gppic = $objc.Item($idpic)
						$curpic = $wkdir & '\' & $gtpic[14] & StringRight($gtpic[19], 4)
						_SetImage($idpic, $curpic, $gppic[4], $gppic[5], -1)
						GUICtrlSetPos($idpic, $gppic[2], $gppic[3], $gppic[4], $gppic[5])
					EndIf
				Else
					If $idpic Then
						GUICtrlSetImage($idpic, '')
						$idpic = 0
					EndIf
				EndIf
				If FileExists($wkdir & '\' & $gtpic[14] & '.mp3') Then
					If $nausetmod = 4 Then
						_SetNewSong($wkdir & '\' & $gtpic[14] & '.mp3')
					EndIf
				Else
					_ResetStopS()
				EndIf
				If Not (String($gtpic[22]) == '0') Then
					$idtxt = $oMod.Item('txt' & $CurGui)
					If $idtxt Then
						Local $medit = StringReplace($gtpic[22], '\n', @CRLF)
						$medit = StringReplace($medit, '\h', ' ')
						$medit = StringSplit($medit, '{lang}', 1)
						If $medit[0] >= $iCHLangPJ Then
							GUICtrlSetData($idtxt, $medit[$iCHLangPJ])
						Else
							GUICtrlSetData($idtxt, $medit[1])
						EndIf
					EndIf
				Else
					If $idtxt Then
						GUICtrlSetData($idtxt, '')
						$idtxt = 0
					EndIf
				EndIf
				$tmpcurtv = $hItemTV
			Case Else
				_UpDateVTV()
				Return
		EndSwitch
	Else
		_UpDateVTV()
		Return
	EndIf
EndFunc   ;==>_PICTXTTV

Func _PICTXT($getcurid)
	Local $curpic, $medit, $gtpic, $gppic
	If $getcurid > 0 Then
		$gtpic = $objc.Item($getcurid)
		If Not IsArray($gtpic) Then
			If $flhide Then
				_UpDateVTV()
				$flhide = 0
			EndIf
			Return
		EndIf
		If String($gtpic[0]) == 'mod' Then
			If $tmpcurtv = $getcurid Then Return
			If FileExists($wkdir & '\' & $gtpic[14] & StringRight($gtpic[19], 4)) Then
				$idpic = $oMod.Item('pic' & $CurGui)
				If $idpic Then
					$gppic = $objc.Item($idpic)
					$curpic = $wkdir & '\' & $gtpic[14] & StringRight($gtpic[19], 4)
					_SetImage($idpic, $curpic, $gppic[4], $gppic[5], -1)
					GUICtrlSetPos($idpic, $gppic[2], $gppic[3], $gppic[4], $gppic[5])
					$flhide = 1
				EndIf
			Else
				If $flhide = 1 Then
					If $idpic Then
						GUICtrlSetImage($idpic, '')
						$idpic = 0
					EndIf
					$flhide = 0
				EndIf
			EndIf
			If FileExists($wkdir & '\' & $gtpic[14] & '.mp3') Then
				If $nausetmod = 4 Then
					_SetNewSong($wkdir & '\' & $gtpic[14] & '.mp3')
				EndIf
			Else
				_ResetStopS()
			EndIf
			If Not (String($gtpic[22]) == '0') Then
				$idtxt = $oMod.Item('txt' & $CurGui)
				If $idtxt Then
					$medit = StringReplace($gtpic[22], '\n', @CRLF)
					$medit = StringReplace($medit, '\h', ' ')
					$medit = StringSplit($medit, '{lang}', 1)
					If $medit[0] >= $iCHLangPJ Then
						GUICtrlSetData($idtxt, $medit[$iCHLangPJ])
					Else
						GUICtrlSetData($idtxt, $medit[1])
					EndIf
					$flhide = 1
				EndIf
			Else
				If $flhide = 1 Then
					If $idtxt Then
						GUICtrlSetData($idtxt, '')
						$idtxt = 0
					EndIf
					$flhide = 0
				EndIf
			EndIf
			$tmpcurtv = $getcurid
		Else
			If $flhide Then
				_UpDateVTV()
				$flhide = 0
			EndIf
		EndIf
	Else
		If $tmpcurtv Then
			_UpDateVTV()
			$flhide = 0
		EndIf
	EndIf
EndFunc   ;==>_PICTXT
Func _UpDateVTV()
	If $idpic Then
		GUICtrlSetImage($idpic, '')
		$idpic = 0
	EndIf
	If $idtxt Then
		GUICtrlSetData($idtxt, '')
		$idtxt = 0
	EndIf
	_ResetStopS()
	$tmpcurtv = 0
EndFunc   ;==>_UpDateVTV

Func _GDIPlus_StripProgressbar($fPerc, $iW, $iH, $iVisP = 1, $iBgColorGui = 0x000000, $iFgColor = 0x808080, $iBGColor = 0x0000FF, $iTextColor = 0xFFFFFF, $sFont = 'Arial Black')
	Local $sPerc = Ceiling($fPerc)
	If $sPerc < 0 Then $sPerc = 0
	If $sPerc > 100 Then $sPerc = 100
	_GDIPlus_Startup()
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iW, $iH)
	Local Const $hCtxt = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetPixelOffsetMode($hCtxt, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hCtxt, 0xFF000000 + $iBgColorGui)
	Local $iWidth = $iH * 2, $iLen = $iWidth / 2, $iY
	Local $hBmp = _GDIPlus_BitmapCreateFromScan0($iWidth, $iH)
	Local Const $hCtxt_Bmp = _GDIPlus_ImageGetGraphicsContext($hBmp)
	_GDIPlus_GraphicsSetPixelOffsetMode($hCtxt_Bmp, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)
	Local $hPen = _GDIPlus_PenCreate(0xFF0000000 + $iFgColor), $iPenSize = Int($iH / 12)
	Local $hPen2 = _GDIPlus_PenCreate(0x50000000, $iPenSize)
	_GDIPlus_GraphicsClear($hCtxt_Bmp, 0xFF000000 + $iBGColor)
	Local Static $iX = 0
	For $iY = 0 To $iH - 1
		_GDIPlus_GraphicsDrawLine($hCtxt_Bmp, -$iX + $iY, $iY, -$iX + $iY + $iLen, $iY, $hPen)
		_GDIPlus_GraphicsDrawLine($hCtxt_Bmp, -$iX + $iY + 2 * $iLen, $iY, -$iX + $iY + 3 * $iLen, $iY, $hPen)
	Next
	Local $tPoint1 = DllStructCreate('float;float')
	Local $tPoint2 = DllStructCreate('float;float')
	DllStructSetData($tPoint1, 1, $iW / 2)
	DllStructSetData($tPoint2, 1, $iW / 2)
	_GDIPlus_GraphicsDrawLine($hCtxt_Bmp, 0, 0, $iWidth, 0, $hPen2)
	$iX = Mod($iX + 2, $iWidth)
	Local $hTextureBrush = _GDIPlus_TextureCreate($hBmp)
	_GDIPlus_GraphicsFillRect($hCtxt, 0, 0, $sPerc / 100 * $iW, $iH, $hTextureBrush)
	If $iVisP Then
		_GDIPlus_GraphicsSetTextRenderingHint($hCtxt, 5)
		Local $hBrush = _GDIPlus_BrushCreateSolid(0xFF000000 + $iTextColor)
		Local $hFormat = _GDIPlus_StringFormatCreate()
		Local $hFamily = _GDIPlus_FontFamilyCreate($sFont)
		Local $hFont = _GDIPlus_FontCreate($hFamily, $iH * 2.5 / 5, 2)
		Local $tLayout = _GDIPlus_RectFCreate(0, 0, $iW, $iH)
		_GDIPlus_StringFormatSetAlign($hFormat, 1)
		_GDIPlus_GraphicsDrawStringEx($hCtxt, $sPerc & '%', $hFont, $tLayout, $hFormat, $hBrush)
		_GDIPlus_FontDispose($hFont)
		_GDIPlus_FontFamilyDispose($hFamily)
		_GDIPlus_StringFormatDispose($hFormat)
		_GDIPlus_BrushDispose($hBrush)
	EndIf
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_GraphicsDispose($hCtxt)
	_GDIPlus_GraphicsDispose($hCtxt_Bmp)
	_GDIPlus_BitmapDispose($hBmp)
	_GDIPlus_BrushDispose($hTextureBrush)
	Local $hHBITMAP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_Shutdown()
	Return $hHBITMAP
EndFunc   ;==>_GDIPlus_StripProgressbar
Func PlayAnim()
	$hHBmp_BG = _GDIPlus_StripProgressbar($iPercData, $WPerc, $HPerc, $iVisPerc, $BgColorGui, $FgBGColor, $BGColor, $TextBGColor, $sFontProgress)
	Local $hB = GUICtrlSendMsg($iPercId, 0x0172, 0, $hHBmp_BG)
	If $hB Then _WinAPI_DeleteObject($hB)
	_WinAPI_DeleteObject($hHBmp_BG)
EndFunc   ;==>PlayAnim
Func _ExtractFiles($aNameExt, $sPathExt, $aArrayFiles, $sPathExe)
	Local $hFileCreateST = FileOpen($sPathExe, 16)
	If $hFileCreateST = -1 Then Return SetError - 25
	Local $bReadFile, $hOfileRes, $nAllSizeFiles = 0
	Local $nFileMax = 1048576, $bBytesRead = 0
	For $r = 0 To UBound($aNameExt) - 1
		For $i = UBound($aArrayFiles) - 1 To 0 Step -1
			$nAllSizeFiles += $aArrayFiles[$i][1]
			If $aArrayFiles[$i][0] = $aNameExt[$r] Then
				FileSetPos($hFileCreateST, -$nAllSizeFiles, 2)
				$bBytesRead = $aArrayFiles[$i][1]
				$hOfileRes = FileOpen($sPathExt & '\' & $aArrayFiles[$i][0], 26)
				While 1
					If $bBytesRead <= $nFileMax Then
						$bReadFile = FileRead($hFileCreateST, $bBytesRead)
						FileWrite($hOfileRes, $bReadFile)
						ExitLoop
					Else
						$bBytesRead = $bBytesRead - $nFileMax
						$bReadFile = FileRead($hFileCreateST, $nFileMax)
						FileWrite($hOfileRes, $bReadFile)
					EndIf
				WEnd
				FileClose($hOfileRes)
				ExitLoop
			EndIf
		Next
		$nAllSizeFiles = 0
	Next
	FileClose($hFileCreateST)
EndFunc   ;==>_ExtractFiles


#include-once

; Имя.....................: _FFSearch
; Назначение..............: Поиск файлов и папок
; Синтаксис...............: _FileSearch($sPath, [$sExt = '',[ $iPart = 0, [$iDepth = 0,[ $aArray = 1]]]])
; Параметры...............: $sPath - Путь поиска(строка)
;                           $sExt - Имя и расширение, или имя(часть имени), или расширение(строка).Можно использовать несколько данных для поиска. Использовать разделитель '|'. Расширения пишутся без точки: exe|txt|jpg
;                           $iPart - Параметры поиска(число)
;                                |0 - Поиск файлов и папок.Если $sExt пуст, то будут возвращены все файлы и папки. Если $sExt равен строке, то будут возвращены все файлы и папки, имена которых частично или полностью совпадают со строкой $sExt
;                                |1 - Поиск файлов по имени и расширению |
;                                |2 - Поиск файлов по имени              |Если $sExt пуст, то будут возвращены все файлы
;                                |3 - Поиск файлов по расширению         |
;                                |4 - Поиск папок по имени. Полное совпадение имени. Если $sExt пуст, то будут возвращены все папки
;                                |5 - Поиск пустых папок(внутри нет ни папок ни файлов)
;                                |6 - Поиск файлов нулевого размера
;                                |7 - Поиск пустых папок(внутри есть папки, но они пустые)
;                                |11(5+6) - Поиск пустых папок и файлов нулевого размера
;                          $iDepth - Глубина поиска(число)
;                                |0 - Поиск во всех папках
;                                |1 - Поиск на первом уровне
;                          $aArray - Вид массива(число)
;                                |1 - Первый элемент массива содержит количество элементов массива
;                                |2 - Отключить возвращение количества элементов в первый элемент массива (необходимо использовать UBound(), чтобы получить размер массива)
; Возвращаемые значения...: Успех - Массив найденных файлов и/или папок
; Ошибки..................: Ошибки 1, 3, 4, 5 - указывают на ошибку в параметрах функции. Номер ошибки соответствует порядковому номеру параметра функции
;                           6 - Папка пуста(путь не существует)
;                           7 - Ничего не найдено
; Автор...................: Joiner
Func _FFSearch($sPath, $sExt = '', $iPart = 0, $iDepth = 0, $aArray = 1)
	$sPath = StringStripWS($sPath, 3)
	$iPart = Number($iPart)
	$iDepth = Number($iDepth)
	$aArray = Number($aArray)
	Select
		Case $sPath = ''
			Return SetError(1)
		Case ($iPart < 0 Or $iPart > 7) And $iPart <> 11
			Return SetError(3)
		Case $iDepth < 0 Or $iDepth > 1
			Return SetError(4)
		Case $aArray < 1 Or $aArray > 2
			Return SetError(5)
	EndSelect
	If StringCompare(StringRight($sPath, 1), '\') Then $sPath = $sPath & '\'
	Local $sFileList
	If StringInStr($sExt, '|') Then
		Local $sDelim = StringSplit($sExt, '|', 1)
		For $i = 1 To $sDelim[0]
			__FFSearchAll($sFileList, $sPath, $sDelim[$i], $iPart, $iDepth)
			If @error Then Return SetError(6)
		Next
	Else
		__FFSearchAll($sFileList, $sPath, $sExt, $iPart, $iDepth)
		If @error Then Return SetError(6)
	EndIf
	$sFileList = StringTrimRight($sFileList, 1)
	If Not $sFileList Then Return SetError(7)
	$sFileList = StringSplit($sFileList, '|', $aArray)
	Return $sFileList
EndFunc   ;==>_FFSearch

Func __FFSearchAll(ByRef $sFileList, $sPath, $sExt = '', $iPart = 0, $iDepth = 0)
	Local $sFile = '', $hFirstFile = FileFindFirstFile($sPath & '*'), $lastpoint, $RetString = ''
	If $hFirstFile = -1 Then Return SetError(1)
	Local $aEmptyF
	While 1
		$sFile = FileFindNextFile($hFirstFile)
		If @error Then ExitLoop
		If @extended Then
			If $sExt Then
				Switch $iPart
					Case 0
						If StringInStr($sFile, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 4
						If Not StringCompare($sFile, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 5, 11
						$aEmptyF = DirGetSize($sPath & $sFile, 1)
						If Not @error Then
							If Not $aEmptyF[1] And Not $aEmptyF[2] Then $sFileList &= $sPath & $sFile & '|'
						EndIf
					Case 7
						$aEmptyF = DirGetSize($sPath & $sFile, 1)
						If Not @error Then
							If Number($aEmptyF[1]) = 0 Then $sFileList &= $sPath & $sFile & '|'
						EndIf
				EndSwitch
			Else
				Switch $iPart
					Case 0, 4
						$sFileList &= $sPath & $sFile & '|'
					Case 5, 11
						$aEmptyF = DirGetSize($sPath & $sFile, 1)
						If Not @error Then
							If Number($aEmptyF[1]) = 0 And Number($aEmptyF[2]) = 0 Then $sFileList &= $sPath & $sFile & '|'
						EndIf
					Case 7
						$aEmptyF = DirGetSize($sPath & $sFile, 1)
						If Not @error Then
							If Number($aEmptyF[1]) = 0 Then $sFileList &= $sPath & $sFile & '|'
						EndIf
				EndSwitch
			EndIf
			If Not $iDepth Then __FFSearchAll($sFileList, $sPath & $sFile & '\', $sExt, $iPart, $iDepth)
		Else
			If $sExt Then
				$lastpoint = StringInStr($sFile, '.', 0, -1)
				Switch $iPart
					Case 0
						$RetString = StringLeft($sFile, $lastpoint - 1)
						If StringInStr($RetString, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 1
						If Not StringCompare($sFile, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 2
						$RetString = StringLeft($sFile, $lastpoint - 1)
						If Not StringCompare($RetString, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 3
						$RetString = StringTrimLeft($sFile, $lastpoint)
						If Not StringCompare($RetString, $sExt) Then $sFileList &= $sPath & $sFile & '|'
					Case 6, 11
						If Not FileGetSize($sPath & $sFile) Then $sFileList &= $sPath & $sFile & '|'
				EndSwitch
			Else
				Switch $iPart
					Case 0 To 3
						$sFileList &= $sPath & $sFile & '|'
					Case 6, 11
						If Not FileGetSize($sPath & $sFile) Then $sFileList &= $sPath & $sFile & '|'
				EndSwitch
			EndIf
		EndIf
	WEnd
	FileClose($hFirstFile)
EndFunc   ;==>__FFSearchAll

