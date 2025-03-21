Class Demo.Order.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Demo.Order.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="JavaGateway" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="ClassPath">/install/mysql-connector-j-8.4.0.jar</Setting>
  </Item>
  <Item Name="Order CSV In" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">Demo.Order.CSVRecordMap</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Order Process</Setting>
    <Setting Target="Adapter" Name="FilePath">/test/in</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Host" Name="HeaderCount">1</Setting>
  </Item>
  <Item Name="Customer MySQL Query" Category="" ClassName="EnsLib.SQL.Operation.GenericOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">MySQL_User</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:mysql://mysql:3306/testdb</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.mysql.jdbc.Driver</Setting>
    <Setting Target="Adapter" Name="JGService">JavaGateway</Setting>
    <Setting Target="Host" Name="RequestClass">Demo.Order.CSVRecordMap.Record</Setting>
    <Setting Target="Host" Name="InputParameters">*CustomerID</Setting>
    <Setting Target="Host" Name="Query">select CustomerID,CustomerName,CustomerSegment from customer where CustomerID = ?</Setting>
    <Setting Target="Host" Name="ParamSQLTypes"></Setting>
    <Setting Target="Host" Name="ResponseClass">Demo.Order.Msg.CustomerInfo</Setting>
  </Item>
  <Item Name="Notification API Out" Category="" ClassName="Demo.Order.BO.NotificationApiOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">httpbin.org</Setting>
    <Setting Target="Adapter" Name="SSLConfig">ISC.FeatureTracker.SSL.Config</Setting>
    <Setting Target="Adapter" Name="URL">/post</Setting>
  </Item>
  <Item Name="Order Process" Category="" ClassName="Demo.Order.BP.OrderProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
