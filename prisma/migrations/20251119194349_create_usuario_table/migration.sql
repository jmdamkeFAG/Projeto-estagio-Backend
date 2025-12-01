/*
  Warnings:

  - The primary key for the `USUARIO` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `USUARIO` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "USUARIO" DROP CONSTRAINT "USUARIO_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ALTER COLUMN "tipo" SET DEFAULT 'ALUNO',
ADD CONSTRAINT "USUARIO_pkey" PRIMARY KEY ("id");
