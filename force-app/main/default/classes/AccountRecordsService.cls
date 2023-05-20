@RestResource(URLMapping='/Accountsseervice/*')
Global class AccountRecordsService {
    @HttpGet
    Global static List<Account> GetAllAccounts()
    {
        List<Account> lstAccounts = [Select id, name, rating, annualrevenue, phone, fax, type, 
                                              ownership, customerpriority__C, active__c 
                                                   from Account order by name];
        return lstAccounts;
    }
}