import { IsString, IsOptional } from 'class-validator';

export class AddProjectData {
  @IsString()
  title!: string;

  @IsString()
  description!: string;

  @IsString()
  image!: string;
}

export class ModifyProjectData {
  @IsOptional()
  @IsString()
  title?: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsString()
  image?: string;
}
