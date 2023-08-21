/* import { LightningElement,track ,api} from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';
import { NavigationMixin } from 'lightning/navigation';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';

export default class EmbeddedLWCWithFlow extends  NavigationMixin(LightningElement) {

    @track isShowModal = true;


    hideModalBox() {  
        this.isShowModal = false;
        const finishEvent = new FlowNavigationFinishEvent();
       this.dispatchEvent(finishEvent);
       this.navigateToAccountRecord();
    }

    handleNext(){
        const next = new FlowNavigationNextEvent();
        this.dispatchEvent(next);
    }

    navigateToAccountRecord() {
        console.log('entered ');
        this[NavigationMixin.Navigate]({
          type: 'standard__recordPage',
          attributes: {
            recordId: '0015g00000tkJYjAAM', // Replace with the actual record Id
            objectApiName: 'Account',
            actionName: 'view'
          }
        });
      }
} */
import { LightningElement, track } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import { FlowNavigationFinishEvent, FlowNavigationNextEvent } from 'lightning/flowSupport';
import { NavigationMixin } from 'lightning/navigation';

export default class EmbeddedLWCWithFlow extends NavigationMixin(LightningElement) {
  @track isShowModal = false;

  hideModalBox() {
    this.isShowModal = false;
    const finishEvent = new FlowNavigationFinishEvent();
    this.dispatchEvent(finishEvent);
    this.handleNavigation();
    //alert('inside hide modal box');
  }
  handleModal(){
    this.isShowModal = true;
  }

  handleNext() {
    const next = new FlowNavigationNextEvent();
    this.dispatchEvent(next);
  }

  async handleNavigation() {
    await Promise.resolve();
    this.navigateToAccountRecord();
  }

  navigateToAccountRecord() {
    try {
               this[NavigationMixin.Navigate]({
          type: 'standard__recordPage',
          attributes: {
            recordId: '0015g00000tkJYjAAM', // Replace with the actual record Id
            objectApiName: 'Account',
            actionName: 'view'
          }
        });
      } catch (error) {
        console.error('Navigation error: ', error);
      }
}
}

// this[NavigationMixin.GenerateUrl]({
//   type: 'standard__recordPage',
//     attributes: {
//       recordId: '0015g00000tkJYjAAM', // Replace with the actual record Id
//       objectApiName: 'Account',
//       actionName: 'view'
//     }
// }).then(url => {
// window.open(url, "_blank");
// });