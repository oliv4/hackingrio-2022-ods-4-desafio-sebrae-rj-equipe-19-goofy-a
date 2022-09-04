import {MigrationInterface, QueryRunner} from "typeorm";

export class addQuizAnswers1662174183821 implements MigrationInterface {
    name = 'addQuizAnswers1662174183821'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "quiz_answers" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "answers" jsonb NOT NULL, "score" integer NOT NULL, "user_id" uuid NOT NULL, "quiz_id" uuid NOT NULL, "is_active" boolean NOT NULL DEFAULT true, "created_at" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(), "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT now(), CONSTRAINT "PK_3fefbc8a840a41b6a15a4f9ca5e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "quiz_answers" ADD CONSTRAINT "FK_75b4c4f7147275949808e703e9e" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "quiz_answers" ADD CONSTRAINT "FK_c6e54b7f136d2d046f9778d8eb7" FOREIGN KEY ("quiz_id") REFERENCES "quiz"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "quiz_answers" DROP CONSTRAINT "FK_c6e54b7f136d2d046f9778d8eb7"`);
        await queryRunner.query(`ALTER TABLE "quiz_answers" DROP CONSTRAINT "FK_75b4c4f7147275949808e703e9e"`);
        await queryRunner.query(`DROP TABLE "quiz_answers"`);
    }

}
