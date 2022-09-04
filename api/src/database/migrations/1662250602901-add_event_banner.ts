import {MigrationInterface, QueryRunner} from "typeorm";

export class addEventBanner1662250602901 implements MigrationInterface {
    name = 'addEventBanner1662250602901'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "events" ADD "banner_url" character varying`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "events" DROP COLUMN "banner_url"`);
    }

}
