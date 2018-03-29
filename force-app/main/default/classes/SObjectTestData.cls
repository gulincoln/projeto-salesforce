public abstract class SObjectTestData {
    
    private Map<Schema.SObjectField, Object> customValueMap;
    private Map<Schema.SObjectField, Object> defaultValueMap;
    
    public SObjectTestData() {
        customValueMap = new Map<Schema.SObjectField, Object>();
        defaultValueMap = getDefaultValueMap();
    }
    
    protected abstract Map<Schema.SObjectField, Object> getDefaultValueMap();
     
    protected SObjectTestData withDynamicData(Schema.SObjectField field, Object value) {
        customValueMap.put(field, value);
        return this;
    }
    
    private SObject build() {
        beforeBuild();
        SObject instance = getSObjectType().newSObject(null, true);
        Set<Schema.SObjectField> defaultFields = defaultValueMap.keySet().clone();
        defaultFields.removeAll(customValueMap.keySet());
        for (Schema.SObjectField field : defaultFields) {
            instance.put(field, defaultValueMap.get(field));
        }
        for (Schema.SObjectField field : customValueMap.keySet()) {
            instance.put(field, customValueMap.get(field));
        }
        afterBuild(instance);
        return instance;
    }

    protected SObject buildWithReset() {
        SObject instance = build();
        customValueMap = new Map<Schema.SObjectField, Object>();
        return instance;
    }
    
    protected SObject buildWithoutReset() {
        return build();
    }
    
    protected SObject insertRecord() {
        SObject instance = buildWithReset();
        beforeInsert(instance);
        insert instance;
        afterInsert(instance);
        return instance;
    }
  
    protected List<SObject> insertRecords(Integer numToInsert) {
        List<SObject> sobjectsToInsert = new List<SObject>();
        for (Integer i = 0; i < numToInsert; i++) {
            SObject sObj = buildWithoutReset();
            sobjectsToInsert.add(sObj);
            beforebulkInsert(sObj,i);
        }
        
        insert sobjectsToInsert;
        for (SObject sObj : sobjectsToInsert) {
            afterBulkInsert(sObj);
        }
        return sobjectsToInsert;
    }
    
    /**
    * @description These methods allows subclasses to invoke any action before/after
    * the SObject is built or inserted.
    */
    protected virtual void beforeBuild() {}
    
    protected virtual void afterBuild(SObject sObj) {}
    
    protected virtual void beforeInsert(SObject sObj) {}
    
    protected virtual void afterInsert(SObject sObj) {}
    
    protected virtual void beforeBulkInsert(SObject sObj, Integer num) {}
    
    protected virtual void afterBulkInsert(SObject sObj) {}
    
    protected abstract Schema.SObjectType getSObjectType();
    
}