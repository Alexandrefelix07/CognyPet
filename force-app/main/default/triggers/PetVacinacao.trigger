trigger PetVacinacao on Pet__c (before insert,before update) {
    //validar se a o registro e criado e quando a data da ultima vacinação for preenchida  ou alterada.  
    for(pet__c c : Trigger.new){          
        if(Trigger.isUpdate ){        
            pet__c oldpet = Trigger.oldMap.get(c.ID); 
            if(c.Data_da_ltima_vacina_o__c != oldpet.Data_da_ltima_vacina_o__c && c.especie__c != null) {                    
                Prioridade_de_Vacina_o__mdt objRecord=[select inteervalo_em_dias__c,especie__c from Prioridade_de_Vacina_o__mdt where especie__c =:c.especie__c limit 1][0];                
                c.data_da_pr_xima_vacina_o__c = c.Data_da_ltima_vacina_o__c.addDays(Integer.valueOf(objRecord.inteervalo_em_dias__c));                 
            }                                                   
        }
        if(Trigger.isInsert ){
            if( c.Data_da_ltima_vacina_o__c != null && c.especie__c != null ) {                
                Prioridade_de_Vacina_o__mdt objRecord=[select inteervalo_em_dias__c,especie__c from Prioridade_de_Vacina_o__mdt where especie__c =:c.especie__c limit 1][0];               
                c.data_da_pr_xima_vacina_o__c = c.Data_da_ltima_vacina_o__c.addDays(Integer.valueOf(objRecord.inteervalo_em_dias__c));               
            }                       
        }           
    }    
}