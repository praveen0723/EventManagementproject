public class TransactionLogHandler {
    public static void doHandleExeption(system.Exception ex , String processName){
        Error_Log__c transacionLog = new Error_Log__c(
            Log_Details__c= ex.getStackTraceString() +'<br/> <strong>Message is </strong>' + ex.getMessage()
            + '<br/>' + ex.getCause() +'<br/>' + ex.getTypeName()+'<br/>' +ex.getLineNumber(),
            Lod_DateTime__c	 = System.now(),
            Process_Name__c= processName
            );
       
            insert transacionLog;
        
    }
    public static void doHandleExceptionWithError(String errors, String processName){
        Error_Log__c transacionLog = new Error_Log__c(
            Log_Details__c= errors,
            Lod_DateTime__c	 = System.now(),
            Process_Name__c= processName
            );
       
            insert transacionLog;
        
    }
}