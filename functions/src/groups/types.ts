import { IsString } from 'class-validator';

export class AddGroupData {
  @IsString()
  name!: string;

  @IsString()
  description!: string;
}
