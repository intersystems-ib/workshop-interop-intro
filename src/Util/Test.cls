Class Util.Test Extends %RegisteredObject
{

/// do ##class(Util.Test).TestBigJSON()
ClassMethod TestBigJSON() As %Status
{
    set ret = $$$OK
    try {

        // 1. Create big using %DynamicObject and streams
        // generate big stream (12MB)
        #define BufSize 32000
		set buf = ""
		for i=1:1:$$$BufSize set buf=buf_"A"
		set big = ##class(%Stream.GlobalCharacter).%New()
		for i=1:1:400 {
			do big.Write(buf)
		}
		write !,"> Generated stream of "_(big.Size\1024)_" KB"

        // insert stream into %DynamicObject and save to file
        set longJson = ##class(%DynamicObject).%New()
        set longJson.result = "OK"
        do longJson.%Set("document", big, "stream")

        set fileName = "/test/out/longJson.json"
        set file = ##class(%Stream.FileCharacter).%New()
        set file.Filename = fileName
        do longJson.%ToJSON(file)
        do file.%Save()
        write !,"> Saved file "_fileName_" containing a big stream in ""document"" property"

        // 2. Read big json into %DynamicObject
        set file = ##class(%Stream.FileCharacter).%New()
        set file.Filename = fileName
        set readJson = {}.%FromJSON(file)
        set readStream = readJson.%Get("document",,"stream")
        write !,"> Read property ""document"" (stream) from "_fileName
        zwrite readStream
        write !,"> Read stream size is ",(readStream.Size\1024)," KB"

    } catch ex {
        set ret = ex.AsStatus()
        do $system.Status.DisplayError(ret)
    }
    quit ret
}

}
