@isTest
public class UserTestData extends SObjectTestData{
    private static Integer randomNumber;
    
    protected override Map<Schema.SObjectField, Object> getDefaultValueMap() {
        return buildDefaultUser();
    }
    
    public override Schema.SObjectType getSObjectType(){
        return User.SObjectType;
    }
    
    public UserTestData withLastName(String name){
        return (UserTestData)super.withDynamicData(User.LastName, name);    
    }
    
    public UserTestData withUserName(String username){
        return (UserTestData)super.withDynamicData(User.Username, username);    
    }
    
    public UserTestData withSalesGroup(String salesGroup){
        return (UserTestData)super.withDynamicData(User.salesGroupCode__c, salesGroup);    
    }
    
    public UserTestData withCommunityNickName(String commNickName){
        return (UserTestData)super.withDynamicData(User.CommunityNickName, commNickName);    
    }
    
    public User insertUser(){
        return (User)super.insertRecord();
    }
    
    public List<User> insertUsers(Integer numberOfRecords){
        return (List<User>)super.insertRecords(numberOfRecords);
    }
    
    public static UserTestData instance {
        get{
            if(instance==null) instance = new UserTestData();
            
            return instance;
        }
    }

    private Map<Schema.SObjectField, Object> buildDefaultUser(){
        List<SObject> listUserData = Test.loadData(User.SObjectType,'Users');
        List<User> defaultUser = (List<User>)listUserData;
        
        return new Map<Schema.SObjectField, Object>{
            User.Username => defaultUser[0].Username,
            User.LastName => defaultUser[0].LastName,
            User.Email => defaultUser[0].Email,
            User.CommunityNickName => defaultUser[0].CommunityNickName,
            User.TimeZoneSidKey => defaultUser[0].TimeZoneSidKey,
            User.LocaleSidKey => defaultUser[0].LocaleSidKey,
            User.EmailEncodingKey => defaultUser[0].EmailEncodingKey,
            User.ProfileId => defaultUser[0].ProfileId,
            User.salesGroupCode__c => defaultUser[0].salesGroupCode__c,
            User.Alias => defaultUser[0].Alias,
            User.LanguageLocaleKey => defaultUser[0].LanguageLocaleKey
            
        };    
    }
    
    /**
    * @description Private constructor for singleton.
    */
    private UserTestData(){
        super();
    }
}