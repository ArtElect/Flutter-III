import { v4 as uuidv4 } from 'uuid';
import { IsString } from 'class-validator';

export class CreateAccount {
  image = 'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png';

  pseudo = `user-${uuidv4()}`;

  @IsString()
  userId!: string;
}
