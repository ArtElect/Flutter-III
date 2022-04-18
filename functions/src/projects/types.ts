import { IsString } from 'class-validator';

export class AddProjectData {
  @IsString()
  title!: string;

  @IsString()
  description!: string;

  @IsString()
  groupId!: string;
}
