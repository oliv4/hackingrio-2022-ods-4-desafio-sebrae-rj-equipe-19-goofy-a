import {
  Column,
  Entity,
  CreateDateColumn,
  UpdateDateColumn,
  PrimaryGeneratedColumn,
  OneToMany,
} from 'typeorm';
import { QuizQuestionModel } from '../models/questions.model';
import { QuizAnswersEntity } from './quiz-answers.entity';

@Entity('quiz')
export class QuizEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ type: 'varchar', nullable: false })
  public title: string;

  @Column({ type: 'text', nullable: true })
  public description: string;

  @Column({ type: 'jsonb', nullable: false })
  public questions: QuizQuestionModel[];

  @Column({ name: 'finished_at', type: 'timestamptz', nullable: false })
  public finishedAt: Date;

  @Column({
    name: 'is_active',
    type: 'boolean',
    default: true,
    nullable: false,
  })
  public isActive: boolean;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  public createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz', nullable: true })
  public updatedAt: Date;

  @OneToMany(() => QuizAnswersEntity, (quizAnswer) => quizAnswer.quiz)
  quizAnswers: QuizAnswersEntity[];
}
