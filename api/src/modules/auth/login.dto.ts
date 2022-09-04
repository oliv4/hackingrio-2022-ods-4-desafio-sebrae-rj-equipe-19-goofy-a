import { ApiProperty } from '@nestjs/swagger';

export class LoginDto {
  @ApiProperty({
    default: 'hackingrio',
  })
  username: string;

  @ApiProperty({
    default: 'blockchain',
  })
  password: string;
}
