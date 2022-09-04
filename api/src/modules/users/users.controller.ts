import { Controller, Get, UseGuards, Request } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('user')
@ApiTags('user')
export class UsersController {
  @Get()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  public async login(@Request() req: any): Promise<string> {
    return req.user;
  }
}
