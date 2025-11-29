-- CreateEnum
CREATE TYPE "TipoUsuario" AS ENUM ('ALUNO', 'PROFISSIONAL');

-- CreateEnum
CREATE TYPE "StatusUsuario" AS ENUM ('ATIVO', 'INATIVO');

-- CreateEnum
CREATE TYPE "StatusAluno" AS ENUM ('REGULAR', 'TRANCADO', 'FORMADO');

-- CreateEnum
CREATE TYPE "Especialidade" AS ENUM ('PSICOLOGIA', 'PEDAGOGIA', 'ASSISTENCIA_SOCIAL', 'OUTRO');

-- CreateEnum
CREATE TYPE "TipoAtendimento" AS ENUM ('PRESENCIAL', 'ONLINE');

-- CreateEnum
CREATE TYPE "StatusAtendimento" AS ENUM ('AGENDADO', 'CONCLUIDO', 'CANCELADO');

-- CreateEnum
CREATE TYPE "CanalNotificacao" AS ENUM ('WHATSAPP', 'EMAIL');

-- CreateEnum
CREATE TYPE "StatusEnvio" AS ENUM ('ENVIADO', 'FALHA', 'PENDENTE');

-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "senha_hash" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "telefone_wpp" TEXT,
    "tipo" "TipoUsuario" NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alunos" (
    "id_aluno" SERIAL NOT NULL,
    "matricula" TEXT NOT NULL,
    "curso" TEXT NOT NULL,
    "periodo" INTEGER NOT NULL,
    "status" "StatusAluno" NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "alunos_pkey" PRIMARY KEY ("id_aluno")
);

-- CreateTable
CREATE TABLE "profissionais" (
    "id_profissional" SERIAL NOT NULL,
    "especialidade" "Especialidade" NOT NULL,
    "registro" TEXT NOT NULL,
    "disponibilidade" TEXT,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "profissionais_pkey" PRIMARY KEY ("id_profissional")
);

-- CreateTable
CREATE TABLE "atendimentos" (
    "id" SERIAL NOT NULL,
    "data_hora" TIMESTAMP(3) NOT NULL,
    "duracao_minutos" INTEGER NOT NULL,
    "tipo" "TipoAtendimento" NOT NULL,
    "status" "StatusAtendimento" NOT NULL,
    "resumo_aluno" TEXT,
    "observacoes_sigilo" TEXT,
    "id_aluno" INTEGER NOT NULL,
    "id_profissional" INTEGER NOT NULL,

    CONSTRAINT "atendimentos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificacoes" (
    "id" SERIAL NOT NULL,
    "canal" "CanalNotificacao" NOT NULL,
    "tempo_antecedencia_min" INTEGER,
    "mensagem_template" TEXT NOT NULL,
    "data_envio" TIMESTAMP(3),
    "status_envio" "StatusEnvio" NOT NULL,
    "id_atendimento" INTEGER NOT NULL,
    "id_usuario_destino" INTEGER NOT NULL,

    CONSTRAINT "notificacoes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "alunos_matricula_key" ON "alunos"("matricula");

-- CreateIndex
CREATE UNIQUE INDEX "alunos_id_usuario_key" ON "alunos"("id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "profissionais_id_usuario_key" ON "profissionais"("id_usuario");

-- CreateIndex
CREATE UNIQUE INDEX "notificacoes_id_atendimento_key" ON "notificacoes"("id_atendimento");

-- AddForeignKey
ALTER TABLE "alunos" ADD CONSTRAINT "alunos_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profissionais" ADD CONSTRAINT "profissionais_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "atendimentos" ADD CONSTRAINT "atendimentos_id_aluno_fkey" FOREIGN KEY ("id_aluno") REFERENCES "alunos"("id_aluno") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "atendimentos" ADD CONSTRAINT "atendimentos_id_profissional_fkey" FOREIGN KEY ("id_profissional") REFERENCES "profissionais"("id_profissional") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificacoes" ADD CONSTRAINT "notificacoes_id_atendimento_fkey" FOREIGN KEY ("id_atendimento") REFERENCES "atendimentos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificacoes" ADD CONSTRAINT "notificacoes_id_usuario_destino_fkey" FOREIGN KEY ("id_usuario_destino") REFERENCES "usuarios"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
