import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["select", "hidden", "field"];
    static classes = ["hidden"];

    connect() {
        this.addDefaultOption();
        this.hiddenTarget.hidden = true;
    }

    select() {
        let options = this.selectTarget;
        let lastOptionIndex = options.length - 1;
        let lastOptionValue = options.options[lastOptionIndex].value;
        if (options.selectedIndex === lastOptionIndex) {
            this.hiddenTarget.hidden = false;
        } else {
            this.hiddenTarget.hidden = true;
        }
        if (lastOptionValue.includes('other')) {
            if (options.selectedIndex !== lastOptionIndex) {
                this.fieldTarget.value = options.value;
            } else {
                this.fieldTarget.value = "";
            }
        }
    }

    addDefaultOption() {
        const dropdown = this.selectTarget;
        const option = document.createElement("option");
        option.text = "Seleccione una opción";
        option.value = "";
        option.selected = true;
        option.disabled = true;
        dropdown.insertBefore(option, dropdown.firstChild);
    }

}