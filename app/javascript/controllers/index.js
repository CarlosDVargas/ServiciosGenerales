// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import {application} from "./application"

import DropdownController from "./dropdown_controller"
import HelloController from "./hello_controller"
import NestedFormController from "./nested_form_controller"
import SelectController from "./select_controller"

application.register("dropdown", DropdownController)

application.register("hello", HelloController)

application.register("nested-form", NestedFormController)

application.register("select", SelectController)
