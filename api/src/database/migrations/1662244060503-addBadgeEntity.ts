import {MigrationInterface, QueryRunner} from "typeorm";

export class addBadgeEntity1662244060503 implements MigrationInterface {
    name = 'addBadgeEntity1662244060503'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "badges" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "user_id" uuid NOT NULL, "ref" uuid NOT NULL, "tx" character(66), "nftid" integer, "issued_at" TIMESTAMP WITH TIME ZONE, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_8a651318b8de577e8e217676466" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "badge_user_id_index" ON "badges" ("user_id") `);
        await queryRunner.query(`CREATE UNIQUE INDEX "badge_tx_idx" ON "badges" ("tx") `);
        await queryRunner.query(`CREATE UNIQUE INDEX "badge_nft_idx" ON "badges" ("nftid") `);
        await queryRunner.query(`ALTER TABLE "events" ADD "badge_uri" character varying`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "events" DROP COLUMN "badge_uri"`);
        await queryRunner.query(`DROP INDEX "public"."badge_nft_idx"`);
        await queryRunner.query(`DROP INDEX "public"."badge_tx_idx"`);
        await queryRunner.query(`DROP INDEX "public"."badge_user_id_index"`);
        await queryRunner.query(`DROP TABLE "badges"`);
    }

}
