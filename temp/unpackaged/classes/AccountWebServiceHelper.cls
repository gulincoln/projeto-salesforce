public class AccountWebServiceHelper {
    
    public static webServiceConfig__c getWebServiceConfig(String configName){
        return [SELECT Id,end_point__c,format__c FROM webServiceConfig__c WHERE Service_Name__c = :configName];   
    }
    
    public static Account updateAccountAddress(Account acc, Address address){
        
        if(address.erro!=null) throw new AccountWebServiceException(Label.invalid_postal_code);
        
        if( (!String.valueof(acc.BillingState).equalsIgnoreCase(address.uf)) 
            || (!String.valueOf(acc.BillingStreet).equalsIgnoreCase(address.logradouro)) 
            || (!String.valueof(acc.BillingCity).equalsIgnoreCase(address.localidade)) )
        {
            acc.AlternativePostalCode__c = address.cep;
            acc.AlternativeState__c = address.uf;
            acc.AlternativeAddress__c = address.logradouro;
            acc.AlternativeCity__c = address.localidade;
            acc.AddressDiscrepancy__c = true;
        }
        
        return acc;
    }
    
    //inner class 
    public class Address{
        public String erro;
        public String cep;
        public String logradouro;
        public String complemento;
        public String bairro;
        public String localidade;
        public String uf;
        public String unidade;
        public String ibge;
        public String gia;
    }
}