import {IsOptional, IsString} from 'class-validator';

export class CreateAccountData {
  @IsString()
  firstname!: string;

  @IsString()
  lastname!: string;

  @IsString()
  pseudo!: string;
}

export class ModifyAccountData {
  @IsOptional()
  @IsString()
  image?: string;

  @IsOptional()
  @IsString()
  firstname?: string;

  @IsOptional()
  @IsString()
  lastname?: string;

  @IsOptional()
  @IsString()
  pseudo?: string;
}
