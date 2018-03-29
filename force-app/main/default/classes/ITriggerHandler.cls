public interface ITriggerHandler {
    void afterInsert(Map<Id,SObject> newItems);
    void afterUpdate(Map<Id,SObject> newItems, Map<Id,SObject> oldItems);
}