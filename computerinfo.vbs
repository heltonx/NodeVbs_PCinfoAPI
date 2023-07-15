Option Explicit

Dim computerInfo
Set computerInfo = CreateObject("Scripting.Dictionary")

computerInfo("ComputerName") = GetComputerName()
computerInfo("OS") = GetOperatingSystem()
computerInfo("Domain") = GetDomain()
computerInfo("InternalIP") = GetInternalIP()
computerInfo("Processor") = GetProcessor()
computerInfo("TotalRAM") = GetTotalRAM()

WScript.Echo ConvertToJson(computerInfo)

Function GetComputerName()
    Dim objNetwork
    Set objNetwork = CreateObject("WScript.Network")
    GetComputerName = objNetwork.ComputerName
    Set objNetwork = Nothing
End Function

Function GetOperatingSystem()
    Dim objWMIService, colItems, objItem
    Set objWMIService = GetObject("winmgmts:\\.\root\CIMv2")
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_OperatingSystem")
    For Each objItem in colItems
        GetOperatingSystem = objItem.Caption
        Exit Function
    Next
    GetOperatingSystem = ""
End Function

Function GetDomain()
    Dim objWMIService, colItems, objItem
    Set objWMIService = GetObject("winmgmts:\\.\root\CIMv2")
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
    For Each objItem in colItems
        GetDomain = objItem.Domain
        Exit Function
    Next
    GetDomain = ""
End Function

Function GetInternalIP()
    Dim objWMIService, colItems, objItem
    Set objWMIService = GetObject("winmgmts:\\.\root\CIMv2")
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
    For Each objItem in colItems
        If Not IsNull(objItem.IPAddress) Then
            GetInternalIP = objItem.IPAddress(0)
            Exit Function
        End If
    Next
    GetInternalIP = ""
End Function

Function GetProcessor()
    Dim objWMIService, colItems, objItem
    Set objWMIService = GetObject("winmgmts:\\.\root\CIMv2")
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Processor")
    For Each objItem in colItems
        GetProcessor = objItem.Name
        Exit Function
    Next
    GetProcessor = ""
End Function

Function GetTotalRAM()
    Dim objWMIService, colItems, objItem
    Set objWMIService = GetObject("winmgmts:\\.\root\CIMv2")
    Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
    For Each objItem in colItems
        GetTotalRAM = Round(objItem.TotalPhysicalMemory / 1024^3, 2) ' Convert bytes to GB
        Exit Function
    Next
    GetTotalRAM = ""
End Function

Function ConvertToJson(data)
    Dim json, key
    json = "{"
    For Each key In data.Keys
        json = json & """" & key & """:""" & Replace(data(key), """", "\""") & ""","
    Next
    json = Left(json, Len(json) - 1) & "}"
    ConvertToJson = json
End Function
