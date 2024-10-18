Class Demo.Order.BO.NotificationApiOperation Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

Property TenantId As %String [ InitialExpression = "XYZ-123" ];

Parameter SETTINGS = "MyParams:TenantId,ReplyCodeActions,RetryInterval,AlertRetryGracePeriod:Alerting,FailureTimeout,QueueCountAlert:Alerting,QueueWaitAlert:Alerting,SendSuperSession";

/// Send notification
Method SendNotification(pRequest As Demo.Order.Msg.NotificationReq, Output pResponse As Demo.Order.Msg.NotificationRsp) As %Status
{
    set ret = $$$OK
    try {
      set pResponse = ##class(Demo.Order.Msg.NotificationRsp).%New()

      // serialize to json        
      do pRequest.%JSONExportToString(.jsonExport)
      set formatter = ##class(%JSON.Formatter).%New()
      do formatter.FormatToString(jsonExport, .json)
      $$$LOGINFO(json)

      // build request
      set httpReq = ##class(%Net.HttpRequest).%New()
      set httpReq.ContentType="application/json"
      set httpReq.ContentCharset="UTF-8"
      do httpReq.SetHeader("X-TENANT-ID", ..TenantId)
      do httpReq.EntityBody.Write(json)
    
      // send request
      set url = ..Adapter.URL
      set sc = ..Adapter.SendFormDataArray(.httpRsp, "POST",  .httpReq, , , url)

      if $$$ISERR(sc),$isobject(httpRsp),$isobject(httpRsp.Data),httpRsp.Data.Size {
          return $$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(sc)_":"_httpRsp.Data.Read())
      }
      $$$ThrowOnError(sc)
      
      // handle response
      if $isobject(httpRsp),httpRsp.StatusCode=200 { 
          set data = httpRsp.Data.Read()
          $$$LOGINFO("response="_data)

          // parse response
          set jsonObj = {}.%FromJSON(data)
          set pResponse.Status = "OK"
      }

    } catch ex {
        set ret = ex.AsStatus()
    }
    quit ret
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Demo.Order.Msg.NotificationReq">
    <Method>SendNotification</Method>
  </MapItem>
</MapItems>
}

}
