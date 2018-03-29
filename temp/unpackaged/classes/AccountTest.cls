@isTest
private class AccountTest {

	private static testMethod void updateOwnerAccountTest() {
	    User user1 = UserTestData.instance.withUserName('user1@teste.com').withCommunityNickName('nick_1').withSalesGroup('03222011').insertUser();
	    User user2 = UserTestData.instance.withUserName('use2@teste.com').withCommunityNickName('nick_2').withSalesGroup('03222012').insertUser();
        
        Test.startTest();
        system.runAs(user1){
            Account acc = AccountTestData.instance.withSalesGroup('03222012').insertAccount();
            
            Account resultAcc = [SELECT Id,OwnerId FROM Account WHERE Id =: acc.Id];
            
            system.assertEquals(user2.Id, resultAcc.OwnerId);
        }
        Test.stopTest();
        
	}
	
	private static testMethod void bulkUpdateOwnerAccountTest() {
	    User user0 = UserTestData.instance.withUserName('user1@teste.com').withCommunityNickName('nick_1').withSalesGroup('03222011').insertUser();
	    User user1 = UserTestData.instance.withUserName('use2@teste.com').withCommunityNickName('nick_2').withSalesGroup('00000001').insertUser();
	    User user2 = UserTestData.instance.withUserName('use3@teste.com').withCommunityNickName('nick_3').withSalesGroup('00000002').insertUser();
        
        Test.startTest();
        system.runAs(user0){
            List<Account> listAccounts = AccountTestData.instance.insertAccounts(3);
            
            List<Account> resultAccounts = [SELECT Id,salesGroupCode__c,OwnerId FROM Account WHERE Id IN :listAccounts ORDER BY CreatedDate ASC];
            
            system.assertEquals(user1.Id, resultAccounts.get(1).OwnerId);
            system.assertEquals(user2.Id, resultAccounts.get(2).OwnerId);
            
        }
        Test.stopTest();
	}
    
}