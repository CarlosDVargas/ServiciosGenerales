import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["template", "add_item"];

    add_association(event) {
        const random = Math.floor(Math.random() * 20);
        event.preventDefault();
        const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, random);
        this.add_itemTarget.insertAdjacentHTML('beforebegin', content);
        const input = document.getElementById("request_request_deny_reasons_attributes_" + random + "_reason");
        const select = document.getElementById("deny_reasons");
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

}
