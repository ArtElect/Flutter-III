"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ModifyProjectData = exports.AddProjectData = void 0;
const class_validator_1 = require("class-validator");
class AddProjectData {
}
__decorate([
    class_validator_1.IsString()
], AddProjectData.prototype, "title", void 0);
__decorate([
    class_validator_1.IsString()
], AddProjectData.prototype, "description", void 0);
__decorate([
    class_validator_1.IsString()
], AddProjectData.prototype, "image", void 0);
exports.AddProjectData = AddProjectData;
class ModifyProjectData {
}
__decorate([
    class_validator_1.IsOptional(),
    class_validator_1.IsString()
], ModifyProjectData.prototype, "title", void 0);
__decorate([
    class_validator_1.IsOptional(),
    class_validator_1.IsString()
], ModifyProjectData.prototype, "description", void 0);
exports.ModifyProjectData = ModifyProjectData;
//# sourceMappingURL=types.js.map