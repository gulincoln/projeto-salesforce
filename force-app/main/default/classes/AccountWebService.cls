public class AccountWebService {
    
    @future(callout=true)
    public static void calloutAccountAddress(Set<Id> AccountIds){
        List<Account> listAccounts = AccountTriggerHelper.getValidAccounts(AccountIds);
        List<Account> listAccountsToUpdate = new List<Account>();
        
        if(listAccounts.isEmpty()) return;
        
        webServiceConfig__c viacepConfig = AccountWebServiceHelper.getWebServiceConfig(Label.viacep);
        
        for(Account acc : listAccounts){
            Http http = new Http();
            String endPoint = viacepConfig.end_point__c + acc.BillingPostalCode +'/'+ viacepConfig.format__c;
            
            HttpRequest req = new HttpRequest();
            req.setMethod('GET'); 
            req.setEndpoint(endPoint);
            
            HTTPResponse res = http.send(req);
            
            if(res.getStatusCode() == 200){
                AccountWebServiceHelper.Address address = (AccountWebServiceHelper.Address)JSON.deserialize(res.getBody(), AccountWebServiceHelper.Address.class); 
                
                if(address.erro != null){
                    new AccountWebServiceException(Label.Error_Message_from_Web_Service);
                    return;
                } 
                listAccountsToUpdate.add( AccountWebServiceHelper.updateAccountAddress(acc,address) );    
            }else{
                new AccountWebServiceException(Label.Error_Message_from_Web_Service); 
                return;
            }    
        }

        if(!listAccountsToUpdate.isEmpty()) Database.update(listAccountsToUpdate,false);
    }
    
}