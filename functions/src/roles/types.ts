import { IsString, IsOptional, IsIn } from 'class-validator';

export class AddRoleData {
  @IsString()
  accountId!: string;

  @IsString()
  groupId!: string;
}

export class ModifyRoleData {
  @IsOptional()
  @IsIn(['USER', 'MANAGER'])
  type!: string;
}
