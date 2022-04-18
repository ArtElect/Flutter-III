import { IsString } from 'class-validator';

export class CreateAccountData {
  @IsString()
  userId!: string;
}
