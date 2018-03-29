public class AccountWebServiceException extends Exception {
    public AccountWebServiceException(String status, Integer statusCode){
        throw new AccountWebServiceException(Label.Error_Message_from_Web_Service+' StatusCode: '+statusCode+' Status: '+status);
    }
}