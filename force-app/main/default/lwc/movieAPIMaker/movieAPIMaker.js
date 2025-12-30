import { LightningElement,track,wire } from 'lwc';
import sendData from '@salesforce/apex/MovieApi.sendData';
import { publish, MessageContext } from 'lightning/messageService';
import MovieMessageChannel from '@salesforce/messageChannel/Get_Case__c';


export default class MovieAPIMaker extends LightningElement {
    movieName;
    @track data = [];
    @track movieName;
    @track imgURL;
    visibility = false;

    @wire(MessageContext)
    MessageContext

    onChangeHandler(event){
       this.movieName = event.target.value;
       console.log('this is working fine', this.movieName);

    }
    
    sendData(){
      sendData({movieName: this.movieName}).then(data => {
       if(data){
         this.visibility = true;
       
        

         this.data = JSON.parse(data);
         let nameConstant = this.data.Title;
         this.movieName = nameConstant;
         this.imgURL = this.data.Poster;
         const payload = {
            movieName : this.data.Title,
            movieImage : this.data.Poster,
            Description : this.data.Plot,
            Rating : this.data.Rated,
            Country : this.data.Country,
          }
        publish(this.MessageContext,MovieMessageChannel,payload);
        alert(JSON.parse(payload));
         console.log(this.data.Title);
         console.log(this.data.Poster);
       }else{
         console.log('This is not the data');
       }

      });
    }

}