import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { LoginDto } from './login.dto';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtTokenService: JwtService,
  ) {}

  async validateUserCredentials(
    username: string,
    password: string,
  ): Promise<any> {
    const user = await this.usersService.findUserByUsername(username);
    if (user && user.username === username && user.password === password) {
      const { username, ...result } = user;
      return result;
    }

    return null;
  }

  async loginWithCredentials(user: any): Promise<string> {
    const payload = {
      username: user.username,
      sub: user.id,
    };
    return this.jwtTokenService.sign(payload);
  }

  public async login(payload: LoginDto): Promise<string> {
    const user = await this.usersService.findUserByUsername(payload.username);
    const token = await this.loginWithCredentials(user);
    return token;
  }
}
