/// 
Class Demo.Order.BP.OrderProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.Order.CSVRecordMap.Record' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='customerInfo' type='Demo.Order.Msg.CustomerInfo' instantiate='0' />
<property name='notificationReq' type='Demo.Order.Msg.NotificationReq' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<call name='Customer DB Query' target='Customer MySQL Query' async='0' timeout='30' xpos='200' ypos='250' >
<annotation><![CDATA[MySQL]]></annotation>
<request type='Demo.Order.CSVRecordMap.Record' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Order.Msg.CustomerInfo' >
<assign property="context.customerInfo" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<transform name='Order to Notification' class='Demo.Order.DT.OrderRecordToNotificationReq' source='request' target='context.notificationReq' xpos='200' ypos='350' />
<call name='Send Notification' target='Notification API Out' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[Notification API]]></annotation>
<request type='Demo.Order.Msg.NotificationReq' >
<assign property="callrequest" value="context.notificationReq" action="set" languageOverride="" />
</request>
</call>
</sequence>
</process>
}

}
