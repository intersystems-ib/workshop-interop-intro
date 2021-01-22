Include EnsConstants

Class Util.SuspendedMsg Extends %RegisteredObject
{

/// Discard all suspended messages
/// do ##class(Test.Suspended).DiscardAllSuspended()
ClassMethod DiscardAllSuspended() As %Status
{
    set ret = $$$OK
    try {
        &sql(DECLARE C2 CURSOR FOR
            SELECT Id
                INTO :tID
                FROM Ens.MessageHeader
                WHERE Status = $$$eMessageStatusSuspended)
        &sql(OPEN C2)
        &sql(FETCH C2)
    
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

            &sql(FETCH C2)
        }
        &sql(CLOSE C2)

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

}
