import { LightningElement } from 'lwc';

export default class CricketerList extends LightningElement {
    cricketers = [
        {
            Id: 1,
            Name: 'Rohit Sharma',
            Team: 'Mumbai Indians',
        },
        {
            Id: 2,
            Name: 'M S Dhoni',
            Team: 'Chennai Super Kings',
        },
        {
            Id: 3,
            Name: 'Virat Kohli',
            Team: 'Royal Challengers Banglore',
        },
        {
            Id: 4,
            Name: 'David Warner',
            Team: 'Sunrisers Hyderabad',
        },
    ];
}