public class DMLHelper 
{
    Public static void DeactivateUserByName(String uName)
    {
        if(uName !=Null&& uName !='')
        {
            User userToDeActivate= [Select id, firstname, lastname, username, isActive 
                                    from user
                                           Where username=: uName and isActive =true];
            if(userToDeActivate.id != Null)
            {
                userToDeActivate.IsActive=false;
                Update userToDeActivate;
            }
        }
    }
  Public static void UpdateAccountDetails()
  {
      List<Account> lstAccounts=[Select id, name, rating, industry, annualrevenue, type, active__c 
                                 from Account 
                                 Where Rating = 'warm'];
      if(! lstAccounts.isEmpty())
      {
          for(Account accRecord : lstAccounts)
          {
              accRecord.Industry='Communications';
          accRecord.AnnualRevenue=450000000;
          accRecord.Type='Installation Partner';  
           }
      Update lstAccounts;
     }
  }
}