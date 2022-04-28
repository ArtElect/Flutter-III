import { IsString, IsOptional } from 'class-validator';

export class AddGroupData {
  @IsString()
  name!: string;

  @IsString()
  description!: string;

  @IsString()
  image!: string;
}

export class ModifyGroupData {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  image?: string;
}
