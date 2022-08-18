trigger UltimaVacinacao on Historico_de_vacina_o__c (before insert) {
    //Atualiza a data da ultima vacinação do cadastro do pet quando a cartao de vacinação e criado.
    Set<Id> setPositionID = new Set<ID>();	
    for(historico_de_vacina_o__c c:trigger.new){
		setPositionID.add(c.pet__c);
        pet__c pet = [select id from pet__c  where id =:setPositionID];      
    	if (c.data__c != null || pet.Data_da_ltima_vacina_o__c < c.data__c ){                                            
            pet.Data_da_ltima_vacina_o__c = c.data__c;
            update pet;                         
	   } 
	}
}