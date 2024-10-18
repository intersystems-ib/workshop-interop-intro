Class Demo.Order.DT.OrderRecordToNotificationReq Extends Ens.DataTransformDTL [ DependsOn = (Demo.Order.CSVRecordMap.Record, Demo.Order.Msg.NotificationReq) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.Order.CSVRecordMap.Record' targetClass='Demo.Order.Msg.NotificationReq' create='new' language='objectscript' >
<assign value='"Your order "_source.OrderID_" ("_source.ProductName_") has been processed."' property='target.Content' action='set' />
</transform>
}

}
