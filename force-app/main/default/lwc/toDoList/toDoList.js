import { LightningElement,track } from 'lwc';

export default class ToDoList extends LightningElement {

    @track todoTasks = [];
    newTask = '';

    updateNewTask(event) {
        this.newTask = event.target.value;
    }

    addTaskToList(event) {
       
        this.todoTasks.push({
            id: this.todoTasks.length + 1,
            name: this.newTask
        });
        this.newTask = '';
    }
}