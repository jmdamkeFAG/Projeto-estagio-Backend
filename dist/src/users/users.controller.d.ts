import { UsersService } from './users.service';
import { Prisma } from '@prisma/client';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    create(data: Prisma.USUARIOCreateInput): Promise<{
        email: string;
        senha_hash: string;
        nome: string;
        telefone_wpp: string | null;
        tipo: import("@prisma/client").$Enums.TipoUsuario;
        ativo: boolean;
        id: number;
    }>;
    findAll(): Promise<{
        email: string;
        nome: string;
        tipo: import("@prisma/client").$Enums.TipoUsuario;
        ativo: boolean;
        id: number;
    }[]>;
    getProfile(req: any): any;
}
