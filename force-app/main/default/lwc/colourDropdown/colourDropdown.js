import { LightningElement } from 'lwc';

export default class ColourDropdown extends LightningElement {

    value = 'Red';

    get options() {
        return [
            { label: 'Red', value: 'Red' },
            { label: 'Green', value: 'Green' },
            { label: 'Blue', value: 'Blue' },
            { label: 'Yellow', value: 'Yellow' },
            { label: 'Black', value: 'Black' }
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}