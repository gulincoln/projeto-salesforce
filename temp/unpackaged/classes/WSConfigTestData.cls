@isTest
public class WSConfigTestData extends SObjectTestData {
    
    protected override Map<Schema.SObjectField, Object> getDefaultValueMap() {
        return new Map<Schema.SObjectField, Object>{
            webServiceConfig__c.end_point__c => 'http://teste.com.br/ws/',
            webServiceConfig__c.format__c => 'json',
            webServiceConfig__c.Service_Name__c => 'teste'
        };
    }
    
    protected override Schema.SObjectType getSObjectType() {
        return webServiceConfig__c.SObjectType;
    }
    
    public WSConfigTestData withServiceName(String nameService){
        return (WSConfigTestData)super.withDynamicData(webServiceConfig__c.Service_Name__c, nameService);   
    }
    public WSConfigTestData withEndPoint(String endPoint){
        return (WSConfigTestData)super.withDynamicData(webServiceConfig__c.end_point__c, endPoint);      
    }
    public WSConfigTestData withFormat(String format){
        return (WSConfigTestData)super.withDynamicData(webServiceConfig__c.format__c, format);          
    }
    public webServiceConfig__c insertWSConfig(){
        return (webServiceConfig__c)super.insertRecord();
    }
    
    public static WSConfigTestData instance {
        get {
            if (instance == null) instance = new WSConfigTestData();
            
            return instance;
        }
    }
    /**
    * @description Private constructor for singleton.
    */
    private WSConfigTestData() {
        super();
    }
}