@isTest
private class AccountCalloutTest {

    private static testMethod void testAccountCalloutWebServiceOk() {
        Account acc = new Account();
        User user1 = UserTestData.instance.withUserName('user1@teste.com').withCommunityNickName('nick_1').withSalesGroup('03222011').insertUser();
        
        webServiceConfig__c config = WSConfigTestData.instance.withServiceName('viacep').insertWSConfig();
        
        Test.startTest();        
        
        Test.setMock(HttpCalloutMock.class, WebServiceTestUtils.getMockRequest(200));
	    acc = AccountTestData.instance.withSalesGroup('03222011').withBillingState('SP').withBillingCity('SJC').withBillingStreet('Rua X').withPostalCode('01001000').insertAccount();
	    
	    Test.stopTest();
	    
	    Account resultAccount = [SELECT Id,AlternativeAddress__c,AlternativeState__c,AlternativePostalCode__c,AlternativeCity__c,AddressDiscrepancy__c FROM Account WHERE Id =: acc.Id];
	    
	    system.assertEquals('Praça da Sé', resultAccount.AlternativeAddress__c);
	    system.assertEquals('SP', resultAccount.AlternativeState__c);
	    system.assertEquals('01001-000', resultAccount.AlternativePostalCode__c);
	    system.assertEquals('São Paulo', resultAccount.AlternativeCity__c);
	    system.assertEquals(true, resultAccount.AddressDiscrepancy__c);
    }
    
}