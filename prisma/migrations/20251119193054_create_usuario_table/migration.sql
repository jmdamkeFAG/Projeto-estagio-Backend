-- CreateEnum
CREATE TYPE "TipoUsuario" AS ENUM ('ADMIN', 'ALUNO', 'PROFISSIONAL');

-- CreateTable
CREATE TABLE "USUARIO" (
    "id" TEXT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "senha_hash" VARCHAR(255) NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "telefone_wpp" VARCHAR(20),
    "tipo" "TipoUsuario" NOT NULL DEFAULT 'ADMIN',
    "ativo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "USUARIO_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "USUARIO_email_key" ON "USUARIO"("email");
