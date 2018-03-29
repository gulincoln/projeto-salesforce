public class AccountTriggerHelper {
    
    public static void updateOwnerAccount(List<Account> listAccounts){
        Map<String,User> mapUserBySalesGroup = new Map<String,User>();
        
        for(Account acc : listAccounts){
            mapUserBySalesGroup.put(acc.salesGroupCode__c,null);        
        }
        
        for(User usr : [ SELECT Id,salesGroupCode__c FROM User WHERE salesGroupCode__c IN :mapUserBySalesGroup.keySet() ] ){
            if(mapUserBySalesGroup.containsKey(usr.salesGroupCode__c)){
                mapUserBySalesGroup.put(usr.salesGroupCode__c,usr);    
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : listAccounts){
            if(mapUserBySalesGroup.get(acc.salesGroupCode__c) != null){
                Account accClone = acc.clone(true,true);
                accClone.OwnerId = mapUserBySalesGroup.get(acc.salesGroupCode__c).Id;
                accountsToUpdate.add(accClone);
            }   
        }
        
        if(!accountsToUpdate.isEmpty()) Database.update(accountsToUpdate,false);
    }
    
    public static List<Account> getValidAccounts(Set<Id> AccountIds){
        Map<Id,Account> mapAccounts = new Map<Id,Account>( getAccounts(AccountIds) );
        
        for(Account acc : mapAccounts.values()){
            if(!isValidPostalCode(acc)) mapAccounts.remove(acc.Id);
        }
        
        return mapAccounts.values();
    }
    
    private static boolean isValidPostalCode(Account acc){
        if(String.valueOf(acc.BillingPostalCode).isNumeric() ) return true;
        return false;
    }

    private static List<Account> getAccounts(Set<Id> AccountIds){
        return [SELECT Id,BillingPostalCode,BillingStreet,BillingCity,BillingState FROM Account WHERE Id IN: AccountIds AND BillingPostalCode != null];
    }
}