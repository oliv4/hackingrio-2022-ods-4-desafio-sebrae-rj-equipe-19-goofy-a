import {
  Column,
  Entity,
  CreateDateColumn,
  UpdateDateColumn,
  PrimaryGeneratedColumn,
  OneToMany,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { CompaniesEntity } from '../companies/companies.entity';
import { EventChallengesEntity } from './event-challenges.entity';

@Entity('events')
export class EventsEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ nullable: false })
  public title: string;

  @Column({ type: 'text', nullable: false })
  public description: string;

  @Column({ name: 'metaverse_link', nullable: false })
  public metaverseLink: string;

  @Column({ name: 'finished_at', type: 'timestamptz', nullable: false })
  public finishedAt: Date;

  @Column({ name: 'sponsor_id', type: 'uuid', nullable: false })
  public sponsorId: string;

  @Column({ name: 'badge_uri', nullable: true })
  public badgeUri: string;

  @Column({ name: 'banner_url', nullable: true })
  public bannerUrl: string;

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

  @ManyToOne(() => CompaniesEntity, (company) => company.sponsoredEvents)
  @JoinColumn({ name: 'sponsor_id' })
  sponsor: CompaniesEntity;

  @OneToMany(() => EventChallengesEntity, (challenge) => challenge.event)
  challenges: EventChallengesEntity[];
}
