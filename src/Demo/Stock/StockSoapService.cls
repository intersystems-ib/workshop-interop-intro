Class Demo.Stock.StockSoapService Extends %SOAP.WebService
{

Parameter SERVICENAME = "StockSoapService";

Parameter NAMESPACE = "Demo";

Method UpdateStock(product As %String, quantity As %Integer) As %String [ WebMethod ]
{
	return ##class(%SYSTEM.Util).CreateGUID()
}

}
