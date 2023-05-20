global class DeleteEventBatch implements Database.Batchable<sobject> {
    global Database.QueryLocator start(Database.BatchableContext batchcontext){
        String Query ='Select id, Name From Event__c where Live__c=true AND End_Date_Time__c<LAST_N_MONTHS:2';
        return Database.getQueryLocator(Query);
    }
     global void execute(Database.BatchableContext batchcontext,List<Event__c> eventlist){
         if(!eventlist.isEmpty()){
             List<Database.DeleteResult> deleteResult = Database.delete(eventlist);
             for(Database.DeleteResult dr:deleteResult){
                 if(!dr.isSuccess()){
                     List<Database.Error> errors = dr.getErrors();
                     String errorInString = String.join(errors, ',');
                    TransactionLogHandler.doHandleExceptionWithError(errorInString, 'DeleteEventBatch');
                     
                 }  
             }
           }
    }
     global void finish(Database.BatchableContext batchcontext){
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Batch Processing Completed');
            List<String> toAddress = new List<String>();
            toAddress.add('praveenejjigiri041@gmail.com');
            mail.setToAddresses( toAddress );
            mail.setSenderDisplayName('Praveen Ejjigiri');
            mail.setHtmlBody('The DeleteEventBatch Batch Proccesing has been Completed');
         Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mail});
    }
}