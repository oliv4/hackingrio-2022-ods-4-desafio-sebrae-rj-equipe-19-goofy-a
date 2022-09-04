import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('badges')
export class BadgesEntity {
  @PrimaryGeneratedColumn('uuid')
  public id: string;

  @Column({ name: 'user_id', type: 'uuid', nullable: false })
  @Index('badge_user_id_index', { unique: false })
  public userId: string;

  @Column({ name: 'ref', type: 'uuid', nullable: false })
  public ref: string;

  @Column({ type: 'char', length: 66, nullable: true, default: null })
  @Index('badge_tx_idx', { unique: true })
  public tx: string;

  @Column({ nullable: true, default: null })
  @Index('badge_nft_idx', { unique: true })
  public nftid: number;

  @Column({ name: 'issued_at', type: 'timestamptz', nullable: true })
  public issuedAt: Date;

  @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
  public createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz', nullable: true })
  public updatedAt: Date;
}
