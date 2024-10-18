/// THIS IS GENERATED CODE. DO NOT EDIT.<br/>
/// RECORDMAP: Generated from RecordMap 'Demo.Order.CSVRecordMap'
/// on 2024-10-18 at 11:43:25.881 [2024-10-18 11:43:25.881 UTC]
/// by user SuperUser
Class Demo.Order.CSVRecordMap.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property OrderPriority As %String;

Property Discount As %String;

Property UnitPrice As %String;

Property ShippingCost As %String;

Property CustomerID As %String;

Property ShipMode As %String;

Property ProductCategory As %String;

Property ProductSubCategory As %String;

Property ProductContainer As %String;

Property ProductName As %String;

Property OrderDate As %String;

Property Quantity As %String;

Property Sales As %String;

Property OrderID As %String;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OrderPriority</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>UnitPrice</Value>
</Value>
<Value name="5">
<Value>ShippingCost</Value>
</Value>
<Value name="6">
<Value>CustomerID</Value>
</Value>
<Value name="7">
<Value>ShipMode</Value>
</Value>
<Value name="8">
<Value>ProductCategory</Value>
</Value>
<Value name="9">
<Value>ProductSubCategory</Value>
</Value>
<Value name="10">
<Value>ProductContainer</Value>
</Value>
<Value name="11">
<Value>ProductName</Value>
</Value>
<Value name="12">
<Value>OrderDate</Value>
</Value>
<Value name="13">
<Value>Quantity</Value>
</Value>
<Value name="14">
<Value>Sales</Value>
</Value>
<Value name="15">
<Value>OrderID</Value>
</Value>
<Value name="16">
<Value>Discount</Value>
</Value>
</Data>
<DataLocation>^Demo.Order.CSVRecor6344.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^Demo.Order.CSVRecor6344.RecordD</IdLocation>
<IndexLocation>^Demo.Order.CSVRecor6344.RecordI</IndexLocation>
<StreamLocation>^Demo.Order.CSVRecor6344.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
