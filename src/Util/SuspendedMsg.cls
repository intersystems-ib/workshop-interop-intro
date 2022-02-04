Include EnsConstants

Class Util.SuspendedMsg Extends %RegisteredObject
{

/// Discard all suspended messages
/// do ##class(Util.SuspendedMsg).DiscardAllSuspended()
ClassMethod DiscardAllSuspended() As %Status
{
    set ret = $$$OK
    try {
        &sql(DECLARE cDiscard CURSOR FOR
            SELECT Id INTO :tID FROM Ens.MessageHeader WHERE Status = $$$eMessageStatusSuspended)
        &sql(OPEN cDiscard)
        &sql(FETCH cDiscard)
    
        while SQLCODE=0 {
            set tObj = ##class(Ens.MessageHeader).%OpenId(tID)
            do tObj.SetStatus($$$eMessageStatusDiscarded)
		    set tStatus=tObj.%Save()

            if $$$ISERR(tStatus) {
                do $SYSTEM.Status.DecomposeStatus(tStatus,.err)
                write !,"[ERROR] DiscardFailed message ID '"_tID_"' failed: "_$GET(err(1))
            } else {
                write !,"[OK] Message "_tID_" discarded"
            }

            &sql(FETCH cDiscard)
        }
        &sql(CLOSE cDiscard)

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

/// Save all suspended messages (HL7)
/// do ##class(Util.SuspendedMsg).SaveAllSuspended("/tmp/suspended/"_$namespace_"/")
ClassMethod SaveAllSuspended(pOutputPath As %String = {"/tmp/"_$namespace_"/"}) As %Status
{
    set ret = $$$OK
    try {
		set (nTotal, nOK) = 0
		
        set (tID, tTargetConfigName, tMessageBodyClassName, tMessageBodyId) = ""
        &sql(DECLARE cSave CURSOR FOR
            SELECT Id, TargetConfigName, MessageBodyClassName, MessageBodyId 
            INTO :tID, :tTargetConfigName, :tMessageBodyClassName, :tMessageBodyId
            FROM Ens.MessageHeader WHERE Status = $$$eMessageStatusSuspended)
        &sql(OPEN cSave)
        &sql(FETCH cSave)
    
        while SQLCODE=0 {
	        
	        set nTotal = nTotal + 1

            if tMessageBodyClassName="EnsLib.HL7.Message" {
                set savePath = pOutputPath_tTargetConfigName_"/"
                if ##class(%File).CreateDirectoryChain(savePath) {
                    set hl7 = ##class(EnsLib.HL7.Message).%OpenId(tMessageBodyId)
                    if $isobject(hl7) {
                    	set filePath=savePath_tID_".hl7"
                    	set sc = hl7.OutputToFile(filePath)
                    	if $$$ISOK(sc) set nOK = nOK + 1
                    } else {
	                    write !,"[ERROR] Message ID "_tID_". Cannot open HL7 "_tMessageBodyId
                    }
                } 
            } else {
                write !,"[ERROR] Message ID "_tID_" not supported ("_tMessageBodyClassName_")"
            }
            
            &sql(FETCH cSave)
        }
        &sql(CLOSE cSave)

		write !,"Total messages: ",nTotal
        write !,"Sucessfully saved messages: ", nOK

    } catch ex {
        set ret = ex.AsStatus()
        do $system.OBJ.DisplayError(ret)
    }
    
    quit ret
}

}
