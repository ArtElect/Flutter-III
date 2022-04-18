import { IsString } from 'class-validator';

export class AddRoleData {
  @IsString()
  accountId!: string;

  @IsString()
  groupId!: string;
}
