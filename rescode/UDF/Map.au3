#include-once

;~ _mSetValueKey: The function assigns a value to an existing key.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ $vValue - New key value
;~ Return values: Success - 1, Failure - 0
;~  Function in Scripting.Dictionary - $oDict.Key($vKey) = $vNewKey
Func _mSetValueKey(ByRef $mMap, $vKey, $vValue)
	If Not ((VarGetType($mMap) = 'Map')) Then Return 0
	If MapExists($mMap, $vKey) Then
		$mMap[$vKey] = $vValue
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_mSetValueKey

;~ _mGetValueKey: The function returns the value of the key.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ Return values: Success - key value, Failure - 0
;~  Function in Scripting.Dictionary - $vValue = $oDict.Item($vKey)
Func _mGetValueKey($mMap, $vKey)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	If MapExists($mMap, $vKey) Then Return $mMap[$vKey]
	Return 0
EndFunc   ;==>_mGetValueKey

;~ _mGetValueKeys: The function returns the values ​​of all keys.
;~ $mMap - Map variable
;~ Return values: Success - Array of key values (use UBound($Array)), Failure - 0
;~  Function in Scripting.Dictionary - $Array = $oDict.Items()
Func _mGetValueKeys($mMap)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	Local $aKeys = MapKeys($mMap)
	Local $aKeysValue[UBound($aKeys)]
	For $i = 0 To UBound($aKeys) - 1
		$aKeysValue[$i] = $mMap[$aKeys[$i]]
	Next
	Return $aKeysValue
EndFunc   ;==>_mGetValueKeys

;~ _mExistsKey: The function checks for the existence of a key.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ Return values: Success - 1, Failure - 0
;~  Function in Scripting.Dictionary - $fBool = $oDict.Exists($vKey)
Func _mExistsKey($mMap, $vKey)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	If MapExists($mMap, $vKey) Then Return 1
	Return 0
EndFunc   ;==>_mExistsKey

;~ _mCreateKey: The function creates a new key and assigns it a value.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ $vValue - key value
;~ Return values: Success - 1, Failure - 0
;~  Function in Scripting.Dictionary - $oDict.Add($vKey, $vValue)
Func _mCreateKey(ByRef $mMap, $vKey, $vValue = '')
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	If Not MapExists($mMap, $vKey) Then
		$mMap[$vKey] = $vValue
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_mCreateKey

;~ _mGetKeys: The function returns the names of all keys.
;~ $mMap - Map variable
;~ $iCount = 0 : return array of keys; Function in Scripting.Dictionary - $Array = $oDict.Keys()
;~ $iCount = 1 : return the number of keys; Function in Scripting.Dictionary - $iCount = $oDict.Count()
;~ Failure -  return 0
Func _mGetKeys($mMap, $iCount = 0)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	If $iCount Then
		Return UBound(MapKeys($mMap))
	Else
		Return MapKeys($mMap)
	EndIf
EndFunc   ;==>_mGetKeys

;~ _mRemoveKey: The function deletes the selected key.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ Return values: Success - 1, Failure - 0
;~  Function in Scripting.Dictionary - $oDict.Remove($vKey)
Func _mRemoveKey(ByRef $mMap, $vKey)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	If MapExists($mMap, $vKey) Then Return MapRemove($mMap, $vKey)
	Return 0
EndFunc   ;==>_mRemoveKey

;~ _mRemoveKeys: The function deletes all keys.
;~ $mMap - Map variable
;~ $vKey - Key name
;~ Return values: Success - 1, Failure - 0
;~  Function in Scripting.Dictionary - $oDict.RemoveAll()
Func _mRemoveKeys(ByRef $mMap)
	If Not (VarGetType($mMap) = 'Map') Then Return 0
	Local $aKeys = MapKeys($mMap)
	If Not UBound($aKeys) Then Return 0
	For $Key In $aKeys
		MapRemove($mMap, $Key)
	Next
	Return 1
EndFunc   ;==>_mRemoveKeys
