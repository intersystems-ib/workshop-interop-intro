Class Demo.Order.Msg.NotificationRsp Extends (Ens.Response, %JSON.Adaptor)
{

Property Status As %String;

Storage Default
{
<Data name="NotificationRspDefaultData">
<Subscript>"NotificationRsp"</Subscript>
<Value name="1">
<Value>Status</Value>
</Value>
</Data>
<DefaultData>NotificationRspDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
