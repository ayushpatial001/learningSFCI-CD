import { LightningElement, track } from 'lwc';

export default class TodoTask extends LightningElement {
    @track storeTodayTask = []; // Ensure reactivity with @track
    @track title;
    @track body;
    @track isThereanyTask = false;
    @track date= new  Date().toLocaleDateString()
    item = 0;

    onChangetitle(event) {
        this.title = event.target.value;
        console.log(this.title);
    }

    onChangebody(event) {
        this.body = event.target.value;
        console.log(this.body);
    }

    onClickHandle() {
        console.log('This is working fine');
        if (this.title && this.body) {
            this.storeTodayTask = [
                ...this.storeTodayTask,
                {
                    id: this.item, 
                    date: new Date().toLocaleDateString(), 
                    title: this.title,
                    body: this.body
                }
            ];
            this.item += 1;
            console.log('this.storeTodayTask-->', this.storeTodayTask);
            this.isThereanyTask = true;
            
        } else {
            console.log('Title or Body is missing');
        }
        
    }
    onSuccess(event){
        console.log('this is OnScucces Method');
        console.log( event.currentTarget.dataset.id);
        const task = this.storeTodayTask.find(p => p.id == event.currentTarget.dataset.id );
        console.log('the value to store task ', task.date);
    }


    onRemove(event){

          console.log('This is the onRemove Method');
          console.log( event.target.dataset.id);
          const index = this.storeTodayTask.indexOf(event.target.dataset.id);
          console.log('index -- >', index);
              this.storeTodayTask.splice(index, 1); 
              this.storeTodayTask = [...this.storeTodayTask];
        console.log('this.storeTodayTask -->', this.storeTodayTask);
    }



}