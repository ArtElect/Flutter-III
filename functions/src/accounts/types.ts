import { IsString } from 'class-validator';

export class CreateAccountData {
  @IsString()
  userId!: string;
}

export class ModifyAccountData {
  @IsString()
  image!: string;
}
