/// 
/// Sample BS that restart other production host
/// Pay special attention to:
/// -UpdateProductionTimeOut
/// -CallInterval
Class Util.RestartHost Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Property HostToRestart As %String(MAXLEN = 100);

Parameter SETTINGS = "HostToRestart:Basic";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
	set ret = $$$OK
	
    try {
        set isEnabled = ##class(Ens.Director).IsItemEnabled(..HostToRestart, .sc)
        $$$ThrowOnError(sc)

        if isEnabled {
            // after enabling / disabling host, do update production in a non-production controlled job

            set sc = ##class(Ens.Director).EnableConfigItem(..HostToRestart, 0, 0)
            job ##class(Ens.Director).UpdateProduction(5,1)
            hang 5
            set sc = ##class(Ens.Director).EnableConfigItem(..HostToRestart, 1, 0)
            job ##class(Ens.Director).UpdateProduction(5,1)
        }
    
    } catch ex {
        set ret = ex.AsStatus()
    }

	quit ret
}

}
