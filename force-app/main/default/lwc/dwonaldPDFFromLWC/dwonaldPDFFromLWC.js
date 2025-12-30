import { LightningElement, track } from 'lwc';
import generatePdf from '@salesforce/apex/storsdcfasfasd.generatePdf';

export default class InputName extends LightningElement {
    @track name = '';

    handleNameChange(event) {
        this.name = event.target.value;
    }

    handleDownload() {
        generatePdf({ name: this.name })
            .then((result) => {
                const link = document.createElement('a');
                link.href = 'data:application/pdf;base64,' + result;
                link.download = `Name_${this.name}.pdf`;
                link.click();
            })
            .catch((error) => {
                console.error('Error generating PDF:', error);
            });
    }
}