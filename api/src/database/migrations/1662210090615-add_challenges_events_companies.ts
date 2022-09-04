import {MigrationInterface, QueryRunner} from "typeorm";

export class addChallengesEventsCompanies1662210090615 implements MigrationInterface {
    name = 'addChallengesEventsCompanies1662210090615'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "companies" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "name" character varying NOT NULL, "logo" character varying, "is_active" boolean NOT NULL DEFAULT true, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "UQ_3dacbb3eb4f095e29372ff8e131" UNIQUE ("name"), CONSTRAINT "PK_d4bc3e82a314fa9e29f652c2c22" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "events" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "title" character varying NOT NULL, "description" text NOT NULL, "metaverse_link" character varying NOT NULL, "finished_at" TIMESTAMP WITH TIME ZONE NOT NULL, "sponsor_id" uuid NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_40731c7151fe4be3116e45ddf73" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TYPE "public"."event-challenges_challenge_type_enum" AS ENUM('quiz')`);
        await queryRunner.query(`CREATE TABLE "event-challenges" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "challenge_id" uuid NOT NULL, "challenge_type" "public"."event-challenges_challenge_type_enum" NOT NULL, "event_id" uuid NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "UQ_dbf4ba37c3bd4e8d069f130305b" UNIQUE ("challenge_id"), CONSTRAINT "PK_283399258590bfc46d42ad2f01c" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "events" ADD CONSTRAINT "FK_4bf6443bde7ff6efdc4aafe3b42" FOREIGN KEY ("sponsor_id") REFERENCES "companies"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "event-challenges" ADD CONSTRAINT "FK_a745d5650fb5ede847335c7b184" FOREIGN KEY ("event_id") REFERENCES "events"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "event-challenges" DROP CONSTRAINT "FK_a745d5650fb5ede847335c7b184"`);
        await queryRunner.query(`ALTER TABLE "events" DROP CONSTRAINT "FK_4bf6443bde7ff6efdc4aafe3b42"`);
        await queryRunner.query(`DROP TABLE "event-challenges"`);
        await queryRunner.query(`DROP TYPE "public"."event-challenges_challenge_type_enum"`);
        await queryRunner.query(`DROP TABLE "events"`);
        await queryRunner.query(`DROP TABLE "companies"`);
    }

}
