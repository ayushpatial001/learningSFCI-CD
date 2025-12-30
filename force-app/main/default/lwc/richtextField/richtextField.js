import { LightningElement, api, track } from 'lwc';

export default class RichtextField extends LightningElement {
    @api fieldValue = " ";
    @api fieldLabel;
    @api required;
    @api fieldLength;
    @api visibleLines;
    @api validity;
    @track errorMessage;

    allowedFormats = [
        'font',
        'size',
        'bold',
        'italic',
        'underline',
        'strike',
        'list',
        'indent',
        'align',
        'link',
        'image',
        'clean',
        'table',
        'header',
        'color',
        'background',
        'code',
        'code-block',
        'script',
        'blockquote',
        'direction',
    ];

    connectedCallback() {
        this.validity = true;
        document.documentElement.style.setProperty('--rta-visiblelines', (this.visibleLines * 2) + 'em');
    }

    handleChange(event) {
        if ((event.target.value).length > this.fieldLength) {
            this.validity = false;
            this.errorMessage = "You have exceeded the max length";
        } else {
            this.validity = true;
            this.fieldValue = event.target.value;
            this.errorMessage = "";
        }
    }
}