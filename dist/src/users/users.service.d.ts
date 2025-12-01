import { PrismaService } from '../../prisma/prisma.service';
import { Prisma } from '@prisma/client';
export declare class UsersService {
    private prisma;
    constructor(prisma: PrismaService);
    createUser(data: Prisma.USUARIOCreateInput): Promise<{
        email: string;
        senha_hash: string;
        nome: string;
        telefone_wpp: string | null;
        tipo: import("@prisma/client").$Enums.TipoUsuario;
        ativo: boolean;
        id: number;
    }>;
    findAllUsers(): Promise<{
        email: string;
        nome: string;
        tipo: import("@prisma/client").$Enums.TipoUsuario;
        ativo: boolean;
        id: number;
    }[]>;
    findByEmail(email: string): Promise<{
        email: string;
        senha_hash: string;
        nome: string;
        telefone_wpp: string | null;
        tipo: import("@prisma/client").$Enums.TipoUsuario;
        ativo: boolean;
        id: number;
    } | null>;
}
