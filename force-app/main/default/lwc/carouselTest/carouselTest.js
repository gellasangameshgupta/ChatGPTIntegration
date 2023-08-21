import { LightningElement,api } from 'lwc';

export default class CarouselTest extends LightningElement {
/*  connectedCallback() {
    // Get all slides and add a click event listener to each one
    const slides = this.template.querySelectorAll('.slide');
    slides.forEach((slide) => {
      slide.addEventListener('click', () => {
        // Get the link URL from the slide's anchor tag and navigate to it
        const link = slide.querySelector('a').href;
        window.location.href = link;
      });
    });
  } */

    @api slides = ['Slide 1', 'Slide 2', 'Slide 3'];
    @api autoPlayInterval = 3000; // Auto-play interval in milliseconds
  
    currentSlideIndex = 0;
  
    connectedCallback() {
      this.startAutoPlay();
    }
  
    disconnectedCallback() {
      this.stopAutoPlay();
    }
  
    startAutoPlay() {
      this.intervalId = setInterval(() => {
        this.moveToNextSlide();
      }, this.autoPlayInterval);
    }
  
    stopAutoPlay() {
      clearInterval(this.intervalId);
    }
  
    moveToNextSlide() {
      this.currentSlideIndex = (this.currentSlideIndex + 1) % this.slides.length;
    }
  
    get slideContainerClass() {
      return 'slides' + (this.currentSlideIndex > 0 ? ' slide-transition' : '');
    }
  
    get slideClass() {
      return 'slide' + (this.currentSlideIndex === 0 ? ' active' : '');
    }
  }