import { IsString } from 'class-validator';

export class AddPostData {
  likes = [];

  tags: [string] = [''];

  @IsString()
  image!: string;

  @IsString()
  description!: string;
}
