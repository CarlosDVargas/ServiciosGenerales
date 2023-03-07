import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["template", "add_item"];

    connect() {
        this.addDefaultOption();
        this.remove_associations();
    }

    add_association(event) {
        event.preventDefault();
        const random = Math.floor(Math.random() * 20);
        
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, random);
        this.add_itemTarget.insertAdjacentHTML('beforebegin', content);
        
        var input = document.getElementById("request_request_deny_reasons_attributes_" + random + "_reason");
        
        console.log(input);

        if (input === null) {
            input = document.getElementById("request_reopen_reasons_attributes_" + random + "_reason");
        }
        
        const select = document.getElementById("reasons");
        
        console.log(select);

        if (select.options[select.selectedIndex].text !== "Otro") {
            input.value = select.options[select.selectedIndex].text;
            input.readOnly = true;
        }
    }

    remove_association(event) {
        event.preventDefault();
        let item = event.target.closest(".nested-fields");
        item.querySelector("input[name*='_destroy']").value = 1;
        item.style.display = 'none';
    }

    remove_associations() {
        const items = document.querySelectorAll(".nested-fields");
        items.forEach(item => {
            item.querySelector("input[name*='_destroy']").value = 1;
            item.style.display = 'none';
        });
    }

    addDefaultOption() {
        const dropdown = document.getElementById("reasons");
        const option = document.createElement("option");
        option.text = "Seleccione una opción";
        option.value = "";
        option.selected = true;
        option.disabled = true;
        dropdown.insertBefore(option, dropdown.firstChild);
    }

}
