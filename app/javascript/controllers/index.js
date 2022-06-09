// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import NestedFormController from "./nested_form_controller.js"
application.register("nested-form", NestedFormController)

import SelectController from "./select_controller.js"
application.register("select", SelectController)
