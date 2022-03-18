Class Util.QueuedMsg
{

/// Export queued messages to file
/// do ##class(Util.QueuedMsg).QueueToFile("ORM_O01_FileOperation","/tmp/test")
ClassMethod QueueToFile(queueName, directory) As %Status
{
    set ret = $$$OK
    try {
		set directory = ##class(%File).NormalizeDirectory(directory)
        write !,"Exporting messages from "_queueName_" queue to "_directory,!
        
        set totalExported = 0
    	set rs = ##class(%ResultSet).%New("Ens.Queue:EnumerateItem")
 	    set sc = rs.Execute(queueName)
	    while (rs.Next()) {
		    set messageId = rs.Data("MessageId")

            set header=##class(Ens.MessageHeader).%OpenId(messageId,,.status)
			if $$$ISERR(status) $$$ThrowStatus(status)
		
			set bodyId=header.MessageBodyId
			if header.MessageBodyClassName="EnsLib.HL7.Message" {
				set hl7=##class(EnsLib.HL7.Message).%OpenId(bodyId,,.status)
				if $$$ISERR(status) $$$ThrowStatus(status)
		
				set filename = directory_messageId_".hl7"
				$$$ThrowOnError(hl7.OutputToFile(filename))
				
				set totalExported = totalExported + 1
				write "."
			}            
        }

		write !,"Total: "_totalExported_" messages exported",!

	} catch err {
		set ret = err.AsStatus()
		write "ERROR",!
		do $system.OBJ.DisplayError(ret)
	}
    quit ret
}

}
