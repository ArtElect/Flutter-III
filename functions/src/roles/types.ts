import { IsString, IsArray } from 'class-validator';

export class AddRoleData {
  @IsString()
  groupId!: string;

  @IsString()
  name!: string;

  @IsArray()
  rightsId!: [string];
}

export class ModifyRoleData {
  @IsArray()
  rightsId!: [string];
}

export class AssignRoleData {
  @IsString()
  accountId!: string;
}
