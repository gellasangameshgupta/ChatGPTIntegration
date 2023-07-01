import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class QutoteCreationButton extends NavigationMixin(LightningElement) {
    @api recordId;
    navigateToTab() {
        console.log('recordid:'+this.recordId);
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                //Name of any CustomTab. Visualforce tabs, web tabs, Lightning Pages, and Lightning Component tabs
                apiName: 'Quote_Creation_Wizard',
            },
            state: {
                c__recordId: this.recordId
            }
        });
    }

}