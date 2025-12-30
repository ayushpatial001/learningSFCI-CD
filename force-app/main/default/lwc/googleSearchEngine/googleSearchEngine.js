import { LightningElement, track } from 'lwc';
import getGoogleSearchResults from '@salesforce/apex/GoogleSearchEngine.SearchingResult';

export default class GoogleSearchComponent extends LightningElement {
    @track query = '';
    @track results = [];
    @track error;

    handleInputChange(event) {
        this.query = event.target.value;
    }

    handleSearch() {
        console.log('This is working');
        getGoogleSearchResults({ query: this.query })
            .then(result => {
                console.log('result', result);
                this.results = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.results = [];
            });
    }
}