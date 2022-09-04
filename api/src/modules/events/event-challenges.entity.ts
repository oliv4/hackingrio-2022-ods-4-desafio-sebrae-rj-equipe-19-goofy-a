import {
  Column,
  Entity,
  CreateDateColumn,
  UpdateDateColumn,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { ChallengeTypes } from './challenge-types.enum';
import { EventsEntity } from './events.entity';

@Entity('event-challenges')
export class EventChallengesEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ name: 'challenge_id', type: 'uuid', nullable: false, unique: true })
  public challengeId: string;

  @Column({
    name: 'challenge_type',
    type: 'enum',
    enum: ChallengeTypes,
    nullable: false,
  })
  public challengeType: ChallengeTypes;

  @Column({ name: 'event_id', type: 'uuid', nullable: false })
  public eventId: string;

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

  @ManyToOne(() => EventsEntity, (event) => event.challenges)
  @JoinColumn({ name: 'event_id' })
  event: EventsEntity;
}
