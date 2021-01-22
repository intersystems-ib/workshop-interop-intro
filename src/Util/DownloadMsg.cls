/// 
/// Util to download messages given a message header id
/// 
/// Setup:
/// 1. Create a webapplication (e.g. /downloadmsg) and set DispatchClass=Util.DownloadMsg
/// 2. Go to http://localhost:52773/downloadmsg/message/19 to download the message reference by header 19
Class Util.DownloadMsg Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/message/:msgId" Method="GET" Call="DownloadMessage"/>
</Routes>
}

/// Download a message given a Ens.MessageHeader id
ClassMethod DownloadMessage(msgId As %String) As %Status
{
    set sc = ..ExportMsgToStream(msgId, .stream)

    if $$$ISOK(sc) {
        do %response.SetHeader("Content-Type", "application/octet-stream")
        do %response.SetHeader("Content-Disposition", "attachment; filename=""message.txt""")
        do %response.SetHeader("Content-Length", stream.Size)
        
        do stream.Rewind()
        do stream.OutputToDevice()
    }
    
    return $$$OK
}

/// Export a message to stream given a Ens.MessageHeader id
ClassMethod ExportMsgToStream(msgId As %String, Output stream As %Stream.Object) As %Status
{
    set ret = $$$OK
    try {
        // stream
        set stream = ##class(%Stream.GlobalCharacter).%New()

        // message header
        set headerObj = ##class(Ens.MessageHeader).%OpenId(msgId)

        // message body
        set obj = $classmethod(headerObj.MessageBodyClassName, "%OpenId", headerObj.MessageBodyId)
        set classname = $classname(obj) 

        // output to stream
		if classname="EnsLib.HL7.Message" {
			set sc = $method(obj, "OutputToLibraryStream", .stream)
			$$$ThrowOnError(sc)
		}
		else {
			set writer = ##class(%XML.Writer).%New()
			set writer.Indent=1
			set writer.NoXMLDeclaration=1
			$$$ThrowOnError(writer.OutputToStream(.stream))
			$$$ThrowOnError(writer.RootObject(obj))
		}
    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

}
