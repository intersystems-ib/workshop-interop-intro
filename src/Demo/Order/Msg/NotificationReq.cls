Class Demo.Order.Msg.NotificationReq Extends Grongier.JsonTraceViewer.Request
{

Property Content As %String(MAXLEN = "");

Property Priority As %String;

Storage Default
{
<Data name="NotificationReqDefaultData">
<Subscript>"NotificationReq"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>Priority</Value>
</Value>
</Data>
<DefaultData>NotificationReqDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
