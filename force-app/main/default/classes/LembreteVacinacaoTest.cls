@isTest
private class LembreteVacinacaoTest {
    public static String CRON_EXP = '0 0 0 * * ?';
    
    @isTest
    static void testScheduledLembrete() {
   
        List<pet__c> pets = new List<pet__c>();      
        
        for (Integer i=0; i<5; i++) {
            pet__c pet = new pet__c(                
               Name = 'Pet ' + i,        
               especie__c = 'Cachorro',  
               Ra_a__c = 'Vira-lata', 
               Data_da_ltima_vacina_o__c = Date.today().addYears(-3)     
            );
            pets.add(pet);
        }
        insert pets;
        
        Map<Id, pet__c> petMap = new Map<Id, pet__c>(pets);
        List<Id> petIds = new List<Id>(petMap.keySet());
        
        Test.startTest();
        String jobId = System.schedule('Scheduled', CRON_EXP, new LembreteVacinacao());
        
        List<Task> lt = [SELECT Id  FROM Task  WHERE WhatId IN :petIds];       
        System.assertEquals(0, lt.size(), 'Tasks exist');

        Test.stopTest();
    
        lt = [SELECT Id FROM Task  WHERE WhatId IN :petIds];
        System.assertEquals(petIds.size(), lt.size(),'Tasks not created');
        
        pets[0].Data_da_ltima_vacina_o__c = Date.today().addYears(-2);
        update pets;               
    }
    @isTest
    static void testUltimaVacinacao() {
        pet__c pet = new pet__c(                
            Name = 'Pet teste',               
            especie__c = 'Cachorro', 
            Ra_a__c = 'Vira-lata', 
            Data_da_ltima_vacina_o__c = Date.today().addYears(-3)     
        );
        insert pet;  
        
        historico_de_vacina_o__c hvac = new historico_de_vacina_o__c(                
            local__c = 'casa do animal',
            pet__c = pet.Id,                       
            data__c = Date.today()         
        );
        insert hvac;
        
       Contact cont = new Contact( 
            LastName = 'teste',
            Birthdate = Date.today().addYears(-18)          
        );
        insert cont; 
        
        ado_o__c ado = new ado_o__c(                           
            pet__c = pet.Id,    
            Contato__c = cont.Id,
            Status__c = 'Reprovada',
            data__c = Date.today()         
        );
        insert ado;                   
    }    
}