import { Controller, Get, Post, Body, UseGuards, Request } from '@nestjs/common';
import { UsersService } from './users.service';
import { AuthGuard } from '@nestjs/passport';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { TipoUsuario, Prisma } from '@prisma/client';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  async create(@Body() data: Prisma.USUARIOCreateInput) {
    return this.usersService.createUser(data);
  }

  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles(TipoUsuario.ADMIN)
  @Get()
  async findAll() {
    return this.usersService.findAllUsers();
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('profile')
  getProfile(@Request() req) {
    
    return req.user;
  }

}
