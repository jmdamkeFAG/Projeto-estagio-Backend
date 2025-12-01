import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  
  async createUser(data: Prisma.USUARIOCreateInput) {
    
    const hashedPassword = await bcrypt.hash(data.senha_hash, 10);

    return this.prisma.uSUARIO.create({
      data: {
        ...data,
        senha_hash: hashedPassword, 
      },
    });
  }

 
  async findAllUsers() {
    return this.prisma.uSUARIO.findMany({
      select: { 
        id: true,
        nome: true,
        email: true,
        tipo: true,
        ativo: true,
      }
    });
  }

  async findByEmail(email: string) {
    return this.prisma.uSUARIO.findUnique({
      where: { email },
    });
  }
}