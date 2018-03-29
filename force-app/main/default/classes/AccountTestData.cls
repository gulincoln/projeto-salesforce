@isTest
public class AccountTestData extends SObjectTestData {

    protected override Map<Schema.SObjectField, Object> getDefaultValueMap() {
        return new Map<Schema.SObjectField, Object>{
            Account.Name => 'Test Account ',
            Account.salesGroupCode__c => '0000000'
        };
    }
    
    protected override Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }
    
    protected override void beforeBulkInsert(SObject sObj, Integer num){
        Account acc = (Account)sObj;
        acc.salesGroupCode__c = '0000000'+num;
        acc.Name = 'Account Teste '+num;
    }
    
    public AccountTestData withPostalCode(String postalCode) {
        return (AccountTestData)super.withDynamicData(Account.BillingPostalCode, postalCode);
    }
    
    public AccountTestData withBillingState(String billingState) {
        return (AccountTestData)super.withDynamicData(Account.BillingState, billingState);
    }
    
    public AccountTestData withBillingStreet(String billingStreet) {
        return (AccountTestData)super.withDynamicData(Account.BillingStreet, billingStreet);
    }
    
    public AccountTestData withBillingCity(String billingCity) {
        return (AccountTestData)super.withDynamicData(Account.BillingCity, billingCity);
    }
    
    public AccountTestData withName(String name) {
        return (AccountTestData)super.withDynamicData(Account.Name, name);
    }
    
    public AccountTestData withSalesGroup(String salesGroup) {
        return (AccountTestData)super.withDynamicData(Account.salesGroupCode__c, salesGroup);
    }

    public Account insertAccount() {
        return (Account)super.insertRecord();
    }
    
    public List<Account> insertAccounts(Integer numberOfRecords) {
        return (List<Account>)super.insertRecords(numberOfRecords);
    }
    
    public static AccountTestData instance {
        get {
            if (instance == null) instance = new AccountTestData();
            
            return instance;
        }
    }
    /**
    * @description Private constructor for singleton.
    */
    private AccountTestData() {
        super();
    }
}