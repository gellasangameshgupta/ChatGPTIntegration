import { LightningElement, wire } from "lwc";
import getRecentAccountRecords from "@salesforce/apex/AccountRecordController.getAccountRecords";
import getRecentContactRecords from "@salesforce/apex/AccountRecordController.getAccountRecords";
import getRecentOpportunityRecords from "@salesforce/apex/AccountRecordController.getAccountRecords";


export default class AccountContactCarousel extends LightningElement {
    accountRecords = [];
    contactRecords = [];
    opportunityRecords = [];
  
    currentSlide = "account";

    @wire(getRecentAccountRecords)
    wiredAccountRecords({ error, data }) {
      if (data) {
        this.accountRecords = data;
      } else if (error) {
        console.error(error);
      }
    }

    @wire(getRecentContactRecords)
    wiredContactRecords({ error, data }) {
      if (data) {
        this.contactRecords = data;
      } else if (error) {
        console.error(error);
      }
    }

    @wire(getRecentOpportunityRecords)
    wiredOpportunityRecords({ error, data }) {
      if (data) {
        this.opportunityRecords = data;
      } else if (error) {
        console.error(error);
      }
    }

    get accountStyle() {
      return this.currentSlide === "account" ? "display: flex;" : "display: none;";
    }

    get contactStyle() {
      return this.currentSlide === "contact" ? "display: flex;" : "display: none;";
    }

    get opportunityStyle() {
      return this.currentSlide === "opportunity" ? "display: flex;" : "display: none;";
    }

    connectedCallback() {
      this.template.addEventListener("click", this.handleClick.bind(this));
    }

    disconnectedCallback() {
      this.template.removeEventListener("click", this.handleClick.bind(this));
    }

    handleClick(event) {
      const target = event.target;
      if (target.dataset.target) {
        const slides = this.template.querySelectorAll(".slide");
        for (let i = 0; i < slides.length; i++) {
          slides[i].classList.remove("current-slide");
          if (slides[i].dataset.slide === target.dataset.target) {
            slides[i].classList.add("current-slide");
            this.currentSlide = target.dataset.target;
          }
        }
      }
    }
  

}