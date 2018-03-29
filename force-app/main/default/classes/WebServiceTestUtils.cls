@isTest
public class WebServiceTestUtils {

    public static StaticResourceCalloutMock getMockRequest(Integer statusCode){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mock_address');
        mock.setStatusCode(statusCode);
        mock.setHeader('Content-Type', 'application/json');  
        
        return mock;
    }
    
    public static StaticResourceCalloutMock getInvalidMockRequest(Integer statusCode){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mock_invalid_address');
        mock.setStatusCode(statusCode);
        mock.setStatus('Error');
        mock.setHeader('Content-Type', 'application/json');  
        
        return mock;
    }
}