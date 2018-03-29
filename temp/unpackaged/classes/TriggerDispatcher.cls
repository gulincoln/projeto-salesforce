public class TriggerDispatcher {
    public static void run(ITriggerHandler triggerHandler){
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                triggerHandler.afterInsert(Trigger.newMap);    
            }
            if(Trigger.isUpdate){
                triggerHandler.afterUpdate(Trigger.newMap,Trigger.oldMap);    
            }
        }
    }
}