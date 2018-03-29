public class AccountTriggerHandler implements ITriggerHandler{
    
    public void afterInsert(Map<Id, SObject> newItems) {
        AccountTriggerHelper.updateOwnerAccount( (List<Account>)newItems.values() );
        if(TriggerHandlerUtils.shouldRunTrigger()){
            AccountWebService.calloutAccountAddress(newItems.keyset());    
        }
    } 
    
    public void afterUpdate(Map<Id,SObject> newItems, Map<Id,SObject> oldItems){
        if(TriggerHandlerUtils.shouldRunTrigger() && TriggerHandlerUtils.runOnce()){
            AccountWebService.calloutAccountAddress(newItems.keyset());    
        }    
    }
    
}