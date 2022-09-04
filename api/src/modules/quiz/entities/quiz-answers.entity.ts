import {
  Column,
  Entity,
  CreateDateColumn,
  UpdateDateColumn,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { UsersEntity } from '../../users/users.entity';
import { QuizQuestionAnswerModel } from '../models/answers.model';
import { QuizEntity } from './quiz.entity';

@Entity('quiz_answers')
export class QuizAnswersEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ type: 'jsonb', nullable: false })
  public answers: QuizQuestionAnswerModel[];

  @Column({ nullable: false })
  public score: number;

  @Column({ name: 'user_id', type: 'uuid', nullable: false })
  public userId: string;

  @Column({ name: 'quiz_id', type: 'uuid', nullable: false })
  public quizId: string;

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

  @ManyToOne(() => UsersEntity, (user) => user.quizAnswers)
  @JoinColumn({ name: 'user_id' })
  user: UsersEntity;

  @ManyToOne(() => QuizEntity, (quiz) => quiz.quizAnswers)
  @JoinColumn({ name: 'quiz_id' })
  quiz: QuizEntity;
}
