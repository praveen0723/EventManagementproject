public class LocationTriggerHandler {
    @future(callout=true)
    public static void verifyAddress(String recordId ){
        Location__c loc = [select id, Name, Street__c, City__c, Postal_code__c, 
                           State__c From Location__c WHERE Id= :recordId];
        String baseURL = 'https://us-street.api.smartystreets.com/street-address?auth-id=99edc2ca-2b5f-70fe-ad21-acaf02e76593&auth-token=Q7Q2f4OxRHVVjCxG0IZa';
        baseURL+='&street='+EncodingUtil.urlEncode(loc.Street__c, 'UTF-8')+'&city='+EncodingUtil.urlEncode(loc.City__c, 'UTF_8')+'&zipcode='+EncodingUtil.urlEncode(loc.Postal_code__c, 'UTF_8')+'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF_8');
           HttpRequest httpReq = new HttpRequest();
            httpReq.setMethod('GET');   
            httpReq.setEndpoint(baseURL);
            // httpReq.setHeader('Content-Type', 'application/json');
            Http http = new Http();
        HttpResponse httpres =new HttpResponse();
        try{
          httpres = http.send(httpReq);
            system.debug('response body'+httpres.getBody());
            if(httpres.getStatusCode() == 200 && httpres.getStatus()=='Ok'){
                String responseBody = httpres.getBody();
                if(!String.isBlank(responseBody)&&responseBody.length()>2){
                    loc.Verified__c=true;
                }else{
                   loc.Verified__c=false; 
                }
                update loc;
            }else{
                TransactionLogHandler.doHandleExceptionWithError(httpres.getBody() , 'LocationTriggerHandler');
            }
        }catch(System.CalloutException ex ){
            system.debug('Exception Executed'+ex.getStackTraceString());
         TransactionLogHandler.doHandleExeption(ex, 'LocationTriggerHandler');  
        } 
    }
}