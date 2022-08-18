public class LembreteVacinacao implements Schedulable{

    public void execute(SchedulableContext sc) {  
      run();
   }

    public void run(){
        List<Task> insertTask = new List<Task>();  
        for (pet__c pet : [select Id,ownerId,Name,data_da_pr_xima_vacina_o__c from pet__c ] ){  
            if (System.today() > pet.data_da_pr_xima_vacina_o__c){                   
                Task task = new Task(); 
                Task.ActivityDate = pet.data_da_pr_xima_vacina_o__c;
                task.WhatId = pet.Id;
                task.OwnerId = pet.ownerId;
                Task.Status = 'Not Started';  
                Task.Priority = 'Higth'; 
                Task.Subject  ='Vacinar o animal '+ pet.Name; 
                task.Description = 'Vacinar o animal '+ pet.Name;
                insertTask.add(task);                                 
            }   
        }        
       if (! insertTask.isEmpty() ) {
         insert insertTask; 
       }         
    }
}