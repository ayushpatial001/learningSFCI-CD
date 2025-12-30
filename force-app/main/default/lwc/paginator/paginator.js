import { LightningElement, api } from 'lwc';
/* eslint-disable no-console */
/* eslint-disable no-alert */
export default class Paginator extends LightningElement {
    @api
    changeView(str) {
        const previousButton = this.template.querySelector('lightning-button.Previous');
        const nextButton = this.template.querySelector('lightning-button.Next');

        if (previousButton && nextButton) {
            if (str === 'trueprevious') {
                previousButton.disabled = true;
            }
            if (str === 'falsenext') {
                nextButton.disabled = false;
            }
            if (str === 'truenext') {
                nextButton.disabled = true;
            }
            if (str === 'falseprevious') {
                previousButton.disabled = false;
            }
        }
    }

    renderedCallback() {
        const previousButton = this.template.querySelector('lightning-button.Previous');
        if (previousButton) {
            previousButton.disabled = true;
        }
    }

    previousHandler1() {
        this.dispatchEvent(new CustomEvent('previous'));
    }

    nextHandler1() {
        this.dispatchEvent(new CustomEvent('next'));
    }

    FirstPageHandler1() {
        this.dispatchEvent(new CustomEvent('firstpage'));
    }

    LastPageHandler1() {
        this.dispatchEvent(new CustomEvent('lastpage'));
    }

    changeHandler(event) {
        event.preventDefault();
        const s_value = event.target.value;
        const selectedEvent = new CustomEvent('selected', { detail: s_value });

        this.dispatchEvent(selectedEvent);
    }
}