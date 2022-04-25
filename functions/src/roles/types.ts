import { IsString, IsArray } from 'class-validator';

export class AddRoleData {
  @IsString()
  accountId!: string;

  @IsString()
  groupId!: string;
}

export class ModifyRoleData {
  @IsArray()
  rightsId!: [string];
}
