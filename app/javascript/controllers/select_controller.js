import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["select", "hidden", "field"];
    static classes = ["hidden"];

    connect() {
        console.log("connect select");
        var option = document.createElement("option");
        option.text = "Seleccione una opción";
        option.selected = true;
        option.disabled = true;
        this.selectTarget.add(option);
        this.hiddenTarget.hidden = true;
    }

    select() {
        let options = this.selectTarget
        let optionsAmount = options.length - 1;
        let lastOptionIndex = optionsAmount - 1;
        let lastOptionValue = options.options[lastOptionIndex].value;
        if (options.selectedIndex == lastOptionIndex) {
            this.hiddenTarget.hidden = false;
        } else {
            this.hiddenTarget.hidden = true;
        }
        if (lastOptionValue.includes('other')) {
            if (options.selectedIndex != lastOptionIndex) {
                this.fieldTarget.value = options.value;
            } else {
                this.fieldTarget.value = "";
            }
        }
    }

}