"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AssignRoleData = exports.ModifyRoleData = exports.AddRoleData = void 0;
const class_validator_1 = require("class-validator");
class AddRoleData {
}
__decorate([
    class_validator_1.IsString()
], AddRoleData.prototype, "groupId", void 0);
__decorate([
    class_validator_1.IsString()
], AddRoleData.prototype, "name", void 0);
__decorate([
    class_validator_1.IsArray()
], AddRoleData.prototype, "rightsId", void 0);
exports.AddRoleData = AddRoleData;
class ModifyRoleData {
}
__decorate([
    class_validator_1.IsArray()
], ModifyRoleData.prototype, "rightsId", void 0);
exports.ModifyRoleData = ModifyRoleData;
class AssignRoleData {
}
__decorate([
    class_validator_1.IsString()
], AssignRoleData.prototype, "accountId", void 0);
exports.AssignRoleData = AssignRoleData;
//# sourceMappingURL=types.js.map