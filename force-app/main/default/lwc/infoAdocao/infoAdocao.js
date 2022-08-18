import { LightningElement, api  } from 'lwc';

export default class InfoAdocao extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = ['Pet__c','Data__c'];

}