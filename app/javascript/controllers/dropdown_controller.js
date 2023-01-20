import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

    workBuildings = null;

    connect() {
        this.fetchData("request_work_building");
    }

    workBuilding(event) {
        const select = event.target;
        this.selectedWorkBuilding = select.options[select.selectedIndex].text;
        if (select.selectedIndex !== 0) {
            this.removeOptionsFor("request_work_location")
            const workLocations = this.workBuildings[select.selectedIndex - 1].work_locations;
            if (workLocations != null && workLocations.length > 0) {
                this.createOptionsFor("request_work_location", workLocations);
            } else {

            }
        }
    }

    fetchData(item, name = "name") {
        console.log("fetching");
        const items = `${item}s`;
        const path = `/${items}`;
        fetch(path).then(response => response.json()).then(data => {
            this.workBuildings = data;
            this.createOptionsFor(item, data, name);
        })
    }

    createOptionsFor(id, data, name = "name") {
        const dropdown = document.getElementById(id);
        dropdown.innerHTML = `<option value="">Seleccione una opción</option>`;
        data.forEach(item => {
            const option = document.createElement("option");
            option.value = item.id;
            option.text = item[`${name}`];
            dropdown.appendChild(option);
        })
    }

    removeOptionsFor(id) {
        const dropdown = document.getElementById(id);
        var i, L = dropdown.options.length - 1;
        for (i = L; i >= 0; i--) {
            dropdown.remove(i);
        }
    }
}