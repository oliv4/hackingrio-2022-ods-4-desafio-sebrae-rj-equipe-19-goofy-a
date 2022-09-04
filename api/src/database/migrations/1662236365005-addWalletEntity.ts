import {MigrationInterface, QueryRunner} from "typeorm";

export class addWalletEntity1662236365005 implements MigrationInterface {
    name = 'addWalletEntity1662236365005'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "wallets" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "address" character(42) NOT NULL, "private_key" character varying(255), "public_key" character varying(255), "mnemonic" character varying, "user_id" uuid NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "REL_92558c08091598f7a4439586cd" UNIQUE ("user_id"), CONSTRAINT "PK_8402e5df5a30a229380e83e4f7e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE UNIQUE INDEX "wallet_address_idx" ON "wallets" ("address") `);
        await queryRunner.query(`ALTER TABLE "users" ADD "wallet_id" uuid`);
        await queryRunner.query(`ALTER TABLE "users" ADD CONSTRAINT "UQ_67abb81dc33e75d1743323fd5db" UNIQUE ("wallet_id")`);
        await queryRunner.query(`ALTER TABLE "users" ADD CONSTRAINT "FK_67abb81dc33e75d1743323fd5db" FOREIGN KEY ("wallet_id") REFERENCES "wallets"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "wallets" ADD CONSTRAINT "FK_92558c08091598f7a4439586cda" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "wallets" DROP CONSTRAINT "FK_92558c08091598f7a4439586cda"`);
        await queryRunner.query(`ALTER TABLE "users" DROP CONSTRAINT "FK_67abb81dc33e75d1743323fd5db"`);
        await queryRunner.query(`ALTER TABLE "users" DROP CONSTRAINT "UQ_67abb81dc33e75d1743323fd5db"`);
        await queryRunner.query(`ALTER TABLE "users" DROP COLUMN "wallet_id"`);
        await queryRunner.query(`DROP INDEX "public"."wallet_address_idx"`);
        await queryRunner.query(`DROP TABLE "wallets"`);
    }

}
