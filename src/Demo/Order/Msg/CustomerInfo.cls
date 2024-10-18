Class Demo.Order.Msg.CustomerInfo Extends (Ens.Request, %JSON.Adaptor)
{

Property CustomerID As %String;

Property CustomerName As %String(MAXLEN = 512);

Property CustomerSegment As %String(MAXLEN = 512);

Storage Default
{
<Data name="CustomerInfoDefaultData">
<Subscript>"CustomerInfo"</Subscript>
<Value name="1">
<Value>CustomerID</Value>
</Value>
<Value name="2">
<Value>CustomerName</Value>
</Value>
<Value name="3">
<Value>CustomerSegment</Value>
</Value>
</Data>
<DefaultData>CustomerInfoDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
