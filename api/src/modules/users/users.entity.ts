import {
  Column,
  Entity,
  CreateDateColumn,
  UpdateDateColumn,
  PrimaryGeneratedColumn,
  OneToMany,
  OneToOne,
  JoinColumn,
} from 'typeorm';
import { QuizAnswersEntity } from '../quiz/entities/quiz-answers.entity';
import { WalletsEntity } from '../blockchain/wallets.entity';

@Entity('users')
export class UsersEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ name: 'username', type: 'varchar', unique: true, nullable: false })
  public username: string;

  @Column({ name: 'password', type: 'varchar', nullable: false })
  public password: string;

  @Column({ name: 'wallet_id', type: 'uuid', nullable: true })
  public walletId: string;

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

  @OneToMany(() => QuizAnswersEntity, (quizAnswer) => quizAnswer.user)
  quizAnswers: QuizAnswersEntity[];

  @OneToOne(() => WalletsEntity, (wallet) => wallet.user)
  @JoinColumn({ name: 'wallet_id' })
  wallet: WalletsEntity;
}
